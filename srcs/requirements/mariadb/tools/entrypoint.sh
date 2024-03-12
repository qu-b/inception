#!/bin/bash

# Initialize MariaDB data directory
echo "Initializing MariaDB data directory..."
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Start the MariaDB server in the background
echo "Starting MariaDB server..."
mysqld_safe --nowatch --skip-networking &

# Wait for MariaDB to be ready
echo "Waiting for MariaDB server to start..."
while ! mysqladmin ping --silent; do
    sleep 1
done

echo "MariaDB server is ready. Performing initial setup..."

# Run the setup commands
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Shutdown MariaDB server that was started for initialization
echo "Initialization complete. Restarting MariaDB server..."
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Start the MariaDB server in the foreground
echo "Starting MariaDB server in foreground..."
exec mysqld_safe
