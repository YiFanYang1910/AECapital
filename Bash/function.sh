#!/bin/bash

# Check if the configuration file exists
CONFIG_FILE="log_archive.conf"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file $CONFIG_FILE not found."
    exit 1
fi

# Load configuration from the file
source "$CONFIG_FILE"

# Check if required parameters are provided
if [ -z "$SOURCE_FOLDER" ] || [ -z "$ARCHIVE_FOLDER" ] || [ -z "$DAYS_THRESHOLD" ]; then
    echo "Required parameters not provided in the configuration file."
    exit 1
fi

# Create the archive folder if it doesn't exist
mkdir -p "$ARCHIVE_FOLDER"

# Find and process log files
find "$SOURCE_FOLDER" -type f -name "*.log" -mtime +"$DAYS_THRESHOLD" | while read -r log_file; do
    # Get the filename without path
    file_name=$(basename "$log_file")
    
    # Create a zip archive
    zip_name="$ARCHIVE_FOLDER/${file_name%.log}_$(date +"%Y%m%d").zip"
    zip -j "$zip_name" "$log_file"
    
    # Remove the original log file
    rm "$log_file"
    
    echo "Archived and removed: $log_file"
done

echo "Log archiving completed."
