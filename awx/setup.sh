#!/bin/bash

HOME="/home/vagrant"

echo "===== DEPENDENCIES ===== "
echo "===== Installing DOCKER"
sudo curl -fsSL https://get.docker.com |bash
sudo usermod -aG docker $USER
echo "===== Installing PACKAGES "
sudo apt-get install software-properties-common dpkg -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible git python-pip  -y
sudo pip install docker-compose==1.9.0 docker-py
#pip install boto3 &&\
#pip install botocore 

echo "===== Installing NODE"
sudo curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install npm --global


echo "===== Preparing AWX =="
cd $HOME && git clone -b 17.0.1 https://github.com/ansible/awx.git
cd awx/installer 
#mv inventory inventory.bkp 
#cat inventory.bkp |grep -v "^#" |grep -v "ˆ$" > inventory
openssl rand -hex 32 > awx_secret_key
#sed -i inventory "/s~/.awx/ /g/var/lib/awx/"

echo "Open FILE = inventory ~ to update admin_password and secret_key"