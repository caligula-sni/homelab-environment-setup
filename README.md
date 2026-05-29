# Homelab Projects

A collection of infrastructure, networking, and systems projects built on a self-hosted homelab environment. All projects are hands-on and documented from real implementation experience.

---

## Environment

| Component | Details |
|---|---|
| Host Machine | Dell E6440, Windows 11 |
| Virtualization | VMware Workstation |
| Server OS | Ubuntu Server / Debian 13 |
| Mobile Rig | Android ARM64, Termux, proot Debian |
| Networking | Tailscale mesh VPN |

---

## Projects

### 01 — LEMP Stack on Ubuntu Server
Full LEMP stack (Linux, Nginx, MySQL, PHP 8.3-FPM) deployed on a bare Ubuntu Server to host a PHP web application with a relational MySQL database. Covers installation, Nginx configuration, PHP-FPM socket setup, database creation, permission management, and Git-based deployment.

---

### 02 — MySQL Database Deployment
Relational database schema design and deployment for a Farm Management System. Covers database creation, user management, privilege assignment, foreign key relationships, and schema import via script.

---

### 03 — Git Server Deployment
Git setup on a remote Ubuntu server for version-controlled web application deployment. Covers global identity configuration, SSH key generation, GitHub authentication, repository cloning into web root, and a Git pull based deployment workflow.

---

### 04 — VS Code Remote SSH Setup
Configuration of VS Code Remote SSH extension to connect a Windows machine to an Ubuntu server, enabling full remote development without FTP or file transfers. Covers SSH key generation on Windows, key copying to server, SSH hardening, and VS Code connection setup.

---

### 05 — SSHFS Linux Integration
Mounting a remote Ubuntu server directory as a local folder on a Linux machine using SSHFS. Covers installation, mount point creation, mounting and unmounting scripts, and optional persistent fstab configuration.

---

### 06 — CGNAT Networking Notes
Documentation of discovering and working around Carrier-Grade NAT on a home internet connection. Covers CGNAT detection methods, why it breaks port forwarding, and a comparison of workarounds including Ngrok, Cloudflare Tunnel, VPS reverse proxy, and ISP static IP.

---

### 07 — Ngrok Tunneling Setup
Using Ngrok to expose a locally hosted web server to the internet via a secure HTTP/HTTPS tunnel, bypassing CGNAT and firewall restrictions. Covers installation, authentication, HTTP and TCP tunneling, and background execution via tmux.

---

### 08 — Cloudflare Tunnel Setup
Permanent free HTTPS tunnel using Cloudflare Tunnel (cloudflared) to expose a local web server to the internet with zero open ports. Covers installation on both x86 and ARM, authentication, tunnel creation, DNS routing, config file setup, and running as a system service.

---

### 09 — Remote SSH via Cloudflare Tunnel
Extending Cloudflare Tunnel to support SSH access from anywhere without exposing port 22. Covers server-side tunnel configuration, client-side cloudflared installation, SSH config ProxyCommand setup, and key-based authentication hardening.

---

### 10 — MySQL Backup System
Automated daily MySQL database backups using mysqldump and cron. Covers backup script setup, credential security using .my.cnf, timestamped backups, cron scheduling, and restoration procedure.

---

### 11 — LEMP Stack on Android proot
Full LEMP stack (Nginx 1.26.3, PHP 8.4-FPM, MariaDB 11.8.6) running inside a proot Debian environment on Android ARM64 via Termux. No root access required. Covers proot setup, service configuration for port 8080, MariaDB initialization, application deployment, Acode editor integration via symlink, and service management scripts.

---

### 12 — Termux Gemini AI Agent
CLI-based agentic AI system powered by the Gemini API running inside Termux on Android. Implements agent roles (gitmaster, sysmaster) that plan and execute terminal commands, automate Git workflows, and control remote machines via SSH. Includes command safety filtering, session memory, tmux persistence, and Termux:Boot auto-start.

---

## Skills Demonstrated

- Linux server administration (Ubuntu Server, Debian)
- Web server configuration (Nginx, PHP-FPM)
- Database management (MySQL, MariaDB)
- Networking and tunneling (CGNAT, Cloudflare Tunnel, Ngrok, SSH)
- Remote development workflows (VS Code SSH, SSHFS, Tailscale)
- Automation and scripting (Bash, cron)
- Mobile Linux environments (Termux, proot, ARM64)
- Agentic AI systems (Gemini API, tool-using agents)

---

## Disclaimer

All projects were built and tested on personal hardware for learning purposes. No external or production systems were used.

---

*Built on a Dell E6440 homelab and Android ARM64 mobile rig — 2025-2026*
