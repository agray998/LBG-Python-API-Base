#!/bin/bash
set -e
# Function to run the Docker container
run_docker() {
    echo "Running Docker container..."
    sleep 3
    docker network create test-net || true
    docker run -d -p 80:$PORT -e PORT=$PORT --network test-net --name lbg-test $DOCKER_CREDS_USR/$DOCKER_IMAGE
    docker run -e PORT=$PORT --network test-net -v $(pwd):/app python:latest sh -c "pip install -r /app/requirements.txt; python /app/lbg.test.py"
}

echo "Deploying..."
run_docker
echo "Successfully deployed"