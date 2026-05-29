# 🔐 Remote SSH via Cloudflare Tunnel — SSH from Anywhere

> Access your home server or VM via SSH from anywhere in the world using Cloudflare Tunnel — no open ports, no public IP, no VPN required.

![Cloudflare](https://img.shields.io/badge/Cloudflare-Tunnel-F38020?logo=cloudflare)
![SSH](https://img.shields.io/badge/SSH-Remote%20Access-black)

---

## 📖 Overview

This project extends the Cloudflare Tunnel setup to support SSH access. By routing SSH through Cloudflare's network, you can securely connect to your server from anywhere without exposing port 22 to the internet.

---

## 🏗️ Architecture

```
Remote Machine (anywhere)
└── cloudflared access ssh (client-side proxy)
    └── Cloudflare Network
        └── Cloudflare Tunnel
            └── Your Server
                └── SSH :22
```

---

## 📋 Prerequisites

- Cloudflare Tunnel already set up (see cloudflare-tunnel-setup repo)
- `cloudflared` installed on both server and client machine
- SSH key-based authentication configured

---

## ⚙️ Setup Guide

### Step 1 — Expose SSH via Tunnel (Server Side)

Run the SSH tunnel:

```bash
bash configs/cloudflare_ssh_tunnel.sh
```

Or add SSH to your existing tunnel config (`~/.cloudflared/config.yml`):

```yaml
ingress:
  - hostname: yourdomain.com
    service: http://localhost:80
  - hostname: ssh.yourdomain.com
    service: ssh://localhost:22
  - service: http_status:404
```

Route the DNS:
```bash
cloudflared tunnel route dns my-tunnel ssh.yourdomain.com
```

---

### Step 2 — Install cloudflared on Client Machine

```bash
# Linux/Mac
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/

# Windows
# Download from https://github.com/cloudflare/cloudflared/releases
```

---

### Step 3 — Configure SSH Client

Apply the config from `configs/ssh_config.sample`. Add to `~/.ssh/config`:

```
Host ssh.yourdomain.com
    ProxyCommand cloudflared access ssh --hostname %h
    User yourusername
    IdentityFile ~/.ssh/id_ed25519
```

---

### Step 4 — Connect

```bash
ssh ssh.yourdomain.com
```

---

## 📁 Project Structure

```
remote-ssh-via-cloudflare/
├── configs/
│   ├── cloudflare_ssh_tunnel.sh
│   └── ssh_config.sample
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🔐 Security Notes

- This setup has **no exposed ports** — SSH is not directly reachable from the internet
- All traffic is encrypted end-to-end via Cloudflare
- Always use SSH key authentication — never password auth
- Apply the hardening settings from `ssh_config.sample` to your server's `/etc/ssh/sshd_config`

---

## 🐛 Troubleshooting

### Connection Refused
Make sure the SSH tunnel is running on the server side first:
```bash
bash configs/cloudflare_ssh_tunnel.sh
```

### Host Key Verification Failed
Clear the old host key and reconnect:
```bash
ssh-keygen -R ssh.yourdomain.com
```

---

## 💡 Key Takeaways

- Cloudflare SSH tunnel is more secure than exposing port 22 directly
- Works from any network — office, phone hotspot, or public WiFi
- Combines perfectly with key-based auth for a zero-trust SSH setup

---

## 📄 License
MIT

---
*Built during homelab remote access setup — 2026*
