#!/bin/bash

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Install Nginx if not already installed
if ! command -v nginx &> /dev/null; then
    apt-get update
    apt-get install -y nginx
fi

# Create a custom 404 page
echo "Ceci n'est pas une page" > /var/www/html/custom_404.html

# Configure Nginx
cat > /etc/nginx/sites-available/default <<EOF
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/html;
  index index.html;

  location / {
    try_files \$uri \$uri/ =404;
  }

  location = /404.html {
    internal;
    root /var/www/html;
  }

  error_page 404 /404.html;
}
EOF

# Create a symlink to enable the site if it doesn't exist
if [ ! -L /etc/nginx/sites-enabled/default ]; then
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
fi

# Restart Nginx service
service nginx restart

# Display Nginx status
echo "Nginx status:"
service nginx status

# Enable Nginx to start on boot
systemctl enable nginx

# Start Nginx
systemctl start nginx

# Display Nginx status again
echo "Nginx status after enabling and starting:"
systemctl status nginx

# Test Nginx configuration and reload
nginx -t
systemctl reload nginx

echo "Nginx configuration and setup completed."

