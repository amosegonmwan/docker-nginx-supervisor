# Dockerized Nginx Server with Supervisor

This repository contains a Docker setup that provisions an Nginx web server using a Docker container based on the latest Ubuntu image. Supervisor is used to manage the Nginx process, ensuring that it runs continuously inside the container.

## Files in this Repository

### `Dockerfile`
The `Dockerfile` outlines the steps to create the Docker image for the Nginx server:

- **Base Image**: The image starts with the latest Ubuntu base image.
- **Environment Variable**: The `DEBIAN_FRONTEND` is set to `noninteractive` to avoid interactive prompts during package installation.
- **Port Exposure**: Port 80 is exposed for HTTP traffic.
- **Package Installation**: Essential packages such as Nginx, wget, tree, curl, vim, unzip, and Supervisor are installed.
- **Directory Setup**: Directories for Nginx and Supervisor logs are created.
- **Simple HTML File**: A basic HTML file is added to the default Nginx directory to serve as the landing page.
- **Supervisor Setup**: Supervisor is configured to manage Nginx, ensuring it starts and restarts automatically if needed.
- **Healthcheck**: A health check is defined to ensure Nginx is running properly within the container.

### `supervisord.conf`
The `supervisord.conf` file is a configuration file for Supervisor. It includes:

- **Supervisor Settings**: Configured to run in the foreground (`nodaemon=true`).
- **Nginx Program Configuration**: Nginx is managed as a program by Supervisor, with logs directed to specific files and automatic restart enabled if the process fails.

## How to Use

1. **Build the Docker Image**:
   ```bash
   docker image build -t nginx-supervisor .
   ```

2. **Run the Container:**:
   ```bash
   docker container run -d --name nginx-container -p 8080:80 -d nginx-supervisor
   ```

3. **Access the Nginx Server:** Open a browser and navigate to `http://localhost` to see the "Welcome to Your Nginx Server!" page.
