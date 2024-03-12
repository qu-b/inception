#!/bin/bash

# Wait for MySQL to be available
while ! mysql -h $DB_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE &>/dev/null; do
  sleep 3
done

echo "Successfully connected to MariaDB!"

# Create necessary directories and files for PHP-FPM
mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid;

# If WordPress is not set up yet, set it up
if [ ! -f /var/www/html/wp-config.php ]; then
  chown -R www-data:www-data /var/www/*
  chmod -R 755 /var/www/*
  mkdir -p /var/www/html
  
  # Download wp-cli if not present
  if [ ! -f /usr/local/bin/wp ]; then
      wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
      chmod +x wp-cli.phar
      mv wp-cli.phar /usr/local/bin/wp
  fi
  
  cd /var/www/html || exit
  wp core download --allow-root
  wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
  wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
  wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
  wp user add-cap $WP_USR 'moderate_comments' --allow-root
  wp user add-cap $WP_USR 'approve_comments' --allow-root
  sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define('WP_REDIS_HOST', 'redis');" /var/www/html/wp-config.php
  # Check if Redis Object Cache plugin is installed and active
  if ! wp plugin is-installed redis-cache --allow-root; then
      wp plugin install redis-cache --activate --allow-root
  fi

  # Enable Redis Cache
  wp redis enable --allow-root
fi



# Execute passed in command
exec "$@"
