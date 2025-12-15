#!/bin/bash
set -e

IMAGE_NAME="ghcr.io/darwinsbuddy/containers/pytorch-ffmpeg:latest"
MOUNT_DIR="/opt/zeitvision-ffmpeg"
ZIP_URL="https://zeitings-live.s3.amazonaws.com/archives/users/1/truman_homes_radio_park_-archive-1-of-1-with-40-photos-2025-11-26-08-59-to-2025-11-27-09-15.zip"

mkdir -p "$MOUNT_DIR"

podman run --rm \
    -v "$MOUNT_DIR:/data" \
    -e WORK_DIR="/data" \
    -e ZIP_URL="$ZIP_URL" \
    --device nvidia.com/gpu=all \
    "$IMAGE_NAME"