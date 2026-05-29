# 📂 SSHFS Linux Integration — Mount Remote Server as Local Folder

> Mount a remote Ubuntu server directory as a local folder on your Linux machine using SSHFS, enabling direct file access and editing without SCP or FTP.

![SSHFS](https://img.shields.io/badge/SSHFS-Linux-FCC624?logo=linux)
![SSH](https://img.shields.io/badge/SSH-Secure-black)

---

## 📖 Overview

SSHFS (SSH Filesystem) lets you mount a remote server's directory as if it were a local folder. This project documents the full setup including mounting, unmounting, and practical use for web development workflows.

---

## 🏗️ Architecture

```
Linux Machine
└── ~/mnt/  (local mount point)
    └── SSHFS over SSH
        └── Ubuntu Server
            └── /var/www/dbfarm  (remote directory)
```

---

## ⚙️ Setup Guide

### Step 1 — Install SSHFS

```bash
sudo apt install sshfs
```

---

### Step 2 — Create Mount Point

```bash
mkdir -p ~/mnt
```

---

### Step 3 — Mount Remote Directory

```bash
bash scripts/sshfs_mount.sh
```

Or manually:

```bash
sshfs username@server_ip:/var/www/dbfarm ~/mnt
```

You can now browse `/var/www/dbfarm` on the server from `~/mnt` locally.

---

### Step 4 — Unmount

```bash
bash scripts/sshfs_unmount.sh
```

Or manually:

```bash
fusermount -u ~/mnt
```

---

### Step 5 — (Optional) Persistent Mount via fstab

Add to `/etc/fstab` for automatic mounting on boot:

```
username@server_ip:/var/www/dbfarm /home/youruser/mnt fuse.sshfs defaults,_netdev,IdentityFile=/home/youruser/.ssh/id_ed25519 0 0
```

---

## 📁 Project Structure

```
sshfs-linux-integration/
├── scripts/
│   ├── sshfs_mount.sh
│   └── sshfs_unmount.sh
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🐛 Troubleshooting

### Transport endpoint is not connected
The connection dropped. Unmount and remount:
```bash
fusermount -u ~/mnt
bash scripts/sshfs_mount.sh
```

### Permission Denied
Ensure your SSH key is authorized on the server and the remote path is accessible by your user.

---

## 💡 Key Takeaways

- SSHFS is ideal for editing remote web server files with a local editor
- It uses the existing SSH connection — no extra server setup required
- For production, use key-based auth only (no passwords)

---

## 📄 License
MIT

---
*Built on Linux + Ubuntu Server — 2026*
