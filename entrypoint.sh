#!/bin/sh

# Substitute environment variables in nginx.conf template
envsubst '${SERVICE_NAME} ${BACKEND_HOST} ${COLLECTOR_HOST}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start NGINX
nginx -g 'daemon off;'

