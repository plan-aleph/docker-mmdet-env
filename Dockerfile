ARG CUDA_VERSION
ARG FLAVOR="runtime"
ARG SYS_VERSION

FROM nvidia/cuda:${CUDA_VERSION}-${FLAVOR}-${SYS_VERSION}

ARG PYTHON_VERSION

RUN apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
    wget \
    build-essential \
    libreadline-dev \ 
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    uuid-dev \
    libffi-dev \
    libdb-dev \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -xvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure \
    && make -j 8 \
    && make install \
    && cd .. \
    && rm -rf Python-${PYTHON_VERSION} \
    && rm Python-${PYTHON_VERSION}.tgz \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "install finished."

RUN python3 -m venv /venv --system-site-packages
ENV PATH=/venv/bin:$PATH