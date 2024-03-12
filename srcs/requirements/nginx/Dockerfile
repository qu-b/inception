# Use Debian Bullseye as a base image
FROM debian:bullseye

# Install NGINX and SSL tools
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y nginx openssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Create SSL directory
RUN mkdir -p /etc/nginx/ssl

# Create a self-signed SSL certificate
RUN openssl req -newkey rsa:4096 -days 42 -nodes -x509 \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42Lausanne/CN=qu-b.42lausanne.ch/UID=qu-b"

# Copy nginx configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Adjust permissions for the web root
RUN chmod 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html

# Expose port 443 for HTTPS
EXPOSE 443

# Start NGINX with foreground mode
CMD ["nginx", "-g", "daemon off;"]
