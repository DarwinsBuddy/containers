# Containers

Collection of containerized applications and tools.

## Available Containers

### pytorch-ffmpeg
PyTorch container with FFmpeg and NVIDIA GPU acceleration support for video processing tasks.

- **Image**: `ghcr.io/darwinsbuddy/containers/pytorch-ffmpeg:latest`
- **Use case**: Converting image sequences to videos with GPU acceleration
- **Documentation**: [pytorch-ffmpeg/README.md](pytorch-ffmpeg/README.md)

### pytorch-jupyter
CUDA-enabled PyTorch container with Jupyter Lab for interactive development and experimentation.

- **Image**: `ghcr.io/darwinsbuddy/containers/pytorch-jupyter:latest`
- **Use case**: Interactive PyTorch development with GPU acceleration
- **Documentation**: [pytorch-jupyter/README.md](pytorch-jupyter/README.md)

## Building

Use the build script to build and publish containers:

```bash
./build.sh pytorch-ffmpeg build          # Build pytorch-ffmpeg
./build.sh pytorch-jupyter build         # Build pytorch-jupyter
./build.sh pytorch-ffmpeg publish        # Publish pytorch-ffmpeg
./build.sh pytorch-jupyter build publish # Build and publish pytorch-jupyter
./build.sh pytorch-ffmpeg build --tag v1.0.0  # Custom tag
```

## CI/CD

Containers are automatically built and pushed to GitHub Container Registry on releases.