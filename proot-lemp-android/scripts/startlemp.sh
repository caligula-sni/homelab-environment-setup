#!/bin/bash
mysqld_safe --datadir=/var/lib/mysql &
sleep 3
php-fpm8.4
nginx
echo "LEMP stack is running on http://localhost:8080"
