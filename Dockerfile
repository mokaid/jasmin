# Use the official Python 3.11 slim image from the Docker Hub
FROM python:3.11-slim

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    libffi-dev \
    libssl-dev \
    python3-dev \
    python3-pip \
    redis-server \
    rabbitmq-server

# Install Jasmin SMS Gateway using pip
RUN pip3 install jasmin

# Copy the configuration files to the container
COPY ./config /etc/jasmin

# Expose the necessary ports for SMPP, HTTP, and Jasmin CLI
EXPOSE 2775 8990 1401

# Start the necessary services
CMD service redis-server start && \
    service rabbitmq-server start && \
    jasmind start && \
    tail -f /var/log/jasmin/*.log
