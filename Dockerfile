FROM nvcr.io/nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

# Part 2: Additional packages installation
RUN apt update && apt install -y wget git build-essential cmake libomp5 libomp-dev zlib1g

# Part 1: Intel oneAPI MKL installation
RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list \
    && apt update \
    && apt install -y intel-oneapi-mkl intel-oneapi-mkl-devel


# Part 3: CTranslate2 installation
RUN git clone --recursive https://github.com/OpenNMT/CTranslate2.git \
    && cd CTranslate2 \
    && mkdir build \
    && cd build \
    && cmake -DWITH_MKL=ON -DWITH_CUDA=ON -DWITH_CUDNN=ON -DOPENMP_RUNTIME=INTEL .. \
    && make -j8 \
    && make install

# Build Python package
RUN apt-get install -y python3-pip checkinstall
RUN cd /CTranslate2/python \
    && pip install -r install_requirements.txt \
    && CTRANSLATE2_ROOT=/usr/local python3 setup.py bdist_wheel
