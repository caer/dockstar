FROM ubuntu
MAINTAINER Brandon Sanders

# Initialize MySQL.
RUN apt-get update && apt-get install -y mysql-server

# Create mysql persistence volume.
VOLUME /var/lib/mysql

# Prepare entrypoint.
COPY config.sh /config.sh
COPY scripts/start-mysql.sh /start.sh
CMD ["sh", "-c", "/start.sh"]

EXPOSE 3306
