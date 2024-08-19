# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables to avoid Python buffering issues
ENV PYTHONUNBUFFERED 1

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    libffi-dev \
    libssl-dev \
    python-dev \
    python-pip \
    redis-server \
    rabbitmq-server

# Install Jasmin SMS Gateway
RUN curl -s https://setup.jasminsms.com/deb | bash && \
    apt-get install -y jasmin-sms-gateway

# Expose necessary ports
EXPOSE 2775 8990 1401

# Create a directory for Jasmin
RUN mkdir -p /etc/jasmin

# Set up the entry point
ENTRYPOINT ["jasmind.py"]

# Start Jasmin service
CMD ["-l", "/var/log/jasmin/jasmin.log"]
