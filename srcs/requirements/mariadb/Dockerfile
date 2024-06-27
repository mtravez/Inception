FROM debian:bullseye
RUN apt update -y && apt upgrade -y
RUN apt install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
&& chmod 777 /var/run/mysqld

RUN chmod 777 /var/lib/mysql

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/
# COPY conf/init.sql /etc/mysql/init.sql
COPY tools/script.sh .

RUN chmod +x script.sh

EXPOSE 3306

CMD [ "./script.sh" ]