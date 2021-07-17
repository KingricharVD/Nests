#/bin/bash

cd ~
cd /usr/local/bin
./hcc-cli stop
rm -rf hccd hcc-cli hcc-tx
wget https://github.com/Human-Charity-Coin/HCC-wallet/releases/download/v1.2.1/hcclin1.2.1.tar.gz
tar -xzf hcclin1.2.1.tar.gz
rm -rf hcclin1.2.1.tar.gz
./hccd -daemon -resync
sleep 30
./hcc-cli getinfo
