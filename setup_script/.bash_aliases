alias acoreupdate='
screen -S world -p 0 -X stuff saveall^m;
screen -X -S world quit;
git -C ~/azerothcore/modules/mod-anticheat pull;
git -C ~/azerothcore pull;
cd ~/azerothcore/build;
cmake ../ -DCMAKE_INSTALL_PREFIX=/home/sondre/server/ -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DWITH_WARNINGS=1 -DTOOLS_BUILD=db-only -DSCRIPTS=static -DMODULES=static;
make -j 8 install;
screen -AmdS world ~/server/bin/worldserver;
screen -r world;'



alias acorestart='
screen -AmdS auth ~/server/bin/authserver
screen -AmdS world ~/server/bin/worldserver;
screen -r world;'
