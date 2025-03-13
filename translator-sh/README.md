# Chinese-English Translator

A simple command-line tool that automatically detects and translates between Chinese and English. It uses `translate-shell` and `wl-clipboard` tools, automatically replacing selected text with its translation.

## Prerequisites

You need to install the following tools:

1. `translate-shell` - Provides translation functionality
2. `wl-clipboard` - Provides clipboard access (for Wayland)
3. `libnotify-bin` - Provides desktop notifications
4. `xdotool` - Simulates keyboard input

### Installing Dependencies

For Debian/Ubuntu-based systems:
```bash
sudo apt install translate-shell wl-clipboard libnotify-bin xdotool
```

For Arch-based systems:
```bash
sudo pacman -S translate-shell wl-clipboard libnotify xdotool
```

For Fedora-based systems:
```bash
sudo dnf install translate-shell wl-clipboard libnotify xdotool
```

## Usage

### Translating Selected Text

1. Select the text you want to translate
2. Run the script:

   ```bash
   ./translate.sh
   ```

3. The selected text will be automatically replaced with its translation

### Translating Clipboard Content

If no text is selected, the script will automatically use the latest content in your clipboard:

1. Copy the text you want to translate (Ctrl+C)
2. Run the script:

   ```bash
   ./translate.sh
   ```

3. The translation will be copied to your clipboard and can be pasted with Ctrl+V

## How It Works

1. The script captures the selected text (or uses clipboard content if nothing is selected)
2. Detects the language and translates it
3. Copies the translation to the clipboard
4. Simulates Ctrl+V to paste the translation at the cursor position
5. Shows a desktop notification with the translation result

## Features

- Automatically detects input language
- Translates Chinese to English
- Translates English to Chinese
- Automatically replaces selected text with its translation
- Falls back to clipboard content if no text is selected
- Shows desktop notification with the translation

## Tips

If you use this tool frequently, consider binding it to a keyboard shortcut:

1. Copy the script to a system path:
   ```bash
   sudo cp translate.sh /usr/local/bin/translate
   sudo chmod +x /usr/local/bin/translate
   ```

2. Set up a keyboard shortcut in your desktop environment settings to run the `translate` command

Alternatively, create an alias:
```bash
echo 'alias translate="~/path/to/translator-sh/translate.sh"' >> ~/.bashrc
source ~/.bashrc
```
