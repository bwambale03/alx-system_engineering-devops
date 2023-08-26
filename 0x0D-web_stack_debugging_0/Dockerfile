# Use an existing base image
FROM ubuntu:20.04

# Run commands during image build
RUN apt-get update && apt-get install -y nginx \
    systemd systemd-sysv dbus dbus-user-session
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# Start nginx when a container is run from this image
CMD ["nginx", "-g", "daemon off;"]

