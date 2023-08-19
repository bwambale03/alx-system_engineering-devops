# Install Nginx package
package { 'nginx':
  ensure => present,
}

# Configure Nginx
file { '/var/www/html/index.html':
  content => 'Hello World!',
  ensure  => file,
}

file { '/etc/nginx/sites-available/default':
  content => "
    server {
      listen 80 default_server;
      listen [::]:80 default_server;
    
      root /var/www/html;
      index index.html;
    
      location / {
        try_files \$uri \$uri/ =404;
      }
    
      location /redirect_me {
        return 301 'https://www.youtube.com/watch?v=QH2-TGUlwu4';
      }
    }
  ",
  notify  => Service['nginx'],
}

# Enable the default site
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
}

# Restart Nginx service
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}

# Test Nginx configuration
exec { 'nginx-config-test':
  command => '/usr/sbin/nginx -t',
  require => Service['nginx'],
}

