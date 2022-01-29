#FROM arm64v8/ubuntu:18.04
FROM nvcr.io/nvidia/l4t-ml:r32.5.0-py3

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends apt-utils \
  && apt-get install -y \
    python3-dev libpython3-dev python-pil python3-tk python-imaging-tk \
    build-essential wget locales libfreetype6-dev \
    libopenblas-dev liblapack-dev libatlas-base-dev gfortran \
    libjpeg-dev libpng-dev libopenjp2-7-dev libopenjp2-tools \
    libaec-dev libblosc-dev libbrotli-dev libbz2-dev libgif-dev \
    imagemagick liblcms2-dev libjxr-dev liblz4-dev libsnappy-dev \
    libopenjp2-7-dev libopenjp2-tools libfreetype6-dev libzstd-dev \
    libwebp-dev cmake wget bzip2 autoconf automake libtool \
    liblzma-dev libzopfli-dev

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

# Building: libtiff5-dev
RUN cd /tmp \
  && wget https://gitlab.com/libtiff/libtiff/-/archive/v4.1.0/libtiff-v4.1.0.tar.bz2 \
  && tar xvfj libtiff-v4.1.0.tar.bz2 \
  && cd libtiff-v4.1.0 \
  && ./autogen.sh \
  && ./configure \
  && make install

RUN wget -q -O /tmp/get-pip.py --no-check-certificate https://bootstrap.pypa.io/get-pip.py \
  && python3 /tmp/get-pip.py \
  && pip3 install -U pip
RUN pip3 install -U testresources setuptools

RUN pip3 install -U Cython
RUN pip3 install -U pillow
RUN pip3 install -U numpy==1.19.4
RUN pip3 install -U scipy
RUN pip3 install -U matplotlib
RUN pip3 install -U PyWavelets
RUN pip3 install -U kiwisolver
RUN pip3 install -U imagecodecs-lite
RUN pip3 install -U scikit-image
