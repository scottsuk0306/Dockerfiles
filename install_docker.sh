#!/bin/bash
# Adopted from Docker - Install on Ubuntu: https://docs.docker.com/engine/install/ubuntu/

# Check if the script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Step 1: Update the apt package index
echo "Updating the apt package index..."
apt-get update

# Step 2: Install necessary packages to allow apt to use a repository over HTTPS
echo "Installing required packages..."
apt-get install -y ca-certificates curl gnupg

# Step 3: Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Step 4: Set up the Docker repository
echo "Setting up the Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Docker repository setup completed! You can now install Docker from the repository."

