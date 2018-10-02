FROM jenkins/jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dhudson.model.DirectoryBrowserSupport.CSP=''"
ENV JENKINS_SLAVE_AGENT_PORT 8081
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
COPY configure-markup-formatter.groovy /usr/share/jenkins/ref/init.groovy.d/configure-markup-formatter.groovy
COPY addNodeToJenkins.groovy /usr/share/jenkins/ref/init.groovy.d/addNodeToJenkins.groovy
COPY jobs/ /jobs/
COPY run.sh /run.sh
COPY plugins.txt /usr/share/jenkins/ref/

USER root
RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt && \
apt-get -y update && \
apt-get -y install sudo && \
sudo usermod -aG staff jenkins && \
echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENTRYPOINT ["bash","-x","/run.sh"]