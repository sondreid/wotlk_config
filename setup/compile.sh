# In build directory
cmake ../ -DCMAKE_INSTALL_PREFIX=$HOME/azerothcore_playerbots/azerothcore-wotlk/env/dist/ -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DWITH_WARNINGS=1 -DTOOLS_BUILD=db-only -DSCRIPTS=static -DMODULES=static;
make -j -8 && make install