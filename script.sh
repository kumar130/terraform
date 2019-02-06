#!/bin/sh
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt install openjdk-8-jre -y
sudo apt-get install jenkins -y
sudo service jenkins restart
sudo apt-get update
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get install ansible -y
ansible --version

sudo apt-get update
sudo apt install maven -y
mvn -version

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo docker version
