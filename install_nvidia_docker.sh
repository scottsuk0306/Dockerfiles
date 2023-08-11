#!/bin/bash
# Adopted from https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# NVIDIA Container Toolkit setup
echo "Setting up NVIDIA Container Toolkit..."
distribution=$(. /etc/os-release; echo $ID$VERSION_ID) \
&& curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - \
&& curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list

# Update apt and install nvidia-docker2
echo "Installing nvidia-docker2..."
apt-get update
apt-get install -y nvidia-docker2

# Restart Docker service
echo "Restarting Docker..."
systemctl restart docker

echo "NVIDIA Docker installation completed!"

