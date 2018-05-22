FROM ubuntu:16.04
MAINTAINER Brandon Sanders

# Parse environment args.
ARG ZONE_IP
ENV ZONE_IP=$ZONE_IP

ARG DS_USERNAME
ENV DS_USERNAME=$DS_USERNAME

ARG DS_PASSWORD
ENV DS_PASSWORD=$DS_PASSWORD

ARG DS_SERVERNAME
ENV DS_SERVERNAME=$DS_SERVERNAME

# Relink /bin/bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Prepare environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install packages.
RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y libmysqlclient-dev libluajit-5.1-dev libzmq3-dev autoconf pkg-config software-properties-common build-essential
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y g++-7
RUN apt-get install -y netcat mysql-client

# Setup symlinks.
WORKDIR /usr/bin
RUN rm gcc g++ cpp
RUN ln -s gcc-7 gcc
RUN ln -s g++-7 g++
RUN ln -s cpp-7 cpp

# Create Dockstar user.
RUN useradd -ms /bin/bash dockstar
WORKDIR /home/dockstar

# Copy Darkstar source and prepare for build.
COPY darkstar /home/dockstar/darkstar
RUN chown -R dockstar: /home/dockstar/darkstar
WORKDIR /home/dockstar/darkstar

# Build Darkstar.
USER dockstar
RUN sh autogen.sh && ./configure --enable-debug=gdb && make -j 8

# Copy server script.
COPY scripts/start-darkstar.sh /home/dockstar/darkstar/start-darkstar.sh

# Copy server settings.
COPY conf/login_darkstar.conf /home/dockstar/darkstar/conf/login_darkstar.conf
COPY conf/map_darkstar.conf /home/dockstar/darkstar/conf/map_darkstar.conf
COPY conf/search_server.conf /home/dockstar/darkstar/conf/search_server.conf
COPY conf/server_message.conf /home/dockstar/darkstar/conf/server_message.conf
COPY conf/settings.lua /home/dockstar/darkstar/scripts/settings.lua

# Process server settings.
COPY scripts/process-env.sh /home/dockstar/darkstar/conf/process-env.sh
WORKDIR /home/dockstar/darkstar/conf
RUN sh process-env.sh

# Reset working directory so that the start script doesn't freak out.
WORKDIR /home/dockstar/darkstar

# Start server.
CMD ["/home/dockstar/darkstar/start-darkstar.sh"]
