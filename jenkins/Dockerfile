FROM jenkins:1.642.1

USER root

# See: http://docs.docker.com/engine/installation/debian/#installation
# apt-cache showpkg docker-engine
# ...
# 1.8.2-0~jessie -
# ...
# Locate the same docker version as in the ubuntu host.
#
# How to install a specific version:
#   apt-get install docker-engine=1.10.2-0~jessie
#
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    bzip2 \
    sudo \
    docker-engine \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /opt && \
    wget http://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.3.9/apache-maven-3.3.9-bin.zip && \
    unzip apache-maven-3.3.9-bin.zip

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
