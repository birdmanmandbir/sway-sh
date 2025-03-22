#!/bin/bash
# Dependencies: grim, slurp, bun, wl-clipboard
# Make sure bun and related dependencies are installed

# Set temporary file path
SCR="$HOME/screenshot-$(date +%s).png"

# Display notification
notify-send "Screenshot OCR 📸" "Please select an area to capture" -t 2000

# Use grim and slurp to capture screenshot
grim -g "$(slurp)" "$SCR"

# Check if screenshot was successful
if [ ! -f "$SCR" ]; then
    notify-send "Screenshot OCR ❌" "Screenshot failed" -u critical
    exit 1
fi

notify-send "Screenshot OCR 🔍" "Processing image..." -t 2000

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if dependencies are installed
if [ ! -d "$SCRIPT_DIR/node_modules" ]; then
    notify-send "Screenshot OCR 📦" "Installing dependencies..." -t 2000
    cd "$SCRIPT_DIR" && bun install
fi

# Use Bun to run TypeScript script
TEXT_RESULT=$(cd "$SCRIPT_DIR" && bun run mathpix_ocr.ts "$SCR" --text-only)

# Check if OCR was successful
if [ -z "$TEXT_RESULT" ]; then
    notify-send "Screenshot OCR ❌" "OCR failed or result is empty" -u critical
    rm "$SCR"
    exit 1
fi

# Copy result to clipboard
echo "$TEXT_RESULT" | wl-copy

# Display notification
notify-send "Screenshot OCR ✅" "Recognition complete, result copied to clipboard" -t 3000

# Clean up temporary files
rm "$SCR"

exit 0 