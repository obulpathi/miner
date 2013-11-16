#!/bin/bash
sudo apt-get update
sudo apt-get install -y git make g++ build-essential libminiupnpc-dev screen
sudo apt-get install -y libboost-all-dev libdb++-dev libgmp-dev libssl-dev dos2unix
git clone https://github.com/thbaumbach/ptsminer
cd ~/ptsminer/src
make -f makefile.unix
./ptsminer PoGJ72YpWwsxti7KAef4EiSxSkUT3tLmTn 8
