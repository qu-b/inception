# Use a Debian image
FROM debian:bullseye

# Install NGINX
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Create a directory for HTML file
RUN mkdir -p /usr/share/nginx/html

# Copy HTML file to the NGINX directory
COPY Rotating3D42.html /usr/share/nginx/html/index.html

# Change permissions for HTML file
RUN chmod 777 /usr/share/nginx/html/index.html

# Copy custom NGINX config file into the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose the port NGINX is listening on
EXPOSE 8081

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
