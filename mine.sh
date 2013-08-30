cpus=$(cat /proc/cpuinfo | grep ^processor | wc -l)

# restart cpuminer
cd cpuminer
screen -d -m ./minerd --threads $cpus --algo sse2_64 --url http://deepbit.net:8332/ --userpass YOUR_EMAIL:YOUR_PASSWORD
cd -
sudo bash devdriver_3.2_linux_64_260.19.26.run
sudo bash cudatoolkit_3.2.16_linux_64_fedora13.run

# install pyopencl
git clone http://git.tiker.net/trees/pyopencl.git
cd pyopencl
sudo easy_install Mako
git submodule init
git submodule update
python configure.py --cl-inc-dir=/usr/local/cuda/include --cl-lib-dir=/usr/local/cuda/lib64
vi siteconf.py # set CL_ENABLE_DEVICE_FISSION = False
sudo make install
cd -

# get poclbm and start for each device
git clone https://github.com/m0mchil/poclbm.git
cd poclbm/
screen -d -m python poclbm.py -o deepbit.net -p 8332 -u YOUR_EMAIL --pass=YOUR_PASSWORD -v -w 256 --device 0
screen -d -m python poclbm.py -o deepbit.net -p 8332 -u YOUR_EMAIL --pass=YOUR_PASSWORD -v -w 256 --device 1
