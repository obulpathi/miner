.PHONY: mine install

mine:
	~/ptsminer/src/ptsminer -pooluser=PoGJ72YpWwsxti7KAef4EiSxSkUT3tLmTn -poolpassword=0 -poolip=pts.rpool.net -poolport=2336 -genproclimit=8 &

install:
	sudo apt-get update
	sudo apt-get install -y git make g++ build-essential libminiupnpc-dev screen
	sudo apt-get install -y libboost-all-dev libdb++-dev libgmp-dev libssl-dev dos2unix
	git clone https://github.com/thbaumbach/ptsminer ~/ptsminer
	cd ~/ptsminer/src
	git checkout 37896553d3ea5ab33023f06e0e097e46de11013e
	make -f makefile.unix
