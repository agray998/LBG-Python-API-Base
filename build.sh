#!/bin/bash
set -e
# Function to build the Docker image
build_docker() {
    echo "Building the Docker image..."
    sleep 3
    docker build -t $DOCKER_CREDS_USR/$DOCKER_IMAGE .
}

echo "Starting build process..."
build_docker
echo "Successfully built $DOCKER_CREDS_USR/$DOCKER_IMAGE"