# PyTorch FFmpeg Container

Container combining PyTorch with FFmpeg and NVIDIA GPU acceleration for video processing.

## Features

- PyTorch 2.9.0 with CUDA 12.6 support
- FFmpeg with NVIDIA hardware encoding (h264_nvenc)
- Automatic GPU detection with CPU fallback
- Image sequence to video conversion

## Usage

### Quick Start

```bash
./run-container.sh
```

### Custom Usage

```bash
podman run --rm \
  -v /your/data:/data \
  -e ZIP_URL="https://example.com/images.zip" \
  -e WORK_DIR="/data" \
  --device nvidia.com/gpu=all \
  ghcr.io/darwinsbuddy/containers/pytorch-ffmpeg:latest
```

### Environment Variables

- `ZIP_URL`: URL to download image archive (required)
- `WORK_DIR`: Working directory for files (default: `./`)

### As Base Image

```dockerfile
FROM ghcr.io/darwinsbuddy/containers/pytorch-ffmpeg:latest

# Override entrypoint for custom usage
ENTRYPOINT ["/bin/bash"]
```

## GPU Support

The container automatically detects NVIDIA GPU support:
- **GPU available**: Uses `h264_nvenc` hardware encoding
- **No GPU**: Falls back to `libx264` CPU encoding

## Output

Creates `output.mp4` in the working directory from JPG images in the downloaded archive.