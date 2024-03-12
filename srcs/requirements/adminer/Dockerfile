# Use Debian Bullseye as the base image
FROM debian:bullseye

# Install Apache, PHP, and required PHP extensions
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mysql php-pdo php-gd wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable Apache mods.
RUN a2enmod php7.4
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i 's/short_open_tag = Off/short_open_tag = On/' /etc/php/7.4/apache2/php.ini
RUN sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT/' /etc/php/7.4/apache2/php.ini
RUN sed -i 's/display_errors = Off/display_errors = On/' /etc/php/7.4/apache2/php.ini

# Download Adminer
RUN wget "https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php" -O /var/www/html/index.php

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Manually set up the Apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# Set working directory
WORKDIR /var/www/html

# By default, expose port 8080
EXPOSE 8080

# By default start up Apache in the foreground, override with /bin/bash for interactive.
CMD ["apache2ctl", "-D", "FOREGROUND"]
