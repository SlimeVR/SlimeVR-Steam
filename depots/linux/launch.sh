#!/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARCH=$(uname -m)

if [[ "$ARCH" == "x86_64" ]]; then
    cd "$SCRIPT_DIR/x64/SlimeVR"
    export LD_LIBRARY_PATH="lib:${LD_LIBRARY_PATH:-}"
    export PATH="jre/bin:$PATH"
    ./slimevr -- --steam

elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    cd "$SCRIPT_DIR/aarch64/SlimeVR"
    export LD_LIBRARY_PATH="lib:${LD_LIBRARY_PATH:-}"
    export PATH="jre/bin:$PATH"
    ./slimevr -- --steam --enable-features=Vulkan

else
    echo "Error: Unsupported architecture '${ARCH}'" >&2
    exit 1
fi
