# 🗄️ MySQL Database Deployment — Relational Schema Setup

> A complete relational database schema for a Farm Management System, with setup, import scripts, and user configuration.

![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%20Server-E95420?logo=ubuntu)

---

## 📖 Overview

This project covers the full deployment of a relational MySQL database for a farm management web application. It includes the schema design with foreign key relationships, user creation, privilege management, and import scripts.

---

## 🗂️ Schema Design

```
tbrole ──────────────┐
tbprovince ──────┐   │
                 ▼   ▼
tbcitymuni ──► tbuser ──► tbfarm ──► tbfarmsupply
                                          ▲
tbcrop ───────────────────────────────────┘
audit_trail (standalone)
```

---

## ⚙️ Setup Guide

### Step 1 — Login to MySQL

```bash
sudo mysql -u root -p
```

---

### Step 2 — Create Database and User

```sql
CREATE DATABASE dbfarm2;
CREATE USER 'user01'@'localhost' IDENTIFIED BY 'yourpassword';
GRANT ALL PRIVILEGES ON dbfarm2.* TO 'user01'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

---

### Step 3 — Import Schema

```bash
bash sql/db_import.sh
```

Or manually:

```bash
mysql -u user01 -p dbfarm2 < sql/schema.sql
```

---

### Step 4 — Verify Tables

```bash
mysql -u user01 -p dbfarm2
```

```sql
SHOW TABLES;
DESCRIBE tbuser;
```

---

## 📁 Project Structure

```
mysql-database-deployment/
├── sql/
│   ├── schema.sql
│   └── db_import.sh
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🐛 Troubleshooting

### Access Denied on Import
Make sure the user has been granted privileges before importing:
```sql
GRANT ALL PRIVILEGES ON dbfarm2.* TO 'user01'@'localhost';
FLUSH PRIVILEGES;
```

### Foreign Key Errors on Import
Tables must be created in dependency order. The schema.sql is already ordered correctly — import it as a whole file, not table by table.

---

## 💡 Key Takeaways

- Always use a dedicated database user — never connect apps as root
- Foreign keys enforce relational integrity at the database level
- An audit trail table is a simple but powerful way to track changes

---

## 📄 License
MIT

---
*Built on Ubuntu Server — 2026*
