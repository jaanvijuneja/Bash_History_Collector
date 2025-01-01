#!/bin/bash

# Define the bashrc file path
bashrc_file="$HOME/.bashrc"

# Backup the existing .bashrc file
cp "$bashrc_file" "${bashrc_file}.backup_$(date +%Y%m%d_%H%M%S)"

# Check if HISTTIMEFORMAT is already set
if ! grep -q "HISTTIMEFORMAT" "$bashrc_file"; then
    echo "Adding HISTTIMEFORMAT to $bashrc_file"
    echo -e "\n# Enable timestamps in history" >> "$bashrc_file"
    echo "export HISTTIMEFORMAT='%F %T '" >> "$bashrc_file"
else
    echo "HISTTIMEFORMAT is already set in $bashrc_file"
fi

# Add history synchronization commands if not already present
if ! grep -q "PROMPT_COMMAND" "$bashrc_file"; then
    echo "Adding PROMPT_COMMAND to $bashrc_file"
    echo -e "\n# Sync history after each command" >> "$bashrc_file"
    echo "export PROMPT_COMMAND='history -a; history -c; history -r'" >> "$bashrc_file"
else
    echo "PROMPT_COMMAND is already set in $bashrc_file"
fi

# Reload the updated .bashrc file
echo "Reloading $bashrc_file"
source "$bashrc_file"

# Inform the user
echo "Timestamps enabled in Bash history. Changes applied and .bashrc reloaded."

