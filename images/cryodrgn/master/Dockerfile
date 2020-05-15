FROM nvidia/cuda:10.1-runtime-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

RUN set -ex \
    && buildDeps=' \
    ' \
    && apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends \
        $buildDeps \
        git \
        curl \
    && apt-get purge --auto-remove -yqq $buildDeps \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

ARG MINICONDA3_VERSION=4.8.2
ENV MINICONDA3_VERSION=$MINICONDA3_VERSION
RUN cd /tmp/ \
    && curl https://repo.continuum.io/miniconda/Miniconda3-py37_${MINICONDA3_VERSION}-Linux-x86_64.sh > /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -f -p /usr/ \
    && conda config --set auto_update_conda False \
    && rm /tmp/miniconda.sh 

RUN conda install pytorch torchvision -c pytorch \
    && conda install pandas \
    && conda install seaborn scikit-learn \
    && conda install -c conda-forge umap-learn \
    && conda install -c conda-forge jupyterlab \
    && pip install ipywidgets \
    && jupyter nbextension enable --py widgetsnbextension \
    && pip install cufflinks

ARG CDRGN_VERSION=master
ENV CDRGN_VERSION=${CDRGN_VERSION}
ENV CDRGN_SRC=/app/cryodrgn
RUN git clone -b ${CDRGN_VERSION} https://github.com/zhonge/cryodrgn.git ${CDRGN_SRC} \
    && find ${CDRGN_SRC}/ -type f -name '*.py' -exec sed -i '1s|^|#!/usr/bin/env python\n|' {} \; \
    && find ${CDRGN_SRC}/ -type f -name '*.sh' -exec sed -i '1s|^|#!/bin/sh\n|' {} \; \
    && chmod ugo+x ${CDRGN_SRC}/*.py \
    && chmod ugo+x ${CDRGN_SRC}/utils/*.py \
    && chmod ugo+x ${CDRGN_SRC}/utils/analysis/*.py ${CDRGN_SRC}/utils/analysis/*.sh 
ENV PATH=${PATH}:${CDRGN_SRC}:${CDRGN_SRC}/utils:${CDRGN_SRC}/utils/analysis
