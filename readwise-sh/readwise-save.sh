#!/bin/bash

# Check if wl-clipboard is installed
if ! command -v wl-paste &> /dev/null; then
    notify-send "Error ❌" "wl-clipboard is not installed. Please install it with 'sudo apt install wl-clipboard' or equivalent for your distribution."
    exit 1
fi

# Get URL from clipboard
URL=$(wl-paste)

# Check if the clipboard content looks like a URL
if [[ ! $URL =~ ^https?:// ]]; then
    notify-send "Error ❌" "Clipboard does not contain a valid URL. URLs should start with http:// or https://"
    exit 1
fi

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Change to the project directory
cd "$SCRIPT_DIR"

# Execute the main.ts script with Bun, passing the URL as an argument
if bun run main.ts "$URL"; then
    notify-send "Readwise 📚" "URL saved successfully: $URL" --icon=document-save
else
    notify-send "Error ❌" "Failed to save URL to Readwise" --icon=dialog-error
fi 