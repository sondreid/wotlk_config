#!/bin/bash



find . -name "*.dist" -type f | while read -r file; do
    echo "Found: $file"
    read -p "Delete this file? (y/N): " response
    case "$response" in
        [yY]|[yY][eE][sS])
            if rm "$file"; then
                echo "✓ Deleted: $file"
            else
                echo "✗ Failed to delete: $file"
            fi
            ;;
        *)
            echo "→ Skipped: $file"
            ;;
    esac
    echo "---"
done

echo "Done processing .dist files."
