# Use the latest Ubuntu image as the base
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Expose port 80 for HTTP traffic
EXPOSE 80

# Update package lists, install necessary packages, and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nginx \
    wget \
    tree \
    curl \
    vim \
    unzip \
    supervisor \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy custom nginx configuration file (if you have one)
# COPY nginx.conf /etc/nginx/nginx.conf

# Create a directory for logs and set up Supervisor
RUN mkdir -p /var/log/supervisor && \
    mkdir -p /usr/share/nginx/html

# Add a simple HTML file to serve with Nginx
RUN echo "<html><body><h1>Welcome to Your Nginx Server!</h1></body></html>" > /usr/share/nginx/html/index.html

# Set up Supervisor to manage Nginx and other services
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Command to run Supervisor, which will manage Nginx and other processes
CMD ["/usr/bin/supervisord"]

# Healthcheck to ensure Nginx is running
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost/ || exit 1
