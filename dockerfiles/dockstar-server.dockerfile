FROM ubuntu:14.04
MAINTAINER Brandon Sanders

# Relink /bin/bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Prepare environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install base packages.
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y git libmysqlclient-dev libluajit-5.1-dev libzmq3-dev autoconf pkg-config build-essential
RUN apt-get update && apt-get install -y luajit-5.1-dev libzmq3-dev g++-7 mysql-client-core-5.6 mysql-server-5.6 mysql-client-5.6

# Setup symlinks.
RUN update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-7 90
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 90
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 90
RUN update-alternatives --config cpp
RUN update-alternatives --config gcc
RUN update-alternatives --config g++

# Create Dockstar user.
RUN useradd -ms /bin/bash dockstar
WORKDIR /home/dockstar

# Copy Darkstar source and prepare for build.
COPY darkstar /home/dockstar/darkstar
RUN chown -R dockstar: /home/dockstar/darkstar
WORKDIR /home/dockstar/darkstar

# Install run-time networking utils.
# These are used to ping the mysql server until it is up.
RUN apt-get install -y netcat

# Build Darkstar.
USER dockstar
RUN sh autogen.sh && ./configure --enable-debug=gdb && make -j 8

# Touch files that we will expect composer to inject at run-time.
RUN touch start-darkstar.sh \
          conf/login_darkstar.skel \
          conf/map_darkstar.skel \
          conf/search_server.skel \
          conf/server_message.skel

# Start server.
CMD ["/home/dockstar/darkstar/start-darkstar.sh"]
