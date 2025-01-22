#!/bin/bash
BACKUP_DIR="/home/$USER/db_backup"
GDRIVE_FOLDER_ID="1Q3O_kHhY_0SwBtOPxUFkV1I2ou0eYhEL"
DATE=$(date +"%Y%m%d_%H%M%S")


TEST_MODE="false"

DB_PASS="$2"
DB_USER="$1"


if [ $TEST_MODE = true ]; then
    echo "Test data" >> "$BACKUP_DIR/test_auth_$DATE.sql"
    echo "Test data" >> "$BACKUP_DIR/test_characters_$DATE.sql"
    echo "Creating test files with date: $DATE"


else

    echo "making backups"
    mysqldump -u "$DB_USER" -p"$DB_PASS" acore_auth > $BACKUP_DIR/acore_auth_$DATE.sql
    mysqldump -u "$DB_USER" -p"$DB_PASS" acore_characters > $BACKUP_DIR/acore_characters_$DATE.sql

    #mysqldump -u "$DB_USER" -p"$DB_PASS" acore_world > $BACKUP_DIR/acore_world_$DATE.sql



fi





# Upload to Google Drive
for file in "$BACKUP_DIR"/*_"$DATE".sql; do
    if [ -f "$file" ]; then
        gdrive files upload --parent "$GDRIVE_FOLDER_ID" "$file"
        
        if [ $? -eq 0 ]; then
            echo "Successfully uploaded $file to Google Drive" >> "$BACKUP_DIR/backup.log"
        else
            echo "Failed to upload $file to Google Drive" >> "$BACKUP_DIR/backup.log"
        fi
    fi
done

touch "$BACKUP_DIR/backup.log" 2>/dev/null
echo "Backup completed on $(date)" >> "$BACKUP_DIR/backup.log"

# Delete older files 
find "$BACKUP_DIR" -name "*.sql" -mtime +14 -delete