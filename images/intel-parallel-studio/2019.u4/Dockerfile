FROM ubuntu:18.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

COPY config.cfg /tmp/config.cfg
COPY license.lic /tmp/license.lic

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git cpio build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV INTEL_LICENSE_FILE=28518@license1

#ARG URL=http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/13002/parallel_studio_xe_2018_update3_composer_edition.tgz
ARG URL=http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/15537/parallel_studio_xe_2019_update4_composer_edition.tgz
RUN cd /tmp && \
  wget -O icc.tgz ${URL} && \
  tar -xvzf icc.tgz && \
  cd /tmp/parallel_studio_xe_* && \
  echo "installing..." && \
  bash ./install.sh --silent=/tmp/config.cfg && \
  cd /tmp && \
  rm -rf parallel_studio_xe_* icc.tgz && \
  rm /tmp/config.cfg

ENV INTEL_COMPILEVARS=/opt/intel/parallel_studio_xe_2019/compilers_and_libraries_2019/linux/pkg_bin/compilervars.sh
ENV INTEL_MKLVARS=/opt/intel/parallel_studio_xe_2019/compilers_and_libraries_2019/linux/mkl/bin/mklvars.sh
ENV COMPILERVARS_ARCHITECTURE=intel64
ENV COMPILERVARS_PLATFORM=linux
RUN . ${INTEL_COMPILEVARS}
RUN . ${INTEL_MKLVARS}
ENV CC=icc
ENV CXX=icpc
ENV FC=ifort


