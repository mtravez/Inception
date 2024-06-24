FROM debian:buster
RUN apt update -y && apt upgrade -y
RUN apt install -y mariadb-server

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/init.sql /etc/mysql/init.sql
COPY conf/script.sh .

RUN mkdir /run/mysqld && chmod +x script.sh
CMD [ "./script.sh" ]