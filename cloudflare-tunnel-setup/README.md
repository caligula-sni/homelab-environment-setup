# ☁️ Cloudflare Tunnel Setup — Free Permanent HTTPS Tunnel

> Expose a locally hosted web server to the internet permanently and for free using Cloudflare Tunnel — no open ports, no public IP required.

![Cloudflare](https://img.shields.io/badge/Cloudflare-Tunnel-F38020?logo=cloudflare)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%20Server-E95420?logo=ubuntu)

---

## 📖 Overview

Cloudflare Tunnel (formerly Argo Tunnel) creates a secure outbound-only connection from your server to Cloudflare's network. Traffic reaches your server through Cloudflare — no open ports, no public IP, no router configuration needed. This is the permanent solution to CGNAT.

---

## 🏗️ Architecture

```
Internet User
└── https://yourdomain.com  (Cloudflare DNS)
    └── Cloudflare Network
        └── Encrypted Tunnel (outbound from your server)
            └── cloudflared agent
                └── localhost:80  (your local Nginx)
```

---

## 📋 Prerequisites

- A domain name (free: eu.org, freenom — or paid)
- A Cloudflare account with your domain added
- Ubuntu server (or Termux/Android)

---

## ⚙️ Setup Guide

### Step 1 — Install cloudflared

```bash
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -o cloudflared.deb
sudo dpkg -i cloudflared.deb
```

For ARM (Termux/Android):
```bash
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 -o cloudflared
chmod +x cloudflared
```

---

### Step 2 — Authenticate

```bash
cloudflared tunnel login
```

This opens a browser window. Select your domain to authorize.

---

### Step 3 — Create a Tunnel

```bash
cloudflared tunnel create my-tunnel
```

Note the tunnel UUID from the output.

---

### Step 4 — Configure the Tunnel

Create `~/.cloudflared/config.yml`:

```yaml
tunnel: YOUR_TUNNEL_UUID
credentials-file: /root/.cloudflared/YOUR_TUNNEL_UUID.json

ingress:
  - hostname: yourdomain.com
    service: http://localhost:80
  - service: http_status:404
```

> ⚠️ Never commit your credentials JSON file. It is already in `.gitignore`.

---

### Step 5 — Route DNS

```bash
cloudflared tunnel route dns my-tunnel yourdomain.com
```

---

### Step 6 — Run the Tunnel

**Quick test:**
```bash
bash configs/cloudflare_web_tunnel.sh
```

**Or as a system service:**
```bash
sudo cloudflared service install
sudo systemctl enable cloudflared
sudo systemctl start cloudflared
```

---

## 📁 Project Structure

```
cloudflare-tunnel-setup/
├── configs/
│   └── cloudflare_web_tunnel.sh
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🐛 Troubleshooting

### ERR_TOO_MANY_REDIRECTS
Cloudflare SSL mode is set to Flexible but your server also redirects to HTTPS. Set Cloudflare SSL mode to **Full** in the dashboard.

### Tunnel not connecting
Check that cloudflared is running:
```bash
sudo systemctl status cloudflared
```

---

## 💡 Key Takeaways

- Cloudflare Tunnel is the best free solution for self-hosting behind CGNAT
- Zero open ports means a significantly reduced attack surface
- Cloudflare also provides free DDoS protection and CDN automatically

---

## 📄 License
MIT

---
*Built during homelab networking setup — 2026*
