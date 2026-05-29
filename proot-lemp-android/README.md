# 🌾 Farm Management System — Mobile LEMP Stack Deployment

> A full LEMP stack web server running entirely on an Android phone using Termux and proot — no laptop, no VPS, no root required.

![Platform](https://img.shields.io/badge/Platform-Android%20ARM64-brightgreen)
![OS](https://img.shields.io/badge/OS-Debian%20via%20PRoot-blue)
![Nginx](https://img.shields.io/badge/Nginx-1.26.3-009639?logo=nginx)
![PHP](https://img.shields.io/badge/PHP-8.4.16-777BB4?logo=php)
![MariaDB](https://img.shields.io/badge/MariaDB-11.8.6-003545?logo=mariadb)

---

## 📖 Overview

This project documents the complete setup of a production-style LEMP stack on an Android phone, serving a real PHP web application with a relational database — all inside a proot Debian environment via Termux.

The goal was to create a fully functional personal development environment without relying on a laptop or cloud server, demonstrating that modern Android hardware is capable of running a complete web server stack.

---

## 🏗️ Architecture

```
📱 Android Phone
└── 📦 Termux
    └── 🐧 Proot Debian (ARM64)
        ├── 🌐 Nginx :8080
        │   └── ⚙️ PHP 8.4-FPM
        │       └── 🌾 Farm-Management-System
        │           └── 🗄️ MariaDB → dbfarm2
        ├── ✏️ Acode Editor
        │   └── ~/Farm-Management-System
        │       └── symlink → /var/www/
        └── 🔜 Cloudflare Tunnel (Planned)
            └── yourdomain.eu.org → :8080
```

---

## 🛠️ Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| Web Server | Nginx | 1.26.3 |
| Backend | PHP-FPM | 8.4.16 |
| Database | MariaDB | 11.8.6 |
| OS | Debian (proot) | Trixie |
| Runtime | Android ARM64 | — |
| Editor | Acode (mobile) | — |

---

## ⚙️ Setup Guide

### Prerequisites
- Android phone with Termux installed
- proot-distro installed in Termux
- Debian installed via proot-distro

```bash
pkg install proot-distro
proot-distro install debian
proot-distro login debian
```

---

### Step 1 — Install LEMP Stack

```bash
apt update && apt upgrade -y
apt install -y nginx mariadb-server php-fpm php-mysql
```

> **Note:** Warnings about `debconf`, `invoke-rc.d`, and `netlink socket` are expected in proot and do not affect functionality.

---

### Step 2 — Configure Nginx

proot cannot bind to ports below 1024, so Nginx runs on port **8080**. Use the config from `configs/nginx_server_block.conf`:

```bash
nano /etc/nginx/sites-available/default
```

Test and start:
```bash
nginx -t
nginx
```

---

### Step 3 — Setup MariaDB

```bash
mysqld_safe --datadir=/var/lib/mysql &
mariadb -u root
```

```sql
CREATE DATABASE IF NOT EXISTS dbfarm2;
CREATE USER 'user01'@'localhost' IDENTIFIED BY 'yourpassword';
GRANT ALL PRIVILEGES ON dbfarm2.* TO 'user01'@'localhost';
FLUSH PRIVILEGES;
```

---

### Step 4 — Deploy Application

```bash
cd /var/www
git clone https://github.com/yourusername/Farm-Management-System.git
php-fpm8.4
```

Visit: `http://localhost:8080`

---

### Step 5 — Acode Editor Integration

```bash
# Run in regular Termux (not inside proot)
ln -s $PREFIX/var/lib/proot-distro/installed-rootfs/debian/var/www/Farm-Management-System ~/Farm-Management-System
```

Every save in Acode reflects on the live site instantly.

---

## 📜 Service Management Scripts

```bash
bash scripts/startlemp.sh    # Start all services
bash scripts/stoplemp.sh     # Stop all services
bash scripts/statuslemp.sh   # Check service status
```

Make executable:
```bash
chmod +x scripts/*.sh
```

---

## 📁 Project Structure

```
proot-lemp-android/
├── configs/
│   └── nginx_server_block.conf
├── scripts/
│   ├── startlemp.sh
│   ├── stoplemp.sh
│   └── statuslemp.sh
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🗺️ Roadmap

- [x] Nginx running on port 8080
- [x] PHP 8.4-FPM configured
- [x] MariaDB with full relational schema
- [x] Farm Management System deployed
- [x] Acode live editing via symlink
- [x] Service management scripts
- [ ] Cloudflare Tunnel with eu.org domain
- [ ] HTTPS via Cloudflare
- [ ] DVWA setup for cybersecurity practice
- [ ] Python + Claude API Agentic AI experiments

---

## 🐛 Troubleshooting

### Nginx: Permission denied on port 80
proot cannot bind to ports below 1024. Use port 8080 in your config.

### MariaDB: Access denied
```sql
DROP USER IF EXISTS 'username'@'localhost';
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON dbname.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
```

### Services not running after restart
Run `bash scripts/startlemp.sh` every time you login to proot — no systemd in proot.

---

## 💡 Key Takeaways

- A modern Android phone running proot is fully capable of serving a real PHP web application
- proot limitations are all workable — port 8080 and manual service start solve everything
- Symlinks bridge proot's isolated filesystem to Termux for seamless mobile editing
- Zero additional hardware or cloud costs

---

## 📄 License
MIT

---
*Built entirely on Android — April 2026*
