#!/data/data/com.termux/files/usr/bin/bash
cd ~/ai-agent
tmux new-session -d -s agent "python main.py"
