# 🔧 Git Server Deployment — Remote Repository Setup

> Setting up Git on an Ubuntu server for version-controlled deployment of web applications, with SSH-based cloning and pushing.

![Git](https://img.shields.io/badge/Git-F05032?logo=git)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%20Server-E95420?logo=ubuntu)

---

## 📖 Overview

This project covers configuring Git on a remote Ubuntu server, setting global identity, cloning repositories into the web root, and establishing a Git-based deployment workflow via SSH.

---

## ⚙️ Setup Guide

### Step 1 — Install Git

```bash
sudo apt update
sudo apt install -y git
```

---

### Step 2 — Configure Git Identity

```bash
bash scripts/git_setup.sh
```

Or manually:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

---

### Step 3 — Generate SSH Key (for GitHub access)

```bash
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub
```

Add the output to your GitHub account under **Settings → SSH Keys**.

---

### Step 4 — Clone Your Repository

```bash
cd /var/www
sudo git clone git@github.com:yourusername/your-repo.git
```

---

### Step 5 — Pull Updates (Deployment Workflow)

```bash
cd /var/www/your-repo
sudo git pull origin main
sudo systemctl reload nginx
```

---

## 📁 Project Structure

```
git-server-deployment/
├── scripts/
│   └── git_setup.sh
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🐛 Troubleshooting

### Permission Denied (publickey)
Your SSH key is not added to GitHub. Re-run:
```bash
cat ~/.ssh/id_ed25519.pub
```
And add it to GitHub → Settings → SSH and GPG keys.

### Cannot write to /var/www
Use `sudo` or fix ownership:
```bash
sudo chown -R $USER:$USER /var/www/your-repo
```

---

## 💡 Key Takeaways

- SSH key authentication is more secure than HTTPS with passwords for server deployments
- Git pull is a simple and effective manual deployment strategy for small projects
- Always verify the remote URL with `git remote -v` before pushing

---

## 📄 License
MIT

---
*Built on Ubuntu Server — 2026*
