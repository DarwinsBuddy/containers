# PyTorch Jupyter Container

CUDA-enabled PyTorch container with Jupyter Lab for interactive development and experimentation.

## Features

- PyTorch 2.9.0 with CUDA 12.6 support
- Jupyter Lab pre-installed
- opencv & ffmpeg pre-installed
- GPU acceleration ready
- No authentication required (for development use)

## Usage

### Local Usage

```bash
docker run -it --gpus all -p 8888:8888 -v $(pwd):/workspace ghcr.io/darwinsbuddy/containers/pytorch-jupyter:latest
```

### Remote EC2 Usage (Secure)

**Method 1: Forward SSH Tunnel (Standard)**

*On EC2 instance:*
```bash
docker run -it --gpus all -p 127.0.0.1:8888:8888 -v $(pwd):/workspace ghcr.io/darwinsbuddy/containers/pytorch-jupyter:latest
```

*On your local machine:*
```bash
ssh -L 8888:127.0.0.1:8888 ec2-user@your-ec2-public-ip
```

**Method 2: Reverse SSH Tunnel (Alternative)**

*On your local machine (start first):*
```bash
ssh -R 8888:127.0.0.1:8888 ec2-user@your-ec2-public-ip
```

*On EC2 instance (while SSH session is active):*
```bash
docker run -it --gpus all -p 127.0.0.1:8888:8888 -v $(pwd):/workspace ghcr.io/darwinsbuddy/containers/pytorch-jupyter:latest
```

Both methods: Access Jupyter Lab at `http://localhost:8888`

**Method 3: Remote Kernel (Local Jupyter + Remote Compute)**

*On EC2 instance:*
```bash
docker run -it --gpus all -p 127.0.0.1:8888:8888 -v $(pwd):/workspace ghcr.io/darwinsbuddy/containers/pytorch-jupyter:latest --NotebookApp.kernel_gateway_enabled=True
```

*On your local machine:*
```bash
# Arch Linux - Use virtual environment (package is outdated)
python -m venv ~/.jupyter-remote
source ~/.jupyter-remote/bin/activate
pip install jupyter-kernel-gateway

# Other distros - Install via pip in venv
# python -m venv ~/.jupyter-remote && source ~/.jupyter-remote/bin/activate
# pip install jupyter-kernel-gateway

# Add remote kernel
ipython kernel install --user

# Connect via SSH tunnel
ssh -L 8888:127.0.0.1:8888 ec2-user@your-ec2-public-ip
```

Then use your local Jupyter with the remote kernel for GPU compute.

## Building

```bash
docker build -t pytorch-jupyter .
```

## Security Note

This container runs without authentication for development convenience. Do not expose it to public networks in production environments.