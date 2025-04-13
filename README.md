# KASM SimpleX Chat Desktop Workspace
[![Docker Pulls](https://img.shields.io/docker/pulls/williamsct1/kasm-simplex)](https://hub.docker.com/r/williamsct1/kasm-simplex)
[![Docker Image Size](https://img.shields.io/docker/image-size/williamsct1/kasm-simplex/latest)](https://hub.docker.com/r/williamsct1/kasm-simplex)
[![Docker Image Version](https://img.shields.io/docker/v/williamsct1/kasm-simplex/latest)](https://hub.docker.com/r/williamsct1/kasm-simplex/tags)

## Container Registry
The pre-built container image is available on Docker Hub:
- [williamsct1/kasm-simplex](https://hub.docker.com/r/williamsct1/kasm-simplex)
- Latest version: `docker pull williamsct1/kasm-simplex:latest`

## Description
This project provides a custom KASM workspace for running SimpleX Chat Desktop in a containerized environment. It offers a secure, isolated environment for private and secure end-to-end encrypted messaging through a web browser.

## Why Use KASM for SimpleX Chat?
### Enhanced Privacy and Security
- Isolated environment for your communications
- Access SimpleX Chat Desktop remotely through a web browser
- Enhanced security through containerization
- Full end-to-end encryption with no phone number or email required

### Convenient Web Access
- Access SimpleX Chat Desktop from any browser
- No local installation required on your device
- Consistent environment across different machines
- Use the full desktop experience with all features

## Features
- Full SimpleX Chat functionality
- Secure, containerized environment
- Web-based access through KASM
- Persistent storage for chat data
- Easy to deploy and use

## Quick Start: Using Pre-built Image
### Prerequisites
- A running KASM Workspaces installation
- Admin access to your KASM Workspaces instance

### Installation Steps
1. Log into your KASM Workspaces admin interface
2. Navigate to Workspaces
   - Click on "Workspaces" in the left sidebar
   - Click the "Add Workspace" button
3. Configure the New Workspace Details
   - **Workspace Type**: Container
   - **Friendly Name**: SimpleX Chat
   - **Description**: Secure private messaging environment
   - **Docker Image**: williamsct1/kasm-simplex:latest
   - **Docker Registry**: https://index.docker.io/v1/
   - **Persistent Profile Path**: `/mnt/kasm_profiles/{image_id}/{user_id}`
   - Click "Save"

## Building Your Own Image
### Prerequisites
- Docker installed on your system
- Git for cloning the repository

### Building Steps
1. Clone this repository
2. Run the download script to get the latest SimpleX Chat Desktop package for Ubuntu 22.04
```bash
chmod +x download_simplex.sh
./download_simplex.sh
```
3. Build the Docker image:
```bash
docker build --build-arg SIMPLEX_PACKAGE=simplex-desktop-ubuntu-22_04-x86_64.deb -t YOURUSER/kasm-simplex:latest .
```

## Pushing to Registry
```bash
docker tag YOURUSER/kasm-simplex:latest <registry-url>/kasm-simplex:latest
docker push <registry-url>/kasm-simplex:latest
```

## Troubleshooting
### Common Issues
- If chat data is not persisting:
  1. Verify persistent storage is properly configured
  2. Check permissions on the storage directory
- If SimpleX Chat interface is not loading:
  1. Ensure proper network connectivity
  2. Verify system requirements are met

## Notes
- The workspace uses persistent storage for your chat data
- SimpleX Chat is privacy-focused and end-to-end encrypted
- Regular updates recommended for security

## License
This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.

## Acknowledgments
- [SimpleX Chat](https://simplex.chat/) - Private messaging platform
- [KASM Workspaces](https://www.kasmweb.com/) - Base container images