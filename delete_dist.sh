#!/bin/bash

echo "Deleting .dist files (excluding modules/ folder)..."
echo

# Find and delete all .dist files, excluding top-level modules/ folder
find . -name "*.dist" -type f ! -path "./modules/*" | while read -r file; do
    echo "Deleting: $file"
    if rm "$file"; then
        echo "✓ Deleted successfully"
    else
        echo "✗ Failed to delete"
    fi
    echo
done

echo "Finished processing .dist files."
