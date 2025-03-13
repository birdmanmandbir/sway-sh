#!/bin/bash

# Sway-sh initialization script
# This script creates a soft link to the Sway configuration file in the user's Sway config directory

# Exit on error
set -e

# Get the directory of this script (absolute path)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Define target directory for Sway configuration
SWAY_CONFIG_DIR="$HOME/.config/sway/config.d"

# Create Sway config directory if it doesn't exist
mkdir -p "$SWAY_CONFIG_DIR"

# Deploy Sway configuration
echo "Deploying Sway configuration..."
if [ -f "$SWAY_CONFIG_DIR/sway-sh.conf" ]; then
    echo "Removing existing configuration..."
    rm "$SWAY_CONFIG_DIR/sway-sh.conf"
fi

# Create soft link to the Sway configuration file
ln -s "$SCRIPT_DIR/sway_sh_config" "$SWAY_CONFIG_DIR/sway-sh.conf"
echo "Sway configuration deployed to $SWAY_CONFIG_DIR/sway-sh.conf"

# Make scripts executable
echo "Making scripts executable..."
if [ -f "$SCRIPT_DIR/pomodoro-sh/pomodoro.sh" ]; then
    chmod +x "$SCRIPT_DIR/pomodoro-sh/pomodoro.sh"
    echo "Made pomodoro.sh executable"
fi

if [ -f "$SCRIPT_DIR/translator-sh/translate.sh" ]; then
    chmod +x "$SCRIPT_DIR/translator-sh/translate.sh"
    echo "Made translate.sh executable"
fi

if [ -f "$SCRIPT_DIR/mathpix-sh/mathpix_screenshot_ocr.sh" ]; then
    chmod +x "$SCRIPT_DIR/mathpix-sh/mathpix_screenshot_ocr.sh"
    echo "Made mathpix_screenshot_ocr.sh executable"
fi

if [ -f "$SCRIPT_DIR/readwise-sh/readwise-save.sh" ]; then
    chmod +x "$SCRIPT_DIR/readwise-sh/readwise-save.sh"
    echo "Made readwise-save.sh executable"
fi

echo "Deployment complete!"
echo "Please restart Sway or reload your configuration with 'swaymsg reload' to apply changes." 