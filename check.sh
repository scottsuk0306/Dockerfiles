#!/bin/bash

# Check OS Version
echo "=== OS Version ==="
lsb_release -d

# Check Shell Version
echo -e "\n=== Shell Version ==="
echo $SHELL
$SHELL --version

# Check User ID and UID
echo -e "\n=== User ID and UID ==="
echo "User ID (Name): $(whoami)"
echo "UID: $(id -u)"

# Check CUDA version
echo -e "\n=== CUDA ==="
if type nvcc >/dev/null 2>&1; then
    nvcc --version | grep -i release
else
    if [ -f "/usr/local/cuda/version.txt" ]; then
        cat /usr/local/cuda/version.txt
    else
        echo "CUDA not found!"
    fi
fi

# Check cuDNN version - This part is not working
echo -e "\n=== cuDNN ==="


# Check common locations for cudnn.h
for dir in /usr/local/cuda-*/include/ /usr/include/; do
    if [ -f "${dir}cudnn.h" ]; then
        CUDNN_HEADER_PATH="${dir}cudnn.h"
        break
    fi
done

if [ ! -z "$CUDNN_HEADER_PATH" ]; then
    grep "#define CUDNN_MAJOR" $CUDNN_HEADER_PATH
    grep "#define CUDNN_MINOR" $CUDNN_HEADER_PATH
    grep "#define CUDNN_PATCHLEVEL" $CUDNN_HEADER_PATH
else
    echo "cuDNN not found!"
fi



# Check Number and Type of GPUs
echo -e "\n=== GPUs ==="
if type nvidia-smi >/dev/null 2>&1; then
    echo "Number of GPUs: $(nvidia-smi -L | wc -l)"
    nvidia-smi -L
else
    echo "nvidia-smi not found!"
fi
