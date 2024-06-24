FROM debian:bullseye
RUN apt update -y
RUN apt install nginx -y
RUN apt install vim -y
RUN apt install curl -y
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
-out /etc/nginx/ssl/inception.crt \
-keyout /etc/nginx/ssl/inception.key \
-subj "/C=DE/ST=BW/L=Heilbronn/O=42/OU=42/CN=mtravez.42.fr/UID=mtravez"
RUN mkdir -p /var/run/nginx

COPY conf/default /etc/nginx/sites-available/.

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]