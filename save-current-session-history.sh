#!/bin/bash

# Define the file to save the history
output_file="$HOME/terminal_history_$(date +%Y%m%d_%H%M%S).log"

# Save the history to the file
history > "$output_file"

echo "Terminal history saved to $output_file"
