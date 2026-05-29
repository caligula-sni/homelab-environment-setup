#!/bin/bash
echo "=== Nginx ==="
pgrep nginx && echo "Running" || echo "Stopped"

echo "=== PHP-FPM ==="
pgrep php-fpm8.4 && echo "Running" || echo "Stopped"

echo "=== MariaDB ==="
pgrep mysqld && echo "Running" || echo "Stopped"
