# 💾 MySQL Backup System — Automated Database Backups with Cron

> Automated daily MySQL database backups using mysqldump and cron — a simple but reliable backup strategy for self-hosted web applications.

![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql)
![Bash](https://img.shields.io/badge/Bash-Script-4EAA25?logo=gnubash)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%20Server-E95420?logo=ubuntu)

---

## 📖 Overview

This project implements an automated backup system for a MySQL database using a bash script and cron job. Backups run daily at 2 AM and store timestamped `.sql` dump files for easy restoration.

---

## 🏗️ Architecture

```
Cron (2:00 AM daily)
└── backup.sh
    └── mysqldump
        └── dbfarm2
            └── /home/backup/dbfarm2_backup.sql
```

---

## ⚙️ Setup Guide

### Step 1 — Create Backup Directory

```bash
mkdir -p /home/backup
```

---

### Step 2 — Review the Backup Script

Edit `scripts/backup.sh` and replace the placeholder values:

```bash
nano scripts/backup.sh
```

Update:
- `YOURPASSWORD` → your actual MySQL root password
- `dbfarm2` → your database name
- `/home/backup/` → your preferred backup path

> ⚠️ Never commit this file with real credentials. Use a `.my.cnf` file instead (see below).

---

### Step 3 — Secure Credentials with .my.cnf (Recommended)

Instead of hardcoding the password in the script, create:

```bash
nano ~/.my.cnf
```

```ini
[mysqldump]
user=root
password=YOURPASSWORD
```

```bash
chmod 600 ~/.my.cnf
```

Then update `backup.sh` to remove the `-pYOURPASSWORD` flag:

```bash
mysqldump dbfarm2 > /home/backup/dbfarm2_backup.sql
```

---

### Step 4 — Make Script Executable

```bash
chmod +x scripts/backup.sh
```

---

### Step 5 — Add Timestamped Backups (Recommended)

Modify the backup script to keep a history:

```bash
mysqldump dbfarm2 > /home/backup/dbfarm2_$(date +%Y%m%d_%H%M%S).sql
```

---

### Step 6 — Schedule with Cron

```bash
crontab -e
```

Add the line from `scripts/cron_backup.txt`:

```
0 2 * * * /home/youruser/scripts/backup.sh
```

This runs the backup every day at 2:00 AM.

---

### Step 7 — Verify Cron is Running

```bash
crontab -l
sudo systemctl status cron
```

---

## 📁 Project Structure

```
mysql-backup-system/
├── scripts/
│   ├── backup.sh
│   └── cron_backup.txt
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🔄 Restoring a Backup

```bash
mysql -u root -p dbfarm2 < /home/backup/dbfarm2_backup.sql
```

---

## 🐛 Troubleshooting

### mysqldump: Access Denied
Your MySQL credentials are incorrect. Verify with:
```bash
mysql -u root -p
```

### Cron Job Not Running
Check cron logs:
```bash
grep CRON /var/log/syslog | tail -20
```

---

## 💡 Key Takeaways

- Never store database credentials in scripts committed to GitHub
- Timestamped backups allow point-in-time recovery
- For critical data, also copy backups offsite (cloud storage, external drive)

---

## 📄 License
MIT

---
*Built on Ubuntu Server — 2026*
