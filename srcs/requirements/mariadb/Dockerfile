# Use Debian Bullseye as the base image
FROM debian:bullseye

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

# Set environment variables from arguments
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

# Install MariaDB server
RUN apt-get update && \
	apt-get install -y mariadb-server && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Copy over custom MariaDB configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/entrypoint.sh /tmp/entrypoint.sh

# Make the script executable
RUN chmod +x /tmp/entrypoint.sh

# Set the entrypoint script as the entrypoint
ENTRYPOINT ["/tmp/entrypoint.sh"]

# Expose the MariaDB port
EXPOSE 3306
