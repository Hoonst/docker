# Dockerfile

# Pull base image - required
FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
ENV LC_ALL=C.UTF-8

# Install some basic utilities - required
RUN . /etc/os-release; \
                printf "deb http://ppa.launchpad.net/jonathonf/vim/ubuntu %s main" "$UBUNTU_CODENAME" main | tee /etc/apt/sources.list.d/vim-ppa.list && \
                apt-key  adv --keyserver hkps://keyserver.ubuntu.com --recv-key 4AB0F789CBA31744CC7DA76A8CF63AD3F06FC659 && \
                apt-get update --fix-missing && \
                env DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --autoremove --purge --no-install-recommends -y \
                        build-essential \
                        bzip2 \
                        ca-certificates \
                        curl \
                        git \
                        libcanberra-gtk-module \
                        libgtk2.0-0 \
                        libx11-6 \
                        sudo \
                        graphviz \
                        vim-nox

# Install miniconda - optinal
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}

# ENV PATH /opt/conda/bin:$PATH
RUN apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN pip install torch==1.7.1 tqdm==4.49.0 numpy==1.19.2 pandas==1.1.5  scikit_learn==0.23.2 tensorboardX==2.1 black==20.8b1 jupyterlab==3.0.5 tensorboard==2.4.1

RUN git clone https://github.com/NVIDIA/apex.git /apex && \
  cd /apex && \
  pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./

ARG UNAME
ARG UID
ARG GID
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAMES
