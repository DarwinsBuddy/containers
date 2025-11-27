#!/bin/bash
set -e

IMAGE_NAME="ghcr.io/darwinsbuddy/containers/pytorch-ffmpeg"
TAG="latest"
DO_BUILD=false
DO_PUBLISH=false

while [[ $# -gt 0 ]]; do
    case $1 in
        build)
            DO_BUILD=true
            shift
            ;;
        publish)
            DO_PUBLISH=true
            shift
            ;;
        --tag|-t)
            TAG="$2"
            shift 2
            ;;
        *)
            echo "Usage: $0 [build] [publish] [--tag TAG]"
            exit 1
            ;;
    esac
done

if [[ "$DO_BUILD" == false && "$DO_PUBLISH" == false ]]; then
    echo "Usage: $0 [build] [publish] [--tag TAG]"
    exit 1
fi

if [[ "$DO_BUILD" == true ]]; then
    echo "Building container with tag: $TAG"
    podman build -t "$IMAGE_NAME:$TAG" ./pytorch-ffmpeg
fi

if [[ "$DO_PUBLISH" == true ]]; then
    echo "Pushing to GHCR..."
    podman push "$IMAGE_NAME:$TAG"
fi

echo "Done: $IMAGE_NAME:$TAG"