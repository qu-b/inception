# Use Debian Bullseye as a base image
FROM debian:bullseye

# Define build-time arguments
ARG FTP_USER
ARG FTP_PASSWORD

# Install vsftpd
RUN apt-get update && \
    apt-get install -y vsftpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for FTP users
RUN mkdir -p /home/ftpusers && \
    chmod -R 755 /home/ftpusers

RUN mkdir -p /var/run/vsftpd/empty && \
    chmod -R 755 /var/run/vsftpd/empty

# Configure vsftpd
COPY ./conf/vsftpd.conf /etc/vsftpd.conf

# Add a user for FTP access
RUN useradd -m ${FTP_USER} && \
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

# Expose the FTP port (21)
EXPOSE 21

# Start the vsftpd server when the container runs
CMD ["vsftpd"]
