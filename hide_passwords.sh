#!/bin/bash
# Obfuscates all passwords in conf files



find . -name "*.conf" -type f | while read -r file; do
    echo "Processing: $file"
    sed -i 's/\(;acore;\)[^;]*\(;.*\)/\1PASS\2/g' "$file"
done
