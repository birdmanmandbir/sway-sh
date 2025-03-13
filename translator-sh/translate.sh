#!/bin/bash

# Exit on error
set -e

# Set correct locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Check dependencies
command -v wl-paste >/dev/null 2>&1 || { echo "wl-paste required. Install with 'sudo apt install wl-clipboard'"; exit 1; }
command -v wl-copy >/dev/null 2>&1 || { echo "wl-copy required. Install with 'sudo apt install wl-clipboard'"; exit 1; }
command -v trans >/dev/null 2>&1 || { echo "translate-shell required. Install with 'sudo apt install translate-shell'"; exit 1; }
command -v notify-send >/dev/null 2>&1 || { echo "notify-send required. Install with 'sudo apt install libnotify-bin'"; exit 1; }
command -v xdotool >/dev/null 2>&1 || { echo "xdotool required. Install with 'sudo apt install xdotool'"; exit 1; }

# Save current clipboard content to restore later
ORIGINAL_CLIPBOARD=$(wl-paste 2>/dev/null || echo "")

# Get selected text (primary selection)
TEXT=$(wl-paste -p 2>/dev/null || echo "")

# If no text is selected, use the clipboard content
if [ -z "$TEXT" ]; then
  echo "No text selected, using clipboard content instead"
  TEXT=$ORIGINAL_CLIPBOARD
  
  # Check if clipboard is also empty
  if [ -z "$TEXT" ]; then
    echo "Clipboard is empty"
    notify-send "Translation" "No text selected and clipboard is empty"
    exit 1
  fi
fi

# Detect if text contains Chinese characters
if echo "$TEXT" | grep -q '[一-龥]'; then
  # If contains Chinese, translate to English
  TARGET="en"
else
  # Otherwise translate to Chinese
  TARGET="zh-CN"
fi

echo "Translating to: $TARGET"

# Perform translation
TRANSLATED=$(echo "$TEXT" | trans -b :"$TARGET" 2>/dev/null)

# Try alternative parameters if translation fails
if [ -z "$TRANSLATED" ]; then
  TRANSLATED=$(echo "$TEXT" | trans -no-auto -b :"$TARGET" 2>/dev/null)
fi

# Display original and translated text
echo -e "\nOriginal: $TEXT"
echo -e "\nTranslated: $TRANSLATED"

# Copy translation to clipboard
echo "$TRANSLATED" | wl-copy

# Show notification
notify-send "Translation Success" "$TRANSLATED"

# Simulate Ctrl+V to paste the translation
# First, we need to make sure we're in the right window
sleep 0.5
# Simulate keyboard shortcut to paste (Ctrl+V)
xdotool key ctrl+v

# Wait a moment before restoring the original clipboard
# sleep 0.5
#echo "$ORIGINAL_CLIPBOARD" | wl-copy

echo -e "\nTranslation pasted at cursor position" 