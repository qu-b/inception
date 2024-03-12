# Use Debian Bullseye as a base image
FROM debian:bullseye

# Install Redis
RUN apt-get update && \
    apt-get install -y redis-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the default Redis port (6379)
EXPOSE 6379

# Start the Redis server when the container runs
CMD ["redis-server"]
