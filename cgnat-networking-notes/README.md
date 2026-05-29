# 🌐 CGNAT Networking Notes — Understanding Carrier-Grade NAT

> A practical guide documenting the discovery of CGNAT on a home network, its implications for self-hosting and port forwarding, and the workarounds used to achieve public accessibility.

![Networking](https://img.shields.io/badge/Networking-CGNAT-blue)
![Homelab](https://img.shields.io/badge/Homelab-Self--Hosting-orange)

---

## 📖 Overview

This project documents the real-world experience of discovering that a home internet connection is behind CGNAT (Carrier-Grade NAT), why this breaks traditional port forwarding, and the alternative solutions explored to expose local services to the internet.

---

## 🧠 What is CGNAT?

CGNAT (Carrier-Grade NAT) is a technique used by ISPs to share a single public IP address among multiple customers. It adds an extra layer of NAT between your home router and the public internet.

```
Your Device
└── Home Router (Private IP: 192.168.x.x)
    └── ISP CGNAT (Shared Public IP: x.x.x.x)  ← You don't own this
        └── Internet
```

**The problem:** You cannot receive incoming connections from the internet because you don't have a dedicated public IP — port forwarding on your router has no effect.

---

## 🔍 How to Detect CGNAT

### Method 1 — Compare IPs

```bash
# Your router's WAN IP
ip route
# vs your actual public IP
curl ifconfig.me
```

If they are different, you are behind CGNAT.

### Method 2 — Check TTL

```bash
traceroute 8.8.8.8
```

If there are more than one hop before reaching the internet, CGNAT is likely present.

---

## ❌ What CGNAT Breaks

- Port forwarding (port 80, 443, 22 cannot be opened)
- Hosting a web server directly at home
- Running a game server
- Direct SSH access from the internet

---

## ✅ Workarounds Used

| Solution | How it Works | Cost |
|---|---|---|
| **Ngrok** | Tunnel via Ngrok's cloud servers | Free tier available |
| **Cloudflare Tunnel** | Tunnel via Cloudflare's network | Free |
| **VPS Reverse Proxy** | Rent a VPS with a public IP | Paid |
| **Ask ISP for Static IP** | ISP assigns dedicated IP | Usually paid |

---

## 📁 Project Structure

```
cgnat-networking-notes/
├── docs/
│   └── cgnat-explained.md
├── .gitignore
├── LICENSE
└── README.md
```

---

## 💡 Key Takeaways

- CGNAT is increasingly common as IPv4 addresses run out
- Port forwarding alone is not enough to self-host from a CGNAT connection
- Cloudflare Tunnel is the best free solution — no open ports needed
- IPv6 bypasses CGNAT entirely if your ISP supports it

---

## 📄 License
MIT

---
*Documented during homelab setup — 2026*
