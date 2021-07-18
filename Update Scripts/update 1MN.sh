#/bin/bash

cd ~
cd /root/nestegg/./nestegg
./nestegg-cli stop
rm -rf nesteggd nestegg-cli nestegg-tx
wget https://github.com/SirElven8/NestEGG/releases/1.5.0.0/nestegglin1.5.0.0.tar.gz
tar -xzf nestegglin1.5.0.0.tar.gz
rm -rf nestegglin1.5.0.0.tar.gz
./nesteggd -daemon -resync
sleep 30
./nestegg-cli getinfo
