FROM nvidia/cuda:10.1-devel-ubuntu18.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y \
      xfce4 xfce4-goodies curl python3-pip python3-setuptools \
        unzip \
        ca-certificates \
        libasound2 \
        libatk1.0-0 \
        libavcodec-extra57 \
        libavformat57 \
        libc6 \
        libcairo-gobject2 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libfontconfig1 \
        libgdk-pixbuf2.0-0 \
        libgstreamer-plugins-base1.0-0 \
        libgstreamer1.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libpam0g \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libpangoft2-1.0-0 \
        libpython2.7 \
        libpython3.6 \
        libpython3.7 \
        libselinux1 \
        libsm6 \
        libsndfile1 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxft2 \
        libxi6 \
        libxinerama1 \
        libxrandr2 \
        libxrender1 \
        libxt6 \
        libxtst6 \
        libxxf86vm1 \
        locales \
        locales-all \
        procps \
        sudo \
        xkb-data \
        zlib1g \
    && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/* && rm -rf /var/tmp/*

RUN DEB=/tmp/turbovnc_2.2.4_amd64.deb \
    && curl https://iweb.dl.sourceforge.net/project/turbovnc/2.2.4/turbovnc_2.2.4_amd64.deb > $DEB \
    && dpkg --install $DEB \
    && rm -f $DEB

RUN dbus-uuidgen > /etc/machine-id

RUN pip3 install wheel && pip3 install websockify
ENV PATH=/opt/TurboVNC/bin/:${PATH}


#FROM base as setup

ADD matlab_R2020a_glnxa64.zip /tmp/matlab_R2020a_glnxa64.zip
RUN unzip  /tmp/matlab_R2020a_glnxa64.zip -d /tmp/matlab-install/ 
ADD matlab_installer_input.txt /tmp/installer_input.txt 
ADD license.dat /etc/matlab/license.dat
#RUN cat /etc/matlab/network.lic
RUN cat /etc/matlab/license.dat
RUN cat /tmp/matlab-install/installer_input.txt
#RUN cd /tmp/matlab-install \
#    && chmod +x ./install \ 
#    && ./install -mode silent -help \
#       -agreeToLicense yes \
#       -inputFile /tmp/installer_input.txt \
#       -outputFile /tmp/install.log \
#       -destinationFolder /usr/local/MATLAB \
#    ; EXIT=$? && cat /tmp/install.log && test $EXIT -eq 0
#

#FROM base
#COPY --from=setup /usr/local/MATLAB /usr/local/MATLAB

#COPY . /usr/local/MATLAB/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ '/entrypoint.sh' ]



