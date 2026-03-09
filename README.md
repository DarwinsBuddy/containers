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

### cudapalooza
CUDA stack with PyTorch, FFmpeg (NVIDIA encode/decode), and llama-cpp-python for GGUF models.

- **Image**: `ghcr.io/darwinsbuddy/containers/cudapalooza:latest`
- **Use case**: GGUF inference, video encoding, general GPU workloads
- **Documentation**: [cudapalooza/README.md](cudapalooza/README.md)

## Building

Use the build script to build and publish containers locally:

```bash
./build.sh pytorch-ffmpeg build          # Build pytorch-ffmpeg
./build.sh pytorch-jupyter build         # Build pytorch-jupyter
./build.sh cudapalooza build             # Build cudapalooza
./build.sh <container> build publish     # Build and push to GHCR
./build.sh <container> build --tag 1.0.0   # Build with a specific tag
```

## Releasing (versions and tags)

Each container is **versioned and released separately** via Git tags. Pushing a tag triggers a single workflow that builds and pushes that image to GitHub Container Registry.

| Container        | Tag pattern              | Example tag           | Image tags produced      |
|-----------------|---------------------------|------------------------|---------------------------|
| pytorch-ffmpeg  | `pytorch-ffmpeg-<version>` | `pytorch-ffmpeg-1.0.0` | `:1.0.0`, `:latest`       |
| pytorch-jupyter | `pytorch-jupyter-<version>` | `pytorch-jupyter-1.0.0` | `:1.0.0`, `:latest`       |
| cudapalooza     | `cudapalooza-<version>`   | `cudapalooza-1.0.0`    | `:1.0.0`, `:latest`       |

**To release one container:** create and push a tag for that container only. Only that image is built and pushed.

```bash
# Release cudapalooza as 1.0.0 (does not affect other images)
git tag cudapalooza-1.0.0
git push origin cudapalooza-1.0.0
```

You can optionally create a [GitHub Release](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-your-repository) from the same tag to add release notes; the workflow runs on the tag push regardless.