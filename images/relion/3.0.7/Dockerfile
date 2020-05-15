FROM slaclab/ompi-intel:3.1.4 AS builder

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US
ENV LC_ALL C


FROM nvidia/cuda:9.2-devel-ubuntu18.04 

COPY --from=builder /opt/intel /opt/intel/
COPY --from=builder /etc/ld.so.conf.d/openmpi.conf /etc/ld.so.conf.d/openmpi.conf
COPY --from=builder /opt/openmpi-3.1.4 /opt/openmpi-3.1.4/

RUN apt-get update && apt-get install -y \
    gcc g++ cmake build-essential autoconf automake libtool flex bison \
    openssh-client \
    libfftw3-dev \
    libtiff5-dev \
    libx11-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev libxext-dev libxfixes-dev libxcursor-dev x11-utils libxinerama-dev \
    git curl \
    gnuplot unzip ghostscript evince csh


RUN ldconfig

###
# install relion
###
ARG RELION_VER=3.0.7
ENV RELION_ROOT=/opt/relion-${RELION_VER}

ENV INTEL_ROOT=/opt/intel/parallel_studio_xe_2019/compilers_and_libraries_2019/
ENV OMPI_ROOT=/opt/openmpi-3.1.4

ENV COMPILERVARS_ARCHITECTURE=intel64
ENV COMPILERVARS_PLATFORM=linux
ENV INTEL_COMPILEVARS=${INTEL_ROOT}/${COMPILERVARS_PLATFORM}/pkg_bin/compilervars.sh
ENV INTEL_MKLVARS=${INTEL_ROOT}/${COMPILERVARS_PLATFORM}/mkl/bin/mklvars.sh

ARG ARCH_ARGS="COMMON-AVX512"
#ARG ARCH_ARGS="CORE-AVX2"

#RUN TMPDIR=`mktemp -d -t` \
ENV TMPDIR=/tmp/
RUN cd ${TMPDIR} \
  && git clone https://github.com/3dem/relion.git \
  && cd ${TMPDIR}/relion \
  && git checkout ${RELION_VER} \
  && mkdir build 
#  && cd build 
#&& sed -i 's/MPI_DOUBLE_COMPLEX/MPI_C_DOUBLE_COMPLEX/g' src/macros.h \

#RUN ls ${INTEL_ROOT}/${COMPILERVARS_PLATFORM}/lib/*

RUN cat /tmp/relion/CMakeLists.txt |  awk '{print NR ":\t" $0}'


#  && LD_LIBRARY_PATH="${OMPI_ROOT}/lib:$LD_LIBRARY_PATH" \
#  && LIBRARY_PATH="${OMPI_ROOT}/lib:$LIBRARY_PATH" \

RUN cd /tmp/relion/build \
  && . ${INTEL_COMPILEVARS} \
  && . ${INTEL_MKLVARS} \
  && PATH="${OMPI_ROOT}/bin/:${PATH}" \
  && CMAKE_C_COMPILER=${OMPI_ROOT}/bin/mpicc \
     CMAKE_CXX_COMPILER=${OMPI_ROOT}/bin/mpicxx \
     CC=${OMPI_ROOT}/bin/mpicc \
     CXX=${OMPI_ROOT}/bin/mpicxx \
    cmake -D CMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${RELION_ROOT} \
    -DCUDA=ON -DCudaTexture=ON -DCUDA_ARCH=60 \
    -DMPI_INCLUDE_PATH=${OMPI_ROOT}/include \
    -DMPI_LIBRARIES=${OMPI_ROOT}/lib/libmpi.so \
    -DMPI_CXX_INCLUDE_PATH=${OMPI_ROOT}/include \
    -DMPI_CXX_LIBRARIES=${OMPI_ROOT}/lib/libmpi_cxx.so \
    -DMKLFFT=ON -D CMAKE_C_FLAGS=" -O3 -ip -g -x${ARCH_ARGS} -restrict " -D CMAKE_CXX_FLAGS=" -O3 -ip -g -x${ARCH_ARGS} -restrict " \
    .. || true

# MPI_CXX_INCLUDE_PATH

#RUN cat /tmp/relion/build/CMakeFiles/CMakeOutput.log
RUN echo '==================================='
RUN cat /tmp/relion/build/CMakeFiles/CMakeError.log

#    .. \
#  && make -j16 \
#  && make install \
#  && rm -rf ${TMPDIR}

ENTRYPOINT while [ 1 ]; do sleep 60; done
