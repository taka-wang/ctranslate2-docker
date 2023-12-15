# ctranslate2-docker

Build CTranslate2 for CUDA 12 using Docker.

## Description

Due to Colab upgrading cuda to 12.2, but CTranslate2 (used by packages like faster-whisper) currently only supports CUDA 11.x. Hence, this temporary repository exists.

Navigate to `/CTranslate2/build` and execute `checkinstall` to package the shared library.
The wheel is in `/CTranslate2/python`.

## Get Started

```bash
# Clone the ctranslate2-docker repository
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

## Reference

- [Upgrade to CUDA 12.2, tensorflow 2.15.0, keras 2.15.0, and Nvidia driver 535.104.05 #4214](https://github.com/googlecolab/colabtools/issues/4214)
- [CUDA 12 support (libcublas.so.11 is not found)](https://github.com/OpenNMT/CTranslate2/issues/1250#issuecomment-1849222974)
