#!/bin/sh

# Directory to monitor
watch_dir="/watchDir"

# Custom command to execute on change
custom_command="/scripts/onChange.sh"

echo "api $WEB_HOOK"
echo "start watcher..."
# Start inotifywait to monitor the directory
inotifywait -m -r -e modify,create,delete,move "$watch_dir" | while read -r directory event file
do
    # echo "Change detected in $directory: $file - $event"
    # Execute the custom command
    sh "$custom_command" $WEB_HOOK $event $directory $file
done




