# Debian Bullseye as the base image
FROM debian:bullseye

# Install restic and any other required dependencies
RUN apt-get update && apt-get install -y restic && apt-get clean

# Set working directory
WORKDIR /backup

# Add script to automate backup tasks
COPY backup-script.sh /backup/

# Make the script executable
RUN chmod +x /backup/backup-script.sh

# Set the entry point to run the backup script
ENTRYPOINT ["/backup/backup-script.sh"]
