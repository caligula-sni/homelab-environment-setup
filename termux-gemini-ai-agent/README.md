# 🤖 Termux Gemini AI Agent — CLI Agentic AI on Android

> A CLI-based AI agent system powered by Gemini AI inside Termux. Executes terminal commands, manages Git workflows, and controls remote machines via SSH — all from an Android phone.

![Platform](https://img.shields.io/badge/Platform-Android%20Termux-brightgreen)
![AI](https://img.shields.io/badge/AI-Gemini-4285F4?logo=google)
![Python](https://img.shields.io/badge/Python-3-3776AB?logo=python)
![Level](https://img.shields.io/badge/Agent%20Level-Tool--Using-orange)

---

## 📖 Overview

Instead of a traditional chatbot, this project implements an **agentic AI system** — an AI that can reason, plan, and execute real terminal commands. It runs entirely within Termux on Android, with support for file system access, Git automation, and remote SSH control.

---

## 🏗️ Architecture

```
Termux (Android)
└── main.py  (Agent loop)
    ├── Gemini API  (reasoning engine)
    ├── executor.sh  (safe command runner)
    ├── agents/  (role definitions)
    │   ├── gitmaster.md
    │   └── sysmaster.md
    ├── config.json  (safety rules)
    ├── memory.json  (session memory)
    └── logs.txt  (action log)
```

---

## 🤖 Implemented Agents

### `gitmaster`
Handles all Git-related tasks.
- Check repo status
- Stage and commit changes
- Auto-generate commit messages
- Push to remote

### `sysmaster`
Handles system monitoring and management.
- Check disk/memory usage
- Monitor running processes
- Execute system commands safely

---

## ⚙️ Setup Guide

### Step 1 — Install Dependencies

```bash
pkg update
pkg install python git openssh
pip install google-generativeai
```

---

### Step 2 — Get Gemini API Key

1. Go to [aistudio.google.com](https://aistudio.google.com)
2. Create a free API key
3. Add to your environment:

```bash
echo 'export GEMINI_API_KEY="your_key_here"' >> ~/.bashrc
source ~/.bashrc
```

> ⚠️ Never commit your API key. It is in `.gitignore`.

---

### Step 3 — Clone and Setup

```bash
git clone https://github.com/yourusername/termux-gemini-ai-agent.git ~/ai-agent
cd ~/ai-agent
chmod +x scripts/executor.sh
```

---

### Step 4 — Run the Agent

```bash
python main.py
```

---

### Step 5 — Run in Background (tmux)

```bash
pkg install tmux
tmux new -s agent
python main.py
# Detach: CTRL+B then D
```

---

### Step 6 — Auto-start on Boot (Termux:Boot)

```bash
mkdir -p ~/.termux/boot
cp scripts/boot_start.sh ~/.termux/boot/start_agent.sh
chmod +x ~/.termux/boot/start_agent.sh
```

---

## 📁 Project Structure

```
termux-gemini-ai-agent/
├── main.py               ← Agent loop
├── config.json           ← Safety rules & allowed paths
├── memory.json           ← Session memory store
├── agents/
│   ├── gitmaster.md      ← Git agent role definition
│   └── sysmaster.md      ← System agent role definition
├── scripts/
│   ├── executor.sh       ← Safe command execution wrapper
│   └── boot_start.sh     ← Termux:Boot auto-start script
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🔐 Safety Features

- **Command blacklist** — blocks `rm -rf`, `chmod -R 777 /` and other destructive commands
- **Confirmation prompts** — requires `y/n` before executing any command
- **Allowed paths** — restricts file access to `~/ai-agent` and `~/projects`
- **Action logging** — all executed commands are written to `logs.txt`
- **SSH keys only** — no password-based SSH automation

---

## 🗺️ Roadmap

- [x] Command execution with safety filtering
- [x] Agent role system (gitmaster, sysmaster)
- [x] Multi-step planning before execution
- [x] SSH remote control support
- [x] tmux persistent sessions
- [x] Termux:Boot auto-start
- [ ] Long-term memory persistence
- [ ] Error recovery loop
- [ ] Multi-agent orchestration (devmaster, filemaster)
- [ ] Full Gemini API integration with tool-use

---

## 🧠 System Classification

This is a **Level 1 Tool-Using Agent**:
- Uses tools (shell, git, ssh)
- Plans before executing
- Responds to natural language prompts
- Not yet fully autonomous

---

## 🐛 Troubleshooting

### ModuleNotFoundError: google.generativeai
```bash
pip install google-generativeai
```

### Permission Denied on executor.sh
```bash
chmod +x scripts/executor.sh
```

### Agent stops when Termux closes
Use tmux or Termux:Boot as described in setup steps 5 and 6.

---

## 💡 Key Takeaways

- Agentic AI is fundamentally different from a chatbot — it acts, not just answers
- Running AI on Android via Termux is practical for lightweight automation
- Safety filtering and confirmation prompts are essential before any autonomous execution
- This is a strong foundation for DevOps automation and AI-assisted development

---

## 📄 License
MIT

---
*Built on Android Termux — April 2026*
