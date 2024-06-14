#!/bin/bash
# Exit script if any command fails
set -e
cleanup() {
    echo "Cleaning up previous build artifacts..."
    sleep 3
    # Add commands to clean up previous build artifacts
    docker rm -f $(docker ps -aq) || true
    docker rmi -f $(docker images -q) || true
    echo "Cleanup done."
}

# Main script execution
echo "Starting cleanup process..."
sleep 3
cleanup
echo "Cleanup process completed successfully."