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

# Copy server script.
COPY scripts/start-darkstar.sh /home/dockstar/darkstar/start-darkstar.sh

# Copy server setting files.
COPY conf/login_darkstar.conf /home/dockstar/darkstar/conf/login_darkstar.conf
COPY conf/map_darkstar.conf /home/dockstar/darkstar/conf/map_darkstar.conf
COPY conf/search_server.conf /home/dockstar/darkstar/conf/search_server.conf
COPY conf/server_message.conf /home/dockstar/darkstar/conf/server_message.conf
COPY conf/settings.lua /home/dockstar/darkstar/scripts/settings.lua

# Parse environment args.
ARG DS_USERNAME
ENV DS_USERNAME=$DS_USERNAME

ARG DS_PASSWORD
ENV DS_PASSWORD=$DS_PASSWORD

ARG DS_SERVERNAME
ENV DS_SERVERNAME=$DS_SERVERNAME

# Process server settings.
COPY scripts/process-env.sh /home/dockstar/darkstar/conf/process-env.sh
WORKDIR /home/dockstar/darkstar/conf
RUN sh process-env.sh

# Reset working directory so that the start script doesn't freak out.
WORKDIR /home/dockstar/darkstar

# Start server.
CMD ["/home/dockstar/darkstar/start-darkstar.sh"]
