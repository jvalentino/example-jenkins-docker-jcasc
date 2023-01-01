FROM jenkins/jenkins:lts

USER root
COPY plugins/plugins.txt /var/plugins/plugins.txt

COPY jcasc/jenkins.yaml /var/jcasc/jenkins.yaml

RUN jenkins-plugin-cli -f /var/plugins/plugins.txt


RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
COPY docker.service /lib/systemd/system/docker.service

RUN usermod -aG docker root


