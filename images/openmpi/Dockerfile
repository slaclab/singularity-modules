FROM ubuntu:bionic

RUN apt-get update -y \
    && apt-get -y --allow-unauthenticated install \
                  gcc-7 \
                  git \
                  build-essential \
                  autoconf \
                  automake \
                  libtool \
                  flex bison \
                  tree \
                  curl \
                  openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/tmp/*

###
# openmpi
###
ARG OPENMPI_VERSION=v4.0.1
RUN  mkdir /tmp/git \
    && cd /tmp/git \
    && git clone -b $OPENMPI_VERSION https://github.com/open-mpi/ompi.git \
    && cd ompi \
    && ./autogen.pl \
    && ./configure --prefix=/usr/ \
    && make -j 24 \
    && make install \
    && cd /tmp/git/ompi/examples/ \
    && make \
    && mv connectivity_c dtrace ring_c spc_example /usr/local/bin/ \
    && rm -rf /tmp/git

###
# phloem 
###
RUN mkdir /tmp/git \
    && git clone https://github.com/LLNL/phloem.git \
    && cd phloem \
    && ln -s /usr/include/x86_64-linux-gnu/sys/ /usr/include/sys \
    && make \
    && mv mpigraph-1.6/mpiBench/mpiBench mpigraph-1.6/mpiBench/crunch_mpiBench /usr/local/bin/ \
    && mv mpigraph-1.6/mpiGraph/mpiGraph mpigraph-1.6/mpiGraph/crunch_mpiGraph /usr/local/bin \
    && mv presta-1.3.0/com presta-1.3.0/bw.message.sizes presta-1.3.0/latency.message.sizes /usr/local/bin/ \
    && mv sqmr-1.1.0/sqmr /usr/local/bin/ \
    && cd /tmp && rm -rf /tmp/git

#RUN cd /tmp/ \
#    && curl https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.6.2.tar.gz | tar xfvz - \
#    && cd osu-micro-benchmarks-5.6.2 \
#    && ./configure && make && make install \
#    && cd mpi && make && make instal \
#    && tree -if 

###
#
###
ARG DEBIAN_FRONTEND=noninteractive
RUN mkdir /tmp/git \
    && git clone https://github.com/cea-hpc/hp2p.git \
    && cd hp2p \
    && apt-get update -y \
    && apt-get install -y python-minimal python-numpy python-matplotlib python-plotly \
    && pip install mpldatacursor \ 
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/tmp/* \
    && ./autogen.sh && ./configure && make && make install \
    && cd /tmp/ && rm -rf /tmp/git
