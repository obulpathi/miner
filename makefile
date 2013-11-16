.PHONY: mine install

mine:
	cd ~/ptsminer/src
	./ptsminer -pooluser=PeiwKjzDHu9He7Ei6wdqdna6m2j7p5Au1M -poolpassword=0 -poolip=pts.rpool.net -poolport=2336 -genproclimit=8

install:
	sudo apt-get update
	sudo apt-get install -y git make g++ build-essential libminiupnpc-dev screen
	sudo apt-get install -y libboost-all-dev libdb++-dev libgmp-dev libssl-dev dos2unix
	git clone https://github.com/thbaumbach/ptsminer
	cd ptsminer/src
	git checkout 37896553d3ea5ab33023f06e0e097e46de11013e
	make -f makefile.unix
