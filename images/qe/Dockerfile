FROM nvcr.io/hpc/pgi-compilers:ce
#FROM nvidia/cuda:10.1-devel-ubuntu18.04

ARG DEBIAN_FRONTEND=noninteractive

ENV CUDA_VERSION 10.1

RUN apt-get update && apt-get install -y \
      curl gnupg2 ca-certificates \
  && curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
  apt-get update && apt-get install -y \
    gcc-7 cmake build-essential gfortran autoconf automake libtool flex bison \
    libfabric-dev libibverbs-dev \
    fftw3-dev libfftw3-dev \
    libtiff5-dev \
    git \
    xcrysden gnuplot \
    cuda-cudart-10.1 cuda-compat-10.1 \
    cuda-libraries-10.1 libcublas10 libnccl2 \
    cuda-nvml-dev-10.1 cuda-command-line-tools-10.1 \
    cuda-libraries-10.1 cuda-libraries-dev-10.1 cuda-minimal-build-10.1 \
    cuda-10.1 cuda-toolkit-10.1 cuda-tools-10.1 cuda-runtime-10.1 cuda-compiler-10.1 \
    libnccl-dev \
    libcublas-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/tmp/* \
  && ln -s cuda-10.1 /usr/local/cuda

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:/usr/local/cuda/lib64/stubs

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

###
# compilation arch
##
ARG ARCH="haswell"

#ARG OMPI_VERSION=v4.0.1
#RUN TMPDIR=`mktemp -d -t` \
#  && cd ${TMPDIR} \
#  && git clone https://github.com/open-mpi/ompi.git \
#  && cd ompi \
#  && git checkout ${OMPI_VERSION} \
#  && ./autogen.pl \
#  && CFLAGS="-march=$ARCH" CXXFLAGS="-march=$ARCH" ./configure --prefix=/usr/ \
#  && make -j 16 \
#  && make install \
#  && /usr/bin/mpicc examples/ring_c.c -o /usr/bin/mpi_ring \
#  && rm -rf ${TMPDIR}

###
# ARCH= [ native | skylake-avx512 | haswell ]
#
###
#./configure --with-cuda=XX --with-cuda-runtime=Y.y --with-cuda-cc=ZZ --enable-openmp [ --with-scalapack=no ]

ARG QE_VERSION="qe-6.5"
RUN TMPDIR=`mktemp -d -t` && cd ${TMPDIR} \
  && git clone https://github.com/QEF/q-e.git \
  && cd ${TMPDIR}/q-e \
  && git checkout ${QE_VERSION} \
  && ./configure --enable-openmp --with-scalapack=openmpi  --with-cuda=$CUDA_HOME --with-cuda-runtime=10.1 \
  && CFLAGS="-march=$ARCH" CXXFLAGS="-march=$ARCH" \
     make pw -j16 \
  && make install \
  && rm -rf ${TMPDIR}

    #-DMPI_C_COMPILER=/usr/bin/mpicc -DMPI_CXX_COMPILER=/usr/bin/mpicxx \

