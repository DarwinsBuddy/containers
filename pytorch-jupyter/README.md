# PyTorch Jupyter Container

CUDA-enabled PyTorch container with Jupyter Lab for interactive development and experimentation.

## Features

- PyTorch 2.9.0 with CUDA 12.6 support
- Jupyter Lab pre-installed
- GPU acceleration ready
- No authentication required (for development use)

## Usage

### Local Usage

```bash
docker run -it --gpus all -p 8888:8888 -v $(pwd):/workspace ghcr.io/darwinsbuddy/containers/pytorch-jupyter:latest
```

### Remote EC2 Usage (Secure)

**On EC2 instance:**
```bash
docker run -it --gpus all -p 127.0.0.1:8888:8888 -v $(pwd):/workspace ghcr.io/darwinsbuddy/containers/pytorch-jupyter:latest
```

**On your local machine:**
```bash
ssh -L 8888:127.0.0.1:8888 ec2-user@your-ec2-public-ip
```

Then access Jupyter Lab at: `http://localhost:8888`

## Building

```bash
docker build -t pytorch-jupyter .
```

## Security Note

This container runs without authentication for development convenience. Do not expose it to public networks in production environments.