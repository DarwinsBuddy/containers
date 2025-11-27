FROM docker.io/pytorch/pytorch:2.9.0-cuda12.6-cudnn9-runtime

RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:graphics-drivers/ppa \
    && apt-get update && apt-get install -y \
    ffmpeg \
    libnvidia-encode-570 \
    libnvidia-decode-570 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /
