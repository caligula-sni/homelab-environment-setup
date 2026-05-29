# 💻 VS Code Remote SSH Setup — Code on a Server from Windows

> Connect Visual Studio Code on Windows to a remote Ubuntu server via SSH for a seamless remote development experience.

![VSCode](https://img.shields.io/badge/VS%20Code-007ACC?logo=visualstudiocode)
![SSH](https://img.shields.io/badge/SSH-Remote-black)
![Platform](https://img.shields.io/badge/Platform-Windows%20→%20Ubuntu-0078D6?logo=windows)

---

## 📖 Overview

This project documents how to configure VS Code's Remote SSH extension to connect directly to an Ubuntu server, enabling full code editing, terminal access, and file management from a Windows machine — as if the server files were local.

---

## 🏗️ Architecture

```
Windows (VS Code)
└── Remote SSH Extension
    └── SSH Connection
        └── Ubuntu Server
            └── /var/www/your-project
```

---

## ⚙️ Setup Guide

### Step 1 — Install VS Code Extension

In VS Code, install the **Remote - SSH** extension by Microsoft.

---

### Step 2 — Generate SSH Key on Windows

Open PowerShell:

```powershell
ssh-keygen -t ed25519 -C "you@example.com"
```

---

### Step 3 — Copy Key to Server

```powershell
ssh-copy-id username@server_ip
```

Or manually append `~/.ssh/id_ed25519.pub` contents to `~/.ssh/authorized_keys` on the server.

---

### Step 4 — Configure SSH on Server

Apply the security settings from `configs/ssh_config.sample`:

```bash
sudo nano /etc/ssh/sshd_config
```

Key settings:
```
PasswordAuthentication no
PermitRootLogin no
```

Restart SSH:

```bash
sudo systemctl restart sshd
```

---

### Step 5 — Connect in VS Code

1. Press `Ctrl+Shift+P`
2. Type: `Remote-SSH: Connect to Host`
3. Enter: `username@server_ip`
4. VS Code connects and installs its server component automatically

---

### Step 6 — Open Your Project

Once connected, use **File → Open Folder** to open `/var/www/your-project` directly on the server.

---

## 📁 Project Structure

```
vscode-remote-ssh-setup/
├── configs/
│   └── ssh_config.sample
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🐛 Troubleshooting

### Connection Timeout
- Check your server's firewall allows port 22: `sudo ufw allow ssh`
- Verify the server IP is correct and reachable: `ping server_ip`

### Permission Denied After Disabling Password Auth
You must copy your SSH key to the server **before** disabling password authentication.

---

## 💡 Key Takeaways

- Remote SSH turns VS Code into a full remote IDE with zero latency for file saves
- Disabling password authentication eliminates brute force attack risk on port 22
- This workflow replaces the need for FTP/SFTP clients entirely

---

## 📄 License
MIT

---
*Built on Windows + Ubuntu Server — 2026*
