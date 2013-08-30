# set up path stuff
echo >> $HOME/.bash_profile
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/tools/lib' >> $HOME/.bash_profile
echo 'export PATH=$PATH:$HOME/tools/bin' >> $HOME/.bash_profile
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/tools/lib
export PATH=$PATH:$HOME/tools/bin
cpus=$(cat /proc/cpuinfo | grep ^processor | wc -l)

# initial package config
sudo yum -y groupinstall "Development Tools"
sudo yum -y install git libcurl-devel python-devel screen rsync

# install yasm
git clone git://github.com/yasm/yasm.git
cd yasm
./autogen.sh
./configure --prefix=$HOME/tools 
make -j $cpus
make install
cd -

# install and start cpuminer
git clone https://github.com/jgarzik/cpuminer.git
cd cpuminer
./autogen.sh
./configure
make -j $cpus
screen -d -m ./minerd --threads $cpus --algo sse2_64 --url http://deepbit.net:8332/ --userpass YOUR_EMAIL:YOUR_PASSWORD
cd -

# install numpy
git clone git://github.com/numpy/numpy.git numpy
cd numpy
git checkout remotes/origin/maintenance/1.6.x
sudo python setup.py install
cd -

# set up newer nvidia library
wget http://developer.download.nvidia.com/compute/cuda/3_2_prod/drivers/devdriver_3.2_linux_64_260.19.26.run
wget http://developer.download.nvidia.com/compute/cuda/3_2_prod/toolkit/cudatoolkit_3.2.16_linux_64_fedora13.run
sudo mv -v /lib/modules/$(uname -r)/kernel/drivers/video/nvidia.ko /root/
