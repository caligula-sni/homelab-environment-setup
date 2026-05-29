#!/data/data/com.termux/files/usr/bin/bash

COMMAND="$1"

# Block dangerous commands
if [[ "$COMMAND" == *"rm -rf"* ]]; then
    echo "[BLOCKED] Dangerous command detected"
    exit 1
fi

if [[ "$COMMAND" == *"/sdcard"* ]]; then
    echo "[WARNING] Accessing shared storage"
fi

# Execute command
eval "$COMMAND"
