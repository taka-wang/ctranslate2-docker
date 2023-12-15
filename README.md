# CTranslate2-Docker: Building for CUDA 12

## Overview

Build CTranslate2 for CUDA 12 using Docker.

## Why

Due to Colab upgrading CUDA to 12.2, but CTranslate2 (used by packages like faster-whisper) currently only supports CUDA 11.x. Hence, this temporary repository exists.

Navigate to `/CTranslate2/build` and execute `checkinstall` to package the shared library. The wheel is in `/CTranslate2/python`.

## Getting Started

```bash
# Clone the CTranslate2-Docker repository
git clone https://github.com/taka-wang/ctranslate2-docker.git
cd ctranslate2-docker

# Build the Docker image
docker build -t ct .

# Run the Docker container
docker run --rm -it $(pwd):/tmp ct /bin/bash

# Inside the container, navigate to CTranslate2/build
cd CTranslate2/build

# Execute checkinstall to package the shared library
checkinstall

# The wheel can be found in CTranslate2/python
cd ../python
```

## Using in Colab Cell

```sh
# Download CTranslate2 Debian package and pre-built wheel
!wget https://github.com/taka-wang/ctranslate2-docker/releases/download/build_20231215/ctranslate2.deb \
     https://github.com/taka-wang/ctranslate2-docker/releases/download/build_20231215/ctranslate2-3.23.0-cp310-cp310-linux_x86_64.whl

# Install CTranslate2 Debian package, libomp5, and pre-built CTranslate2 wheel using pip
!dpkg -i ctranslate2.deb && rm ctranslate2.deb \
 && apt-get update && apt-get install -y libomp5 \
 && pip install ctranslate2-3.23.0-cp310-cp310-linux_x86_64.whl && rm ctranslate2-3.23.0-cp310-cp310-linux_x86_64.whl

# Install additional Python packages
!pip install whisper-ctranslate2 faster-whisper ...
```

## References

- [Upgrade to CUDA 12.2, tensorflow 2.15.0, keras 2.15.0, and Nvidia driver 535.104.05 #4214](https://github.com/googlecolab/colabtools/issues/4214)
- [CUDA 12 support (libcublas.so.11 is not found)](https://github.com/OpenNMT/CTranslate2/issues/1250#issuecomment-1849222974)
