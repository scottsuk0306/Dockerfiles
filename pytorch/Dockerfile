ARG UBUNTU_VERSION=20.04
ARG TORCH_VERSION=2.1.2
ARG CUDA_VERSION=12.1
ARG CUDA=cuda${CUDA_VERSION}
ARG PYTHON_VERSION=3.10
ARG CONDA_ENV_NAME=torch

# Use the ARG values in the FROM instruction
FROM pytorch/pytorch:${TORCH_VERSION}-${CUDA}-cudnn8-devel

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    ccache \
    cmake \
    curl \
    git \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libzmq3-dev \
    libjpeg-dev \
    libpng-dev \
    libsm6 \
    libxext6 \
    libxrender-dev \
    pkg-config \
    software-properties-common \
    ssh \
    sudo \
    unzip \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# For CUDA profiling
ENV LD_LIBRARY_PATH /usr/local/cuda-${CUDA_VERSION}/targets/x86_64-linux/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Creating a user
ARG USER_NAME=juyoung
RUN adduser --disabled-password --gecos '' $USER_NAME && \
    echo "$USER_NAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME

# For SSH configuration
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config

USER $USER_NAME

# Create the conda environment
RUN conda create -n $CONDA_ENV_NAME python=$PYTHON_VERSION -y
ENV PATH /opt/conda/envs/$CONDA_ENV_NAME/bin:$PATH
RUN echo "source activate ${CONDA_ENV_NAME}" >> ~/.bashrc

WORKDIR /home/$USER_NAME