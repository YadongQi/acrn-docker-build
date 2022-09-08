FROM ubuntu:20.04

ENV http_proxy http://proxy-dmz.intel.com:911
ENV https_proxy http://proxy-dmz.intel.com:912

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt install -y gcc git make vim libssl-dev libpciaccess-dev uuid-dev \
     libsystemd-dev libevent-dev libxml2-dev libxml2-utils libusb-1.0-0-dev \
     python3 python3-pip python3.8-venv libblkid-dev e2fslibs-dev \
     pkg-config libnuma-dev libcjson-dev liblz4-tool flex bison \
     xsltproc clang-format bc libpixman-1-dev libsdl2-dev libegl-dev \
     libgles-dev libdrm-dev gnu-efi libelf-dev \
     sudo curl lsb-release apt-transport-https software-properties-common ca-certificates

#install the Docker Engine - Community from the repository:
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -  &&\
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN  apt-get update && \
     apt-get install -y docker-ce docker-ce-cli containerd.io

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get update && \
    apt-get -y install git-lfs

RUN pip3 install "elementpath==2.5.0" lxml "xmlschema==1.9.2" defusedxml tqdm requests

#creating user celadonuser
ENV CUSER builder
ENV CUSERHOME /home/$CUSER
ENV CGRP builder


RUN groupadd -g 9999 $CGRP && \
useradd -m -d $CUSERHOME -g $CGRP  $CUSER

ADD ./.gitconfig ${CUSERHOME}

USER $CUSER
WORKDIR  /home/$CUSER


#google repo installation steps

RUN mkdir -p ${CUSERHOME}/.bin
ENV PATH ${CUSERHOME}/.bin:${PATH}
