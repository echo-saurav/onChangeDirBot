#!/bin/sh

# Directory to monitor
watch_dir="/watchDir"

# Custom command to execute on change
custom_command="/app/scripts/onChange.sh"
last_modified_file=""


echo "api $WEB_HOOK"
echo "start watcher..."
# Start inotifywait to monitor the directory
inotifywait -m -r -e modify,create,delete,move "$watch_dir" | while read -r directory event file
do
    # echo "Change detected in $directory: $file - $event"
    # Execute the custom command
    echo "event: $event , dir: $directory , file: $file"

    # if modify event is calling back to back two time it will not triggerd 
    # i need this because when some file is downloading it keep triggering the modify event
    if [ "$event" == "MODIFY" ] && [ "$last_modified_file" != "$directory/$file" ]; then
      sh "$custom_command" $WEB_HOOK $event $directory $file
      last_modified_file="$directory/$file"
    # reset last mod file if its not modify event
    elif [ "$event" != "MODIFY" ]; then
      sh "$custom_command" $WEB_HOOK $event $directory $file
      last_modified_file=""
    fi

done




