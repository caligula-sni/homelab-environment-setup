# 🚇 Ngrok Tunneling Setup — Expose Local Server to the Internet

> Use Ngrok to create a secure HTTP/HTTPS tunnel from a local or VM-hosted server to a public URL — bypassing CGNAT and firewall restrictions.

![Ngrok](https://img.shields.io/badge/Ngrok-Tunnel-1F1F1F)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%20Server-E95420?logo=ubuntu)

---

## 📖 Overview

This project documents using Ngrok to expose a locally hosted web server to the internet via a secure tunnel. This is particularly useful when behind CGNAT where traditional port forwarding does not work.

---

## 🏗️ Architecture

```
Internet User
└── https://xxxx.ngrok.io  (Ngrok public URL)
    └── Ngrok Cloud Servers
        └── Ngrok Agent (running on your server)
            └── localhost:80  (your local Nginx)
```

---

## ⚙️ Setup Guide

### Step 1 — Install Ngrok

```bash
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc > /dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update && sudo apt install ngrok
```

---

### Step 2 — Authenticate

Create a free account at [ngrok.com](https://ngrok.com) and get your auth token:

```bash
ngrok config add-authtoken YOUR_AUTH_TOKEN
```

> ⚠️ Never commit your auth token. Add it to `.env` and keep it in `.gitignore`.

---

### Step 3 — Start HTTP Tunnel

```bash
ngrok http 80
```

Ngrok will display a public URL like `https://xxxx.ngrok-free.app` that forwards to your local port 80.

---

### Step 4 — Start SSH Tunnel

```bash
ngrok tcp 22
```

Connect remotely via:

```bash
ssh username@0.tcp.ngrok.io -p <assigned_port>
```

---

### Step 5 — Run in Background (tmux)

```bash
pkg install tmux   # or apt install tmux
tmux new -s ngrok
ngrok http 80
# Detach: CTRL+B then D
```

---

## 📁 Project Structure

```
ngrok-tunneling-setup/
├── configs/
│   └── ngrok.yml.sample
├── .gitignore
├── LICENSE
└── README.md
```

---

## ⚠️ Limitations (Free Tier)

- URL changes every time you restart Ngrok
- Limited connections per minute
- No custom domains on free tier

For a permanent URL, use **Cloudflare Tunnel** instead.

---

## 🐛 Troubleshooting

### ERR_NGROK_108 — Tunnel Session Limit
Only one tunnel is allowed on the free tier at a time. Stop any other running ngrok sessions.

### Connection Refused
Make sure your local server (Nginx, Apache, etc.) is running before starting the tunnel:
```bash
sudo systemctl status nginx
```

---

## 💡 Key Takeaways

- Ngrok is the fastest way to share a local server publicly for demos or testing
- It works behind CGNAT, firewalls, and NAT without any router configuration
- For production/permanent use, Cloudflare Tunnel is a more stable alternative

---

## 📄 License
MIT

---
*Built during homelab networking exploration — 2026*
