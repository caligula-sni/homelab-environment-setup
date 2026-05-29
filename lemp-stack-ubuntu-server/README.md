# 🌐 LEMP Stack — Ubuntu Server Setup

> A complete LEMP stack (Linux, Nginx, MySQL, PHP) deployed on an Ubuntu server for hosting PHP web applications.

![Platform](https://img.shields.io/badge/Platform-Ubuntu%20Server-E95420?logo=ubuntu)
![Nginx](https://img.shields.io/badge/Nginx-009639?logo=nginx)
![PHP](https://img.shields.io/badge/PHP-8.3-777BB4?logo=php)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql)

---

## 📖 Overview

This project documents the full setup of a LEMP stack on a bare Ubuntu server, serving a PHP web application with a relational MySQL database. It covers installation, configuration, permissions, and deployment from a GitHub repository.

---

## 🏗️ Architecture

```
Ubuntu Server
├── Nginx (Web Server) :80
│   └── PHP 8.3-FPM
│       └── PHP Web Application
│           └── MySQL → dbfarm2
└── SSH Access (key-based)
```

---

## 🛠️ Stack

| Component  | Technology  |
|------------|-------------|
| Web Server | Nginx       |
| Backend    | PHP 8.3-FPM |
| Database   | MySQL       |
| OS         | Ubuntu Server |

---

## ⚙️ Setup Guide

### Step 1 — Update System

```bash
sudo apt update && sudo apt upgrade -y
```

---

### Step 2 — Install LEMP Stack

```bash
sudo apt install -y nginx mysql-server php-fpm php-mysql
```

---

### Step 3 — Configure Nginx

```bash
sudo nano /etc/nginx/sites-available/default
```

Use the config from `configs/nginx_server_block.conf`. Then test and reload:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

---

### Step 4 — Setup MySQL

```bash
sudo mysql_secure_installation
sudo mysql -u root -p
```

```sql
CREATE DATABASE dbfarm2;
CREATE USER 'user01'@'localhost' IDENTIFIED BY 'yourpassword';
GRANT ALL PRIVILEGES ON dbfarm2.* TO 'user01'@'localhost';
FLUSH PRIVILEGES;
```

Import the schema:

```bash
bash sql/db_import.sh
```

---

### Step 5 — Fix Web Root Permissions

```bash
bash scripts/fix_permissions.sh
```

---

### Step 6 — Deploy Application

```bash
cd /var/www
sudo git clone https://github.com/yourusername/your-app.git
sudo systemctl restart php8.3-fpm nginx
```

---

## 📁 Project Structure

```
lemp-stack-ubuntu-server/
├── configs/
│   └── nginx_server_block.conf
├── scripts/
│   └── fix_permissions.sh
├── sql/
│   └── schema.sql
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🐛 Troubleshooting

### Nginx: 502 Bad Gateway
PHP-FPM is not running. Check the socket path in your nginx config matches the installed PHP version.
```bash
sudo systemctl status php8.3-fpm
sudo systemctl start php8.3-fpm
```

### MySQL: Access Denied
Recreate the user with matching credentials to your PHP config:
```sql
DROP USER IF EXISTS 'username'@'localhost';
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON dbname.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
```

---

## 💡 Key Takeaways

- Nginx + PHP-FPM is faster and more memory-efficient than Apache + mod_php
- Always use `mysql_secure_installation` before exposing a server
- Keep web root permissions set to `www-data` to avoid permission issues

---

## 📄 License
MIT

---
*Built on Ubuntu Server — 2026*
