# Containers

Collection of containerized applications and tools.

## Available Containers

### pytorch-ffmpeg
PyTorch container with FFmpeg and NVIDIA GPU acceleration support for video processing tasks.

- **Image**: `ghcr.io/darwinsbuddy/containers/pytorch-ffmpeg:latest`
- **Use case**: Converting image sequences to videos with GPU acceleration
- **Documentation**: [pytorch-ffmpeg/README.md](pytorch-ffmpeg/README.md)

## Building

Use the build script to build and publish containers:

```bash
./build.sh build          # Build only
./build.sh publish        # Publish only  
./build.sh build publish  # Build and publish
./build.sh build --tag v1.0.0  # Custom tag
```

## CI/CD

Containers are automatically built and pushed to GitHub Container Registry on releases.