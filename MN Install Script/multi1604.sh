#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

#Checking OS
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${NC}
  exit 1
fi


echo -e ${YELLOW}"Welcome to the NestEgg Automated Install, During this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See a lot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install a NestEgg Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE

if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for the first node:"${NC}
read privkey
echo "Creating 1 NestEgg system users with no-login access:"
sudo adduser --system --root /root/nestegg nestegg
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install software-properties-common
sudo apt-get -y install build-essential
sudo apt-get -y install libtool autotools-dev autoconf automake
sudo apt-get -y install libssl-dev
sudo apt-get -y install libevent-dev
sudo apt-get -y install libboost-all-dev
sudo apt-get -y install pkg-config
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get -y install libdb4.8-dev
sudo apt-get -y install libdb4.8++-dev
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
#sudo apt install git
cd ~
cd /usr/local/bin/
wget https://github.com/SirElven8/NestEGG/releases/1.5.0.0/nestegglin1.5.0.0.tar.gz
tar -xzf nestegglin1.5.0.0.tar.gz
rm -rf nestegglin1.5.0.0.tar.gz
cd ~
sudo mkdir /root/nestegg
cd /root/nestegg
wget https://github.com/SirElven8/NestEGG/releases/1.5.0.0/nestegglin1.5.0.0.tar.gz
tar -xzvf nestegglin1.5.0.0.tar.gz
sudo mv /root/nestegg/nesteggd /root/nestegg/nestegg-cli /root/nestegg/nestegg-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/nestegg*
sudo mkdir /root/nestegg/.nestegg
sudo touch /root/nestegg/.nestegg/nestegg.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /root/nestegg/.nestegg/nestegg.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /root/nestegg/.nestegg/nestegg.conf
echo "rpcallowip=127.0.0.1" >> /root/nestegg/.nestegg/nestegg.conf
echo "server=1" >> /root/nestegg/.nestegg/nestegg.conf
echo "daemon=1" >> /root/nestegg/.nestegg/nestegg.conf
echo "staking=1" >> /root/nestegg/.nestegg/nestegg.conf
echo "maxconnections=250" >> /root/nestegg/.nestegg/nestegg.conf
echo "masternode=1" >> /root/nestegg/.nestegg/nestegg.conf
echo "listen=0" >> /root/nestegg/.nestegg/nestegg.conf
echo "masternodeprivkey=$privkey" >> /root/nestegg/.nestegg/nestegg.conf

fi
echo "Syncing first node, please wait...";
nesteggd -datadir=/root/nestegg/.nestegg -daemon
sleep 10
until nestegg-cli -datadir=/root/nestegg/.nestegg mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. You 1st masternode is running!"${NC}
echo ""
echo -e ${GREEN}"Congrats! Your NestEGG Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "The END. You can close now the SSH terminal session";
