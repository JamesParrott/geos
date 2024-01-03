ARG BASE_IMAGE=gcc
ARG BASE_TAG=13.2.0-bookworm
ARG GEOS_SRC_DIR=/tmp/geos


FROM "${BASE_IMAGE}:${BASE_TAG}" as base_builder


RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    g++ \
    make \
    cmake \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://github.com/libgeos/geos ${GEOS_SRC_DIR}

WORKDIR ${GEOS_SRC_DIR}/geos/build

RUN cmake -DCMAKE_BUILD_TYPE=Release .. && \
    cmake --build . && \
    cmake --build . --target install
