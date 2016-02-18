#!/bin/sh
cp -r /data-init/.m2 /data-init/.ssh $JENKINS_HOME/
chmod -R go-rwx $JENKINS_HOME/.ssh
echo "alias ll=\"ls -l\"" > $JENKINS_HOME/.bashrc
