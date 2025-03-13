# Pomodoro Timer for Sway

A simple Pomodoro timer script for Sway window manager with toggle functionality. This script helps you implement the Pomodoro Technique for time management:

- Work for 25 minutes (configurable)
- Take a 5-minute break (configurable)
- Repeat

## Features

- Toggle functionality: run once to start, run again to stop
- Status checking: check the current status of your Pomodoro timer
- Desktop notifications for:
  - Work period start
  - Work period end / break start
  - Break end
- Configurable work and break durations
- Minimal dependencies

## Requirements

- `notify-send` (for desktop notifications)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/sway-sh.git
   cd sway-sh/pomodoro-sh
   ```

2. Make the script executable:
   ```bash
   chmod +x pomodoro.sh
   ```

3. (Optional) Create a symbolic link to make it available system-wide:
   ```bash
   sudo ln -s "$(pwd)/pomodoro.sh" /usr/local/bin/pomodoro
   ```

## Usage

### Toggle Timer

Simply run the script to toggle the Pomodoro timer on or off:

```bash
./pomodoro.sh
```

Or if you created the symbolic link:

```bash
pomodoro
```

### Check Status

To check the current status of the Pomodoro timer:

```bash
./pomodoro.sh status
```

Or with the symbolic link:

```bash
pomodoro status
```

## Sway Configuration

Add keybindings to your Sway config file (`~/.config/sway/config`):

```
# Toggle Pomodoro timer
bindsym $mod+p exec /path/to/pomodoro.sh

# Check Pomodoro status
bindsym $mod+Shift+p exec /path/to/pomodoro.sh status
```

## Customization

You can modify the work and break durations by editing the following variables at the top of the script:

```bash
WORK_MINUTES=25  # Default is 25 minutes
BREAK_MINUTES=5  # Default is 5 minutes
```

## License

This project is licensed under the MIT License - see the LICENSE file for details. 