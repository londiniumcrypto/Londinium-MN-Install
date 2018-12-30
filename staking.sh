#/bin/bash

cd ~
  
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get install -y nano htop git
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libevent-dev
sudo apt-get install -y libminiupnpc-dev
sudo apt-get install -y autoconf
sudo apt-get install -y automake unzip
sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install libzmq3-dev

cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo free
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
cd

wget https://github.com/londiniumcrypto/Londinium/releases/download/2.0.0/londinium-2.0.0-x86_64-linux-gnu.tar.gz
tar -xzf londinium-2.0.0-x86_64-linux-gnu.tar.gz
rm -rf londinium-2.0.0-x86_64-linux-gnu.tar.gz

sudo apt-get install -y ufw
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging on
echo "y" | sudo ufw enable
sudo ufw status
sudo ufw allow 9555/tcp
  
cd
mkdir -p .londinium
echo "staking=1" >> londinium.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> londinium.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> londinium.conf
echo "rpcallowip=127.0.0.1" >> londinium.conf
echo "listen=1" >> londinium.conf
echo "server=1" >> londinium.conf
echo "daemon=1" >> londinium.conf
echo "logtimestamps=1" >> londinium.conf
echo "maxconnections=256" >> londinium.conf
echo "addnode=104.238.187.178" >> londinium.conf
echo "addnode=45.76.131.22" >> londinium.conf
echo "addnode=68.183.219.218" >> londinium.conf
echo "addnode=68.183.219.25" >> londinium.conf
echo "port=9555" >> londinium.conf
mv londinium.conf .londinium

  
cd
./londiniumd -daemon
sleep 30
./londinium-cli getinfo
sleep 5
./londinium-cli getnewaddress
echo "Use the address above to send your LON coins to this server"
