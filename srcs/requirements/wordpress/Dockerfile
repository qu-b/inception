# Use Debian Bullseye as a base image
FROM debian:bullseye

# Install required system packages and PHP extensions
RUN apt-get update && \
	apt-get install -y \
	php-cli \
	php-mysqli \
	php-fpm \
	wget \
	mariadb-client \
	ca-certificates && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Prepare PHP-FPM
RUN mkdir -p /run/php && chown www-data:www-data /run/php

RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Copy custom pool configuration for PHP-FPM
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Copy startup script
COPY tools/startup-script.sh /startup-script.sh
RUN chmod +x /startup-script.sh

# Expose the PHP-FPM port
EXPOSE 9000

# Set the entrypoint
ENTRYPOINT ["/startup-script.sh"]

# CMD to run php-fpm in foreground mode
CMD ["/usr/sbin/php-fpm7.4", "--nodaemonize"]
