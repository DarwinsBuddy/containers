FROM docker.io/pytorch/pytorch:2.9.0-cuda12.6-cudnn9-runtime

RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    && add-apt-repository ppa:graphics-drivers/ppa \
    && apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /workspace

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--ServerApp.token=", "--ServerApp.password=", "--ServerApp.iopub_msg_rate_limit=10000", "--ServerApp.rate_limit_window=3.0"]