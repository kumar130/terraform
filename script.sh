#!/bin/sh
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt install openjdk-8-jre -y
sudo apt-get install jenkins -y
sudo service jenkins restart
#sudo cat /var/lib/jenkins/secrets/initialAdminPassword >> test.txt
