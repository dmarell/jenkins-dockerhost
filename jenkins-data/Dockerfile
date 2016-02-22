FROM jenkins:1.642.1

USER root

ARG JENKINS_DOCKERHOST_IP=10.20.105.40

COPY data-init.sh /data-init/
RUN chmod a+rx /data-init/data-init.sh
COPY bowerrc /data-init/.bowerrc
COPY settings.xml /data-init/.m2/settings.xml
COPY id_rsa-jenkins /data-init/.ssh/id_rsa
COPY id_rsa-jenkins.pub /data-init/.ssh/id_rsa.pub
RUN ssh-keyscan $JENKINS_DOCKERHOST_IP >> /data-init/.ssh/known_hosts
RUN chown -R jenkins:jenkins /data-init

COPY plugins.txt /usr/share/jenkins/plugins.txt

USER jenkins

ENTRYPOINT ["/data-init/data-init.sh"]
