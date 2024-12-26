sudo sed -i -E 's|^DataDir = .*|DataDir = "/home/'"$USERNAME"'/server/data"|' ~/server/etc/worldserver.conf
sudo sed -i -E 's|^LogsDir = .*|LogsDir = "/home/'"$USERNAME"'/server/logs"|' ~/server/etc/*.conf
sudo sed -i -E 's/= "127.0.0.1;3306;acore;[^;]*;/= "127.0.0.1;3306;acore;'"$PASSWORD"';/' ~/server/etc/*.conf