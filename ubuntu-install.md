# jenkins-dockerhost Setup on Ubuntu
This describes the prototype setup of jenkins-dockerhost on a virtual machine.

## TODO
- Before this setup can be used for applications that goes into production, secure the setup by providing an
 external key at installation time and and add a jenkins login.

## VirtualBox
- Install Ubuntu Server 14.04.2
- hostname jenkins-dockerhost
- 50 GB disk
- 8 GB ram
- User jenkins,Jenkins123
- Virtualbox network: NAT
- Configure port forward in VirtualBox
  - host 127.0.1.1:22 -> guest 10.0.2.15:22
  - host <hostip>:22 -> guest 10.0.2.15:22
  - host 127.0.1.1:9111 -> guest 10.0.2.15:9111
  - host <hostip>:9111 -> guest 10.0.2.15:9111
  - host <hostip>:9090 -> guest 10.0.2.15:9090
  - host <hostip>:1010x -> guest 10.0.2.15:1010x <-- One row for each service

```
$ sudo apt-get install -y openssh-server subversion
```
Login with putty: jenkins-dockerhost, jenkins
```
$ sudo -i
\# echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
```
## Docker
```
$ sudo -i
# apt-get update
# wget -qO- https://get.docker.com/ | sh
$ newgrp docker
# usermod -aG docker jenkins

```
## HTTP proxy
```
$ vi /etc/default/docker
...
export http_proxy="http://bc.intern.folksam.se:8080"
```
## docker-compose
```
$ sudo -i
\# curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
\# chmod +x /usr/local/bin/docker-compose
```
## Git
```
$ vi ~/.gitconfig
[user]
        email = your.name@yourdomain.com
        name = Your Name
```
## Bootstrap jenkins-dockerhost
```
$ sudo mkdir /usr/local/jenkins-dockerhost
$ sudo chown -R jenkins:jenkins /usr/local/jenkins-dockerhost/
$ cd /usr/local/jenkins-dockerhost/
$ git clone https://github.com/dmarell/jenkins-dockerhost.git .
$ sudo cp jenkins-dockerhost.conf /etc/init
$ mkdir ~/.ssh
$ touch ~/.ssh/authorized_keys
$ cat jenkins-data/id_rsa-jenkins.pub >> ~/.ssh/authorized_keys
$ sudo service jenkins-dockerhost start
```
Verify the installation by opening http://jenkins-dockerhost:9090 in a browser.
