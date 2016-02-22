# Jenkins setup

- See http://container-solutions.com/running-docker-in-jenkins-in-docker/
- Configure JDK: OpenJDK 1.8, JAVA_HOME: /usr/lib/jvm/java-8-openjdk-amd64/
- Add maven 3.3.9 auto
- JAVA_HOME: /usr/lib/jvm/java-8-openjdk-amd64
- MAVEN_HOME: /opt/apache-maven-3.3.9

## Jenkins Jobs

### service

Create a job for each service

- Description: Build webb app X and create docker image.
- Source Code Management/Subversion/Repository URL: https://github.com/dmarell/dockerized-gs-rest-service.git
- Pre Steps: Top Level Maven targets:
  - Maven version 3.3.9
  - Goals: -B versions:set -DnewVersion=$BUILD_NUMBER
- Build: Root POM: pom.xml, Goals and options: clean install -B
- Post Steps:
  - Execute Shell/Command:
    ```
    bash -ex deploy.sh
    ```

### jenkins-dockerhost

Rebuilds the jenkins-dockerhost itself.

- Source Code Management/Subversion/Repository URL: https://github.com/dmarell/jenkins-dockerhost.git
- Build:
  - Execute Shell/Command:
    ```
    #!/bin/sh
    sh remote-build-deploy.sh $BUILD_NUMBER jenkins-dockerhost jenkins
    ```
#### Setup ssh key
Enables ssh commands from jenkins jobs.

    Enable the selected ssh-user (jenkins) to write in the directory /usr/local/jenkins-dockerhost.

    ```
    #$ cp id_rsa-jenkins to /home/jenkins/.ssh/id_rsa
    #$ cp id_rsa-jenkins.pub to /home/jenkins/.ssh/id_rsa.pub
    $ cp id_rsa-jenkins.pub to /home/jenkins/.ssh/authorized_keys
    $ chmod 700 /home/jenkins/.ssh/
    $ chmod 500 /home/jenkins/.ssh/id_rsa
    ```
