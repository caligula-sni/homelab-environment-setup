#!/bin/bash
nginx -s stop
pkill php-fpm8.4
pkill mysqld_safe
pkill mysqld
echo "LEMP stack stopped."
