FROM nvidia/cuda:9.2-devel-ubuntu18.04

# Never prompt the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Define en_US.
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

RUN set -ex \
    && buildDeps=' \
        git \
        curl \
    ' \
    && apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq $buildDeps \
      libx11-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev libxext-dev libxfixes-dev libxcursor-dev x11-utils libxinerama-dev \
      libfreetype6-dev

ARG MINICONDA3_VERSION=4.8.2
ENV MINICONDA3_VERSION=$MINICONDA3_VERSION
RUN curl https://repo.continuum.io/miniconda/Miniconda3-py37_${MINICONDA3_VERSION}-Linux-x86_64.sh > /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -f -p / \
    && rm /tmp/miniconda.sh

ARG EMAN2_VERSION=2.31
ENV EMAN2_VERSION=${EMAN2_VERSION}
RUN conda config --set auto_update_conda False \
    && which conda && env | grep LD \
    && conda install eman-deps-dev=22.1 -c cryoem -c defaults -c conda-forge \
    && cd /tmp/ \
    && git clone https://github.com/cryoem/eman2.git \
    && mkdir /tmp/eman2/build \
    && cd /tmp/eman2/build \
    && cmake -DENABLE_OPTIMIZE_MACHINE=ON -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON ../ \
    && make -j 16 \
    && make install
