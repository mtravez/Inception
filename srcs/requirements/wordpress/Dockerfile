FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y php7.4 \
php7.4-fpm \
php7.4-mysql \
mariadb-client \
curl

RUN wget https://wordpress.org/latest.tar.gz -P /var/www
RUN cd /var/www && tar -xzf latest.tar.gz && rm latest.tar.gz
# RUN chown -R root:root /var/www/wordpress

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY conf/script.sh .

RUN mkdir /run/php/ /var/www/html
RUN chmod 755 /var/www/html

EXPOSE 9000

RUN chmod +x script.sh
CMD ["./script.sh"]