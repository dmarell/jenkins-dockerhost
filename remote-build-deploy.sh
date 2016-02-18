#!/bin/sh
set -e
PROJECT_VERSION=$1
TARGET_HOST=$2
REMOTE_USER=$3

# Create index.html with version information
INPUT_FILE=nginx/index.html
OUTPUT_FILE=nginx/html/index.html
mkdir -p nginx/html
sed s/\$PROJECT_VERSION/$PROJECT_VERSION/g $INPUT_FILE > $OUTPUT_FILE

tar --exclude-vcs -zcf /tmp/jenkins-dockerhost.tar.gz .
scp /tmp/jenkins-dockerhost.tar.gz $REMOTE_USER@${TARGET_HOST}:/usr/local/jenkins-dockerhost/
ssh -l $REMOTE_USER ${TARGET_HOST} "cd /usr/local/jenkins-dockerhost/; \
   sudo gzip -dc jenkins-dockerhost.tar.gz > jenkins-dockerhost.tar; \
   sudo tar xf jenkins-dockerhost.tar; \
   sudo rm jenkins-dockerhost.tar"
echo
echo
echo "Restarting the Jenkins server... this job will probably hang somewhere in the middle"
sleep 5
ssh -l $REMOTE_USER ${TARGET_HOST} "cd /usr/local/jenkins-dockerhost/; bash build-deploy.sh"
