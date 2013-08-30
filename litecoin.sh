sudo yum -y groupinstall "Development Tools"
sudo yum -y install git libcurl-devel python-devel screen rsync

git clone https://github.com/ArtForz/cpuminer.git
cd cpuminer
./autogen.sh
./configure
make -j
nohup ./minerd --algo scrypt -s 6 --threads 2 --url http://yourpool --userpass user:pass
