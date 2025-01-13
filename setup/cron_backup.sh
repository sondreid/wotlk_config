#!/bin/bash

# Set backup directory
BACKUP_DIR="/home/$USER/db_backup"

DATE=$(date +"%Y%m%d_%H%M%S")
DB_PASS="$2"
DB_USER="$1"


# Create backups with date stamp
mysqldump -u "$DB_USER" -p"$DB_PASS" acore_auth > $BACKUP_DIR/acore_auth_$DATE.sql
mysqldump -u "$DB_USER" -p"$DB_PASS" acore_characters > $BACKUP_DIR/acore_characters_$DATE.sql

#mysqldump -u "$DB_USER" -p"$DB_PASS" acore_world > $BACKUP_DIR/acore_world_$DATE.sql

# Remove backups older than 7 days (optional)
#find "$BACKUP_DIR" -name "*.sql" -mtime +7 -delete


# Append to log
echo "Backup completed on $(date)" >> "$BACKUP_DIR/backup.log"



# Upload to Google Drive
for file in "$BACKUP_DIR"/*_"$DATE".sql; do
    if [ -f "$file" ]; then
        gdrive files upload --parent "$GDRIVE_FOLDER_ID" "$file"
        
        # Check if upload was successful
        if [ $? -eq 0 ]; then
            echo "Successfully uploaded $file to Google Drive" >> "$BACKUP_DIR/backup.log"
        else
            echo "Failed to upload $file to Google Drive" >> "$BACKUP_DIR/backup.log"
        fi
    fi
done