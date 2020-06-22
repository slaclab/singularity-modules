FROM nvidia/cuda:10.1-devel-ubuntu18.04

###
# munge
###
ARG MUNGEUSER=16952
ARG MUNGEGROUP=1034
ARG SLURMUSER=16924
ARG SLURMGROUP=1034
RUN groupadd -f -g $MUNGEGROUP munge \
    && useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge \
    && groupadd -f -g $SLURMGROUP slurm \
    && useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm

RUN apt-get update && apt-get install -y \
    gcc-7 cmake build-essential autoconf automake libtool flex bison \
    libfabric-dev libibverbs-dev \
    openssh-client \
    libfftw3-dev \
    libtiff5-dev \
    libx11-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev libxext-dev libxfixes-dev libxcursor-dev x11-utils libxinerama-dev \
    libfreetype6-dev \
    git curl \
    gnuplot unzip ghostscript evince csh \
    munge \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/tmp/*

###
# compilation arch
##
ARG ARCH="haswell"

ARG OMPI_VERSION=v4.0.3
RUN TMPDIR=`mktemp -d -t` \
  && cd ${TMPDIR} \
  && git clone https://github.com/open-mpi/ompi.git \
  && cd ompi \
  && git checkout ${OMPI_VERSION} \
  && ./autogen.pl \
  && CFLAGS="-march=$ARCH" CXXFLAGS="-march=$ARCH" ./configure --prefix=/usr/ \
  && make -j 16 \
  && make install \
  && /usr/bin/mpicc examples/ring_c.c -o /usr/bin/mpi_ring \
  && rm -rf ${TMPDIR}

###
# install relion
# ARCH= [ native | skylake-avx512 | haswell ]
#
###
ARG RELION_VERSION="ver3.1"
RUN TMPDIR=`mktemp -d -t` && cd ${TMPDIR} \
  && git clone https://github.com/3dem/relion.git \
  && cd ${TMPDIR}/relion \
  && git checkout ${RELION_VERSION} \
  && sed -i 's/MPI_DOUBLE_COMPLEX/MPI_C_DOUBLE_COMPLEX/g' src/macros.h \
  && mkdir build && cd build \
  && CFLAGS="-march=$ARCH" CXXFLAGS="-march=$ARCH" \
    cmake -DCMAKE_INSTALL_PREFIX=/opt/relion \
    -DCUDA=ON -DCudaTexture=ON -DCUDA_ARCH=60 \
    -DMPI_C_COMPILER=/usr/bin/mpicc -DMPI_CXX_COMPILER=/usr/bin/mpicxx \
    .. \
  && make -j16 \
  && make install \
  && rm -rf ${TMPDIR}

###
# install ctffind
###
RUN cd /usr/local \
  && curl -L 'http://grigoriefflab.umassmed.edu/sites/default/files/ctffind-4.1.10-linux64.tar.gz' | tar xvfz -
#  && curl -L 'https://cistem.org/system/tdf/uploads/ctffind-4.1.13-linux64.tar.gz?file=1&type=cistem_details&id=44&force=&s3fs=' | tar xvfz -

###
# install gctf
###
RUN cd /usr/local/bin \
  && curl -L 'https://www2.mrc-lmb.cam.ac.uk/download/special-version-for-phase-plate-gctf_v1-18/?ind=yndDYu9k8MK4JkGOF3ALgjR2Q26CZ1UnJsXiu1KoqDIbgwcG1ixt_ITnWIHyD6ekyJBvTuXDGBMwDp6gCDs2Bmdubm124J6bomYr4SYuo87yrU3cCeyzt1fzvJW6TWeCrCKNPsmHddUdoTu9tyR_pkLfe7hg5rW4vmP7v8pG-r3ubhgOlhkR7nQ3bodzMu8Asd2IRtVAlSKtM3I3FDBvy1hSCZ2DUFdxAxlfSeTSeKnYYjBAi3NEiof_tYbUCAfp&filename=GCTF_v1.18_sm30-75_cu10.1&wpdmdl=17951&refresh=5ef0350df0d311592800525' > Gctf \
  && chmod ugo+x /usr/local/bin/Gctf

###
# install motioncor
###
RUN cd /usr/local/bin \
  && curl -L 'https://drive.google.com/uc?export=download&id=19vwXD8Fi636W83iIpKMjK4i60MyM1-Iw' > MotionCor2_1.3.2.zip \
  && unzip MotionCor2_1.3.2.zip \
  && rm -f MotionCor2_1.3.2.zip \
  && ln -sf MotionCor2_1.3.2-Cuda101 MotionCor2

###
# slurm stuff
###
RUN rm -rf /var/run/munge && ln -sf /mnt /var/run/munge
