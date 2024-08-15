sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 55022
sudo ufw allow 3724
sudo ufw allow 8085
sudo ufw enable


sudo apt update && sudo apt full-upgrade -y
sudo apt install git cmake make gcc g++ clang libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server mariadb-client libmariadb-dev libmariadb-dev-compat build-essential p7zip-full screen fail2ban -y


sudo mysql_secure_installation

git -C ~/ clone https://github.com/azerothcore/azerothcore-wotlk.git --branch master --single-branch azerothcore

mkdir -p ~/server/data && cd ~/server/data
wget https://github.com/wowgaming/client-data/releases/download/v16/data.zip
7z x data.zip && rm data.zip


mkdir -p ~/azerothcore/build && cd ~/azerothcore/build
cmake ../ -DCMAKE_INSTALL_PREFIX=$HOME/server/ -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DWITH_WARNINGS=1 -DTOOLS_BUILD=db-only -DSCRIPTS=static -DMODULES=static
make -j $(nproc) install

cp -n ~/server/etc/authserver.conf.dist ~/server/etc/authserver.conf
cp -n ~/server/etc/worldserver.conf.dist ~/server/etc/worldserver.conf
sudo sed -i -E 's|^DataDir = .*|DataDir = "/home/USERNAME/server/data"|' ~/server/etc/worldserver.conf
sudo sed -i -E 's/= "127.0.0.1;3306;acore;acore;/= "127.0.0.1;3306;acore;SQLPASSWORD;/' ~/server/etc/*.conf

sudo mysql -u acore -p

UPDATE acore_auth.realmlist SET address = '0.0.0.0' WHERE id = 1;

screen -AmdS auth ~/server/bin/authserver
screen -AmdS world ~/server/bin/worldserver
screen -r world

account create USERNAME PASSWORD
account set gmlevel USERNAME 3 -1