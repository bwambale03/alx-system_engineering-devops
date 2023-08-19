#!/bin/bash

# Check if Nginx is active
if sudo systemctl is-active nginx &>/dev/null; then
  echo "Nginx is already active."
else
  echo "Starting Nginx..."
  sudo systemctl start nginx
  echo "Nginx started."
fi

# Check if ufw is installed
if ! command -v ufw &>/dev/null; then
  echo "ufw is not installed. Install it using 'sudo apt install ufw' or your package manager."
  exit 1
fi

# Check if ufw is active
if sudo ufw status | grep -q "Status: active"; then
  echo "ufw is active."
  echo "Allowing traffic on ports 80 (HTTP) and 443 (HTTPS)..."
  sudo ufw allow 'Nginx HTTP'
  sudo ufw allow 'Nginx HTTPS'
  echo "Traffic on ports 80 and 443 allowed."
else
  echo "ufw is not active. Please activate ufw first."
fi
