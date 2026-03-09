FROM docker.io/pytorch/pytorch:2.9.0-cuda12.6-cudnn9-runtime

RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:graphics-drivers/ppa \
    && apt-get update && apt-get install -y \
    ffmpeg \
    libnvidia-encode-570 \
    libnvidia-decode-570 \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Prebuilt CUDA wheel (cu124; compatible with this image's CUDA 12.6 runtime; cu125 not published)
RUN pip install --no-cache-dir llama-cpp-python \
    --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu124

WORKDIR /

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
