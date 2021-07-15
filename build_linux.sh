#!/bin/bash
echo -e "\033[0;32mHow many CPU cores do you want to be used in compiling process? (Default is 1. Press enter for default.)\033[0m"
read -e CPU_CORES
if [ -z "$CPU_CORES" ]
then
	CPU_CORES=1
fi

# Upgrade the system and install required dependencies
	sudo apt update
	sudo apt install git zip unzip build-essential libtool bsdmainutils autotools-dev autoconf pkg-config automake python3 libqt5svg5-dev -y

# Clone EGG code from EGG official Github repository
	git clone https://github.com/SirElven8/NestEGG

# Entering EGG directory
	cd EGG

# Compile dependencies
	cd depends
	chmod +x config.sub
	chmod +x config.guess
	make -j$(echo $CPU_CORES) HOST=x86_64-pc-linux-gnu 
	cd ..

# Compile EGG
	chmod +x share/genbuild.sh
	chmod +x autogen.sh
	./autogen.sh
	./configure --enable-glibc-back-compat --prefix=$(pwd)/depends/x86_64-pc-linux-gnu LDFLAGS="-static-libstdc++" --enable-cxx --enable-static --disable-shared --disable-debug --disable-tests --disable-bench --with-pic CPPFLAGS="-fPIC -O3 --param ggc-min-expand=1 --param ggc-min-heapsize=32768" CXXFLAGS="-fPIC -O3 --param ggc-min-expand=1 --param ggc-min-heapsize=32768"
	make -j$(echo $CPU_CORES) HOST=x86_64-pc-linux-gnu
	cd ..

# Create zip file of binaries
	cp EGG/src/nesteggd EGG/src/nestegg-cli EGG/src/nestegg-tx EGG/src/qt/nestegg-qt .
	zip EGG-Linux.zip nesteggd nestegg-cli nestegg-tx nestegg-qt
	rm -f nesteggd nestegg-cli nestegg-tx nestegg-qt
