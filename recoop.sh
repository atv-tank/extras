#!/bin/bash

# Function to recursively copy files from source to destination
recursive_copy() {
    local source="$1"
    local destination="$2"

    # Find all files in the source directory and its subdirectories
    find "$source" -type f -print0 | while IFS= read -r -d '' file; do
        # Get relative path of file (removing source prefix)
        relative_path="${file#$source/}"

        # Destination file path
        dest_file="$destination/$relative_path"

        # Check if the file exists in the destination directory
        if [ -f "$dest_file" ]; then
            # Copy and overwrite the file
            cp -f "$file" "$dest_file"
            echo "Copied $file to $destination"
        else
            echo "File $relative_path does not exist in $destination - skipping"
        fi
    done
}

# Start recursive copy from ./out_sys/lib/ to ./vendor/amazon/tank/proprietary/lib/
recursive_copy "./out_sys/bin" "./vendor/amazon/tank/proprietary/bin/"
recursive_copy "./out_sys/etc" "./vendor/amazon/tank/proprietary/etc/"
recursive_copy "./out_sys/lib" "./vendor/amazon/tank/proprietary/lib/"
recursive_copy "./out_sys/priv-app" "./vendor/amazon/tank/proprietary/priv-app/"
recursive_copy "./out_sys/vendor" "./vendor/amazon/tank/proprietary/vendor/"
recursive_copy "./out_sys/xbin" "./vendor/amazon/tank/proprietary/xbin/"
