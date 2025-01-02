#!/bin/bash

# Define the input and output files
input_file="$HOME/.bash_history"
output_file="$HOME/parsed_terminal_history_$(date +%Y%m%d_%H%M%S).csv"

# Get the username
username=$(whoami)

# Add header to the output file
echo "ID,Timestamp,Command,Username" > "$output_file"

# Parse the history file and append username
awk -v user="$username" '
    /^#/ {  # Lines starting with "#" contain timestamps
        timestamp = strftime("%F %T", substr($0, 2))  # Extract and format timestamp
    }
    !/^#/ {  # Other lines are commands
        print NR "," timestamp "," $0 "," user  # NR gives the ID, timestamp from previous line
    }
' "$input_file" >> "$output_file"

# Inform the user
echo "Parsed history with username saved to $output_file"

