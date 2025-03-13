#!/bin/bash

# Pomodoro Timer for Sway
# A simple Pomodoro timer with toggle functionality
# Work period: 25 minutes, Break period: 5 minutes

# Exit on error
set -e

# Configuration
WORK_MINUTES=25
BREAK_MINUTES=5
POMODORO_PID_FILE="/tmp/pomodoro_timer.pid"
POMODORO_STATE_FILE="/tmp/pomodoro_state"

# Check dependencies
command -v notify-send >/dev/null 2>&1 || { echo "notify-send required. Install with 'sudo apt install libnotify-bin'"; exit 1; }

# Function to display time in a more readable format
format_time() {
    local minutes=$1
    local seconds=$2
    printf "%02d:%02d" $minutes $seconds
}

# Function to display current status
show_status() {
    if [ -f "$POMODORO_STATE_FILE" ]; then
        state=$(cat "$POMODORO_STATE_FILE")
        
        if [[ $state == work:* ]]; then
            time=${state#work:}
            echo "Pomodoro: Working - $time remaining"
            notify-send "Pomodoro Status" "Working - $time remaining" --icon=time
        elif [[ $state == break:* ]]; then
            time=${state#break:}
            echo "Pomodoro: Break - $time remaining"
            notify-send "Pomodoro Status" "Break - $time remaining" --icon=time
        else
            echo "Pomodoro: Running"
            notify-send "Pomodoro Status" "Timer is running" --icon=time
        fi
    else
        echo "No active Pomodoro timer"
        notify-send "Pomodoro Status" "No active timer" --icon=dialog-information
    fi
}

# Function to start the Pomodoro timer
start_pomodoro() {
    # Create state file to indicate timer is running
    echo "running" > "$POMODORO_STATE_FILE"
    
    # Start the timer in the background
    (
        remaining_work_seconds=$((WORK_MINUTES * 60))
        remaining_break_seconds=$((BREAK_MINUTES * 60))
        
        # Notify user that Pomodoro has started
        notify-send "Pomodoro Timer" "Work period started (${WORK_MINUTES} minutes)" --icon=time
        
        # Work period
        while [ $remaining_work_seconds -gt 0 ]; do
            minutes=$((remaining_work_seconds / 60))
            seconds=$((remaining_work_seconds % 60))
            
            # Update state file with current status
            echo "work:$(format_time $minutes $seconds)" > "$POMODORO_STATE_FILE"
            
            sleep 1
            remaining_work_seconds=$((remaining_work_seconds - 1))
        done
        
        # Work period finished, notify user
        notify-send "Pomodoro Timer" "Work period finished! Take a break (${BREAK_MINUTES} minutes)" --icon=dialog-information
        
        # Break period
        while [ $remaining_break_seconds -gt 0 ]; do
            minutes=$((remaining_break_seconds / 60))
            seconds=$((remaining_break_seconds % 60))
            
            # Update state file with current status
            echo "break:$(format_time $minutes $seconds)" > "$POMODORO_STATE_FILE"
            
            sleep 1
            remaining_break_seconds=$((remaining_break_seconds - 1))
        done
        
        # Break period finished, notify user
        notify-send "Pomodoro Timer" "Break finished! Ready for next Pomodoro?" --icon=dialog-information
        
        # Clean up
        rm -f "$POMODORO_STATE_FILE"
        rm -f "$POMODORO_PID_FILE"
    ) &
    
    # Save the PID of the background process
    echo $! > "$POMODORO_PID_FILE"
    
    echo "Pomodoro timer started"
    notify-send "Pomodoro Timer" "Timer started" --icon=time
}

# Function to stop the Pomodoro timer
stop_pomodoro() {
    if [ -f "$POMODORO_PID_FILE" ]; then
        PID=$(cat "$POMODORO_PID_FILE")
        
        # Kill the timer process
        kill $PID 2>/dev/null || true
        
        # Clean up
        rm -f "$POMODORO_STATE_FILE"
        rm -f "$POMODORO_PID_FILE"
        
        echo "Pomodoro timer stopped"
        notify-send "Pomodoro Timer" "Timer stopped" --icon=process-stop
    else
        echo "No active Pomodoro timer found"
        notify-send "Pomodoro Timer" "No active timer found" --icon=dialog-information
    fi
}

# Toggle Pomodoro timer (main function)
toggle_pomodoro() {
    if [ -f "$POMODORO_PID_FILE" ]; then
        # Timer is running, stop it
        stop_pomodoro
    else
        # Timer is not running, start it
        start_pomodoro
    fi
}

# Check for command line arguments
if [ "$1" = "status" ]; then
    show_status
else
    # No arguments, toggle the timer
    toggle_pomodoro
fi

exit 0 