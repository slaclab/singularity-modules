FROM nvidia/cuda:10.1-devel-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
      gtk2-engines-pixbuf \
      xfce4 \
      xfce4-goodies \
      ubuntu-mate-desktop \
      acl \
      curl \
      python3-pip \
      xterm \
      firefox \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/tmp/*

RUN DEB=/tmp/turbovnc_2.2.4_amd64.deb \
    && curl https://iweb.dl.sourceforge.net/project/turbovnc/2.2.4/turbovnc_2.2.4_amd64.deb > $DEB \
    && dpkg --install $DEB \
    && rm -f $DEB

RUN pip3 install websockify

ENV PATH=/opt/TurboVNC/bin/:${PATH}
RUN ln -sf /afs/slac/u /u
