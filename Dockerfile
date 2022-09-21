FROM core.harbor.k8s.bisdn.de/docker-hub/library/ubuntu:20.04 AS base
LABEL maintainer="jan.klare@bisdn.de"
ENV DEBIAN_FRONTEND=noninteractive

# Obsolete dependencies
#
# Some of the packages are only needed for building older versions, and can be
# dropped once we stop supporting these versions.
#
# Only needed for versions before 4.6.1:
#   python (can be then replaced with python-is-python3)
#   python-dev
#   python-yaml
#
# Only needed for versions before 4.7.0:
#   libelf-dev

# Ignore hadolint requirement to pin each packages version, since we want to get
# the latest and greatest version from the ubuntu repositories.
# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y \
  build-essential \
  chrpath \
  cpio \
  curl \
  diffstat \
  file \
  gawk \
  gcc-multilib \
  git-core \
  libelf-dev \
  liblz4-tool \
  libncurses5-dev \
  locales \
  moreutils \
  openssh-client \
  python2 \
  python2-dev \
  python-yaml \
  python3 \
  python3-pip \
  python-is-python3 \
  socat \
  texinfo \
  tmux \
  unzip \
  vim \
  wget \
  xterm \
  zstd \
  && apt-get clean \
  && rm -rf  /var/lib/apt/lists/* \
  && locale-gen en_US.UTF-8 \
  && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
COPY ./repo /usr/bin/repo
RUN useradd -ms /bin/bash builder
COPY gitconfig /home/builder/.gitconfig
RUN mkdir /home/builder/.ssh \
    && chown builder:builder /home/builder/.ssh \
    && mkdir /home/builder/output \
    && chown builder:builder /home/builder/output

WORKDIR /home/builder/

FROM base AS ci
USER builder
