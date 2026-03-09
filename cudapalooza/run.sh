#!/bin/bash
set -e

WORK_DIR="${WORK_DIR:-./}"
ZIP_URL="${ZIP_URL}"
OUT_VIDEO="$WORK_DIR/output.mp4"
ZIP_FILE="$WORK_DIR/file.zip"
IMAGES_DIR="$WORK_DIR/images"

cd "$WORK_DIR"

# check if ZIP URL is set
if [ -z "$ZIP_URL" ]; then
    echo "ZIP_URL is not set"
    exit 1
fi

# Check for NVIDIA GPU support
if nvidia-smi &>/dev/null && ffmpeg -encoders 2>/dev/null | grep -q h264_nvenc; then
    echo "GPU detected: Using NVIDIA hardware encoding (h264_nvenc)"
    CODEC="h264_nvenc"
else
    echo "No GPU support: Using CPU encoding (libx264)"
    CODEC="libx264"
fi

if [ ! -f "$ZIP_FILE" ]; then
    echo "Downloading $ZIP_URL"
    wget -O "$ZIP_FILE" "$ZIP_URL"
else
    echo "File already exists: $ZIP_FILE"
fi

unzip -o "$ZIP_FILE" -d "$IMAGES_DIR"
JPG_PATH=$(find "$IMAGES_DIR" -name "*.jpg" | head -1 | xargs dirname)
cd "$JPG_PATH"
ffmpeg -framerate 30 -pattern_type glob -i "*.jpg" -vf "scale=1920:-1" -c:v "$CODEC" -pix_fmt yuv420p "$OUT_VIDEO"
echo "Done → $OUT_VIDEO"