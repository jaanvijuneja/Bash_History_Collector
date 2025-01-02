#!/bin/bash

# Define paths for the output and tracking files
output_dir="$HOME/terminal_history_logs"
output_file="$output_dir/terminal_history_$(date +%Y%m%d_%H%M%S).csv"
last_id_file="$output_dir/last_history_id.txt"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Get the username
username=$(whoami)

# Get the last processed ID (default to 0 if the file doesn't exist)
if [[ -f "$last_id_file" ]]; then
    last_id=$(cat "$last_id_file")
else
    last_id=0
fi

# Add header to the output file
echo "ID,Timestamp,Command,Username" > "$output_file"

# Process new history entries
history | awk -v user="$username" -v last_id="$last_id" -v date_format="%F %T" '
    BEGIN { processed = 0 }
    {
        if ($1 > last_id) {
            command = $0
            for (i=2; i<=NF; i++) {
                command = command " " $i
            }
            print $1 "," strftime(date_format) "," command "," user
            processed = $1  # Update last processed ID
        }
    }
    END { if (processed) print processed > "'"$last_id_file"'" }
' >> "$output_file"

# Inform the user
echo "New terminal history entries saved to $output_file"

