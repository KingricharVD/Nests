#!/bin/bash
echo -e "\033[0;32mHow many CPU cores do you want to be used in compiling process? (Default is 1. Press enter for default.)\033[0m"
read -e CPU_CORES
if [ -z "$CPU_CORES" ]
then
	CPU_CORES=1
fi

# Clone EGG code from EGG official Github repository
	git clone https://github.com/SirElven8/NestEGG

# Entering EGG directory
	cd EGG

# Compile dependencies
	cd depends
	make -j$(echo $CPU_CORES) HOST=x86_64-apple-darwin17 
	cd ..

# Compile EGG
	./autogen.sh
	./configure --prefix=$(pwd)/depends/x86_64-apple-darwin17 --enable-cxx --enable-static --disable-shared --disable-debug --disable-tests --disable-bench
	make -j$(echo $CPU_CORES) HOST=x86_64-apple-darwin17
	make deploy
	cd ..

# Create zip file of binaries
	cp EGG/src/nesteggd EGG/src/nestegg-cli EGG/src/nestegg-tx EGG/src/qt/nestegg-qt EGG/EGG.dmg .
	zip EGG-MacOS.zip nesteggd nestegg-cli nestegg-tx nestegg-qt EGG.dmg
	rm -f nesteggd nestegg-cli nestegg-tx nestegg-qt EGG.dmg
