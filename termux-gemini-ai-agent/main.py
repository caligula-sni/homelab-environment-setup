import os
import json
import subprocess
from datetime import datetime

CONFIG_PATH = "config.json"
MEMORY_PATH = "memory.json"
LOG_PATH = "logs.txt"

def load_config():
    with open(CONFIG_PATH) as f:
        return json.load(f)

def log(action):
    with open(LOG_PATH, "a") as f:
        f.write(f"{datetime.now()} - {action}\n")

def run_command(cmd):
    config = load_config()

    if any(block in cmd for block in config["blocked_commands"]):
        return "[BLOCKED] Unsafe command"

    if config["require_confirmation"]:
        confirm = input(f"Run command? {cmd} (y/n): ")
        if confirm.lower() != "y":
            return "Cancelled"

    result = subprocess.getoutput(f"./executor.sh \"{cmd}\"")
    log(cmd)
    return result

def simple_planner(user_input):
    if "git" in user_input:
        return [
            "git status",
            "git add .",
            "git commit -m 'auto commit'",
            "git push"
        ]
    return [user_input]

def main():
    print("AI Agent Started")

    while True:
        user_input = input(">> ")

        if user_input == "exit":
            break

        plan = simple_planner(user_input)

        print("\nPlan:")
        for step in plan:
            print("-", step)

        for step in plan:
            output = run_command(step)
            print(output)

if __name__ == "__main__":
    main()
