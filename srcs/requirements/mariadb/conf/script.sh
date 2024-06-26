#!/bin/bash

echo -n "" > /var/lib/mysql/init.sql

cat <<EOF > /var/lib/mysql/init.sql
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$WP_PASSWORD';
CREATE DATABASE IF NOT EXISTS $WP_DB;
CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_PASSWORD';
CREATE USER IF NOT EXISTS '$WP_ADMIN_USER'@'%' IDENTIFIED BY '$WP_ADMIN_PASSWORD';
GRANT ALL PRIVILEGES ON $WP_DB.* TO '$WP_USER'@'%';
GRANT ALL PRIVILEGES ON $WP_DB.* TO '$WP_ADMIN_USER'@'%';
FLUSH PRIVILEGES;
EOF

chown -R mysql:mysql /var/lib/mysql

mariadb-install-db

exec mariadbd --user=mysql --datadir=/var/lib/mysql

mysqld

# mysql_install_db


