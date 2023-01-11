ARG MMCV_VERSION="1.7.1"
ARG PYTORCH="22.12"

FROM misakiminato/mmcv:torch${PYTORCH}-mmcv${MMCV_VERSION} AS base

# Install MMDetection
RUN conda clean --all
RUN git clone https://github.com/open-mmlab/mmdetection.git /mmdetection
WORKDIR /mmdetection
ENV FORCE_CUDA="1"
RUN mim install --no-cache-dir -r requirements/build.txt
RUN mim install --no-cache-dir -e .

RUN apt update