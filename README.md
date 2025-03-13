# Sway-sh

A collection of useful scripts for the Sway window manager.

## Available Scripts

- **Pomodoro Timer**: A simple Pomodoro timer with toggle functionality
- **Translator**: (If available) A script for quick text translation
- **Mathpix OCR**: (If available) A script for OCR using Mathpix
- **Readwise**: (If available) A script for saving URLs to Readwise

## Installation

1. Clone this repository to `$HOME/code/sway-sh`:
   ```bash
   mkdir -p $HOME/code
   git clone https://github.com/yourusername/sway-sh.git $HOME/code/sway-sh
   cd $HOME/code/sway-sh
   ```

2. Run the initialization script to create a soft link to the Sway configuration file:
   ```bash
   ./init.sh
   ```
   This will:
   - Create a soft link to `sway_sh_config` in your `~/.config/sway/config.d/` directory
   - Make all script files executable

3. Restart Sway or reload your configuration:
   ```bash
   swaymsg reload
   ```

## Default Keybindings

The following keybindings are configured by default:

- **Pomodoro Timer**:
  - `$mod+p`: Toggle Pomodoro timer on/off
  - `$mod+Shift+p`: Check Pomodoro timer status

- **Translator** (if available):
  - `$mod+Shift+t`: Translate selected text

- **Screenshot and OCR**:
  - `Print`: Take a screenshot with slurp and open in swappy
  - `Print+Alt`: Capture screenshot and perform OCR with Mathpix

- **Readwise** (if available):
  - `$mod+Shift+r`: Save URL from clipboard to Readwise

- **AI**:
  - `Scroll_Lock`: Open Grok AI in LibreWolf browser

You can customize these keybindings by editing the `sway_sh_config` file.

## Important Note

The Sway configuration file (`sway_sh_config`) assumes that the scripts are located in `$HOME/code/sway-sh`. If you clone the repository to a different location, you'll need to update the `SCRIPT_DIR` variable in the `sway_sh_config` file.

## Customization

To customize the scripts or keybindings:

1. Edit the respective script files or the `sway_sh_config` file
2. If you modified the keybindings, reload your Sway configuration with `swaymsg reload`

## License

This project is licensed under the MIT License - see the LICENSE file for details. 