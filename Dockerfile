# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install necessary packages and dependencies
RUN apt-get update && \
    apt-get install -y \
    gnupg2 \
    lsb-release \
    ca-certificates \
    curl \
    software-properties-common

# Add the NGINX official repository and install NGINX
RUN curl -fsSL https://nginx.org/keys/nginx_signing.key -o /etc/apt/trusted.gpg.d/nginx_signing.asc && \
    add-apt-repository "deb http://nginx.org/packages/ubuntu/ focal nginx" && \
    apt-get update && \
    apt-get install -y nginx=1.18.0-6ubuntu14.5

# Add Traceable AI repository and install the agent
RUN curl -fsSL https://app.traceable.ai/install/nginx/install.sh | bash

# Install Traceable AI agent for NGINX
RUN apt-get update
RUN apt-get install -y ca-certificates
RUN apt-get install -y gettext-base
RUN echo "deb [trusted=yes] https://packages.traceable.ai/ubuntu/ focal main" | tee -a /etc/apt/sources.list.d/traceable.list
RUN apt-get update
RUN apt-get install -y nginx-module-traceable-1.18.0

# Copy NGINX configuration template and entrypoint script
COPY nginx.conf /etc/nginx/nginx.conf.template
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose port 80
EXPOSE 80

# Set the entrypoint to the custom script
ENTRYPOINT ["/entrypoint.sh"]

