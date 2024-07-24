#!/bin/bash

# Get current date in YYYYMMDD format
current_date=$(date +%Y%m%d)

# Define the new folder name
new_folder="/Users/$USER/Desktop/archive_$current_date"

# Create the new folder
mkdir "$new_folder"

# Move all files (not folders) from Desktop to the new folder
find /Users/$USER/Desktop -maxdepth 1 -type f -exec mv {} "$new_folder" \;

echo "Files have been moved to $new_folder"
