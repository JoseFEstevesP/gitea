FROM nginx:stable-alpine

# Copy the main configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the modular configuration files
COPY conf.d/ /etc/nginx/conf.d/

# Copy SSL certificates
COPY ssl/nginx-selfsigned.crt /etc/nginx/ssl/nginx-selfsigned.crt
COPY ssl/nginx-selfsigned.key /etc/nginx/ssl/nginx-selfsigned.key

