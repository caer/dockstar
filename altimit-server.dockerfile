FROM ubuntu:latest
MAINTAINER Brandon Sanders

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
COPY start-darkstar.sh /home/altimit/darkstar/start-darkstar.sh

# Copy server settings.
COPY login_darkstar.conf /home/altimit/darkstar/conf/login_darkstar.conf
COPY map_darkstar.conf /home/altimit/darkstar/conf/map_darkstar.conf
COPY search_server.conf /home/altimit/darkstar/conf/search_server.conf
COPY server_message.conf /home/altimit/darkstar/conf/server_message.conf

# Start server.
CMD ["/home/altimit/darkstar/start-darkstar.sh"]
