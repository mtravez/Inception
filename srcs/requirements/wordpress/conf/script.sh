#!/bin/bash

set -e 

cd /var/www/html

# Ensure the PHP run directory exists
if [ ! -d /run/php ]; then
    mkdir /run/php
fi

# Ensure wp-cli is installed
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Download and extract WordPress if it's not already installed
if [ ! -d wp-admin ]; then
    wget -q https://wordpress.org/latest.tar.gz -P .
    tar -xzf latest.tar.gz --strip-components=1
    rm -rf latest.tar.gz
fi

# Create the wp-config.php file if it doesn't exist
if [ ! -f wp-config.php ]; then
	# wp core download --allow-root
    wp config create --dbname=$WP_DB \
                     --dbuser=$WP_USER \
                     --dbpass=$WP_PASSWORD \
                     --dbhost=$HOSTNAME \
                     --path='/var/www/html' \
                     --allow-root

    wp core install --url=$URL \
                    --title=inception \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --allow-root

    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
fi

# Start PHP-FPM
php-fpm7.4 -F