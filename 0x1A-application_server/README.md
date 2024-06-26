# Application Server Configuration

This repository contains scripts and configuration files for setting up an application server, including creating SSH key pairs and configuring Nginx.

## Directory Structure

- `0-transfer_file`: Contains scripts or instructions for transferring files to the server.
- `1-create_ssh_key_pair`: Contains scripts or instructions for creating SSH key pairs.
- `2-app_server-nginx_config`: Contains configuration files for setting up Nginx on the application server.
- `3-app_server-nginx_config`: Duplicate directory for additional or backup configuration files for Nginx setup.

## Usage

### 0-transfer_file

Instructions for transferring files to the server can be found in this directory. Typically, this might involve using `scp` or `rsync` commands.

### 1-create_ssh_key_pair

Scripts or instructions for generating SSH key pairs are available here. To create a new SSH key pair, you might use a command like:
```bash
ssh-keygen -t rsa -b 4096 -C "bwambaleedwin03@gmail.com"

