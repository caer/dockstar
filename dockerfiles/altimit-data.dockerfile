FROM ubuntu
MAINTAINER Brandon Sanders

# Initialize MySQL.
RUN apt-get update && apt-get install -y mysql-server

# Copy darkstar and seed files.
COPY darkstar /tmp/darkstar
COPY scripts/seed-mysql.sh /tmp/darkstar/sql/seed-mysql.sh

# Prepare MySQL.
WORKDIR /tmp/darkstar/sql
RUN service mysql start && sleep 10 && sh seed-mysql.sh

# Clean up temp and remove MySQL install.
WORKDIR /
RUN rm -r /tmp/darkstar
RUN apt-get remove -y mysql-server && apt-get autoremove -y
RUN touch /var/lib/mysql/dockstar

# Create MySQL persistence volume.
VOLUME /var/lib/mysql

# Prepare data entrypoint.
CMD ["/bin/true"]
