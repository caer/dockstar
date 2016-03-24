FROM ubuntu:latest
MAINTAINER Brandon Sanders

# Relink /bin/bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install packages.
RUN apt-get update && apt-get install -y libmysqlclient-dev libluajit-5.1-dev libzmq3-dev autoconf pkg-config software-properties-common build-essential
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y g++-5

# Setup symlinks.
WORKDIR /usr/bin
RUN rm gcc g++ cpp
RUN ln -s gcc-5 gcc
RUN ln -s g++-5 g++
RUN ln -s cpp-5 cpp

# Create Altimit user.
RUN useradd -ms /bin/bash altimit
WORKDIR /home/altimit

# Copy Darkstar source and prepare for build.
COPY darkstar /home/altimit/darkstar
RUN chown -R altimit: /home/altimit/darkstar
WORKDIR /home/altimit/darkstar

# Build Darkstar.
USER altimit
RUN sh autogen.sh && ./configure --enable-debug=gdb && make

# Copy server script.
COPY scripts/start-darkstar.sh /home/altimit/darkstar/start-darkstar.sh

# Copy server settings.
COPY conf/login_darkstar.conf /home/altimit/darkstar/conf/login_darkstar.conf
COPY conf/map_darkstar.conf /home/altimit/darkstar/conf/map_darkstar.conf
COPY conf/search_server.conf /home/altimit/darkstar/conf/search_server.conf
COPY conf/server_message.conf /home/altimit/darkstar/conf/server_message.conf

# Process server settings.
COPY config.sh /home/altimit/darkstar/conf/config.sh
COPY scripts/process-configs.sh /home/altimit/darkstar/conf/process-configs.sh
WORKDIR /home/altimit/darkstar/conf
RUN sh process-configs.sh && cat login_darkstar.conf

# Reset working directory so that the start script doesn't freak out.
WORKDIR /home/altimit/darkstar

# Start server.
CMD ["/home/altimit/darkstar/start-darkstar.sh"]
