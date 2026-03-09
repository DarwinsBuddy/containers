# Cudapalooza

A general-purpose CUDA container with PyTorch, FFmpeg (NVIDIA encode/decode), and **llama-cpp-python** (CUDA) for running GGUF models. No GPU required at build time—CUDA packages use prebuilt wheels.

## What’s inside

| Component | Details |
|-----------|--------|
| **PyTorch** | 2.9.0 with CUDA 12.6 |
| **FFmpeg** | With `libnvidia-encode` / `libnvidia-decode` (e.g. h264_nvenc) |
| **llama-cpp-python** | Prebuilt CUDA wheel (cu124), ready for GGUF inference on GPU |
| **System** | wget, unzip, and common utilities |

## Default behavior (image sequence → video)

The image entrypoint is a script that:

1. Expects `ZIP_URL` (and optional `WORK_DIR`)
2. Downloads the zip, unzips it, finds JPGs
3. Encodes them to `output.mp4` with FFmpeg (GPU if available, else CPU)

### Quick start

```bash
podman run --rm \
  -v /your/data:/data \
  -e ZIP_URL="https://example.com/images.zip" \
  -e WORK_DIR="/data" \
  --device nvidia.com/gpu=all \
  ghcr.io/darwinsbuddy/containers/cudapalooza:latest
```

### Environment variables (default script)

- **`ZIP_URL`** — URL of a zip containing images (required for default script)
- **`WORK_DIR`** — Working directory for download and output (default: `./`)

Output is written to `$WORK_DIR/output.mp4`. If an NVIDIA GPU is available, encoding uses `h264_nvenc`; otherwise it falls back to `libx264`.

## Using llama-cpp-python (GGUF)

The image includes `llama-cpp-python` built with CUDA. Use it from Python or via the built-in server.

### Python API

```python
from llama_cpp import Llama

llm = Llama(model_path="/path/to/model.gguf", n_gpu_layers=-1)  # -1 = all layers on GPU
out = llm("Hello", max_tokens=64)
```

### OpenAI-compatible server

```bash
python -m llama_cpp.server --model /path/to/model.gguf --n_gpu_layers -1
```

Mount your model directory and pass GPU access, e.g.:

```bash
podman run --rm -it \
  -v /path/to/models:/models \
  --device nvidia.com/gpu=all \
  ghcr.io/darwinsbuddy/containers/cudapalooza:latest \
  python -m llama_cpp.server --model /models/your.gguf --n_gpu_layers -1
```

## Using as a base image

Override the entrypoint for custom workloads (e.g. training, other scripts):

```dockerfile
FROM ghcr.io/darwinsbuddy/containers/cudapalooza:latest

# Your layers...

ENTRYPOINT ["/bin/bash"]
```

Or run a one-off command:

```bash
podman run --rm -it --device nvidia.com/gpu=all \
  ghcr.io/darwinsbuddy/containers/cudapalooza:latest \
  python -c "import torch; print(torch.cuda.is_available())"
```

## GPU support

- **Default script**: Uses NVIDIA hardware encoding when `nvidia-smi` and `h264_nvenc` are available; otherwise uses CPU encoding.
- **llama-cpp-python**: Set `n_gpu_layers=-1` to offload all layers to the GPU. Ensure the container is run with GPU access (e.g. `--device nvidia.com/gpu=all` or your runtime’s equivalent).
