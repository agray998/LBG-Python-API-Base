#!/bin/bash
set -e
# Function to run the Docker container
run_docker() {
    echo "Running Docker container..."
    sleep 3
    docker run -d -p 80:$PORT -e PORT=$PORT $DOCKER_CREDS_USR/$DOCKER_IMAGE
}

echo "Deploying..."
run_docker
echo "Successfully deployed"