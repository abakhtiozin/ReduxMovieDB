#!/bin/sh

JENKINS_HOST="localhost";
JENKINS_PORT="8181";
JENKINS_API="http://$JENKINS_HOST:$JENKINS_PORT";

echo "Get JAR"
curl -O $JENKINS_API/jnlpJars/agent.jar
java -jar agent.jar -jnlpUrl $JENKINS_API/computer/nmacnode/slave-agent.jnlp -secret d19f4674dff48e72518b3a323154ab07ca0a3940f825f25cadfb4b8a91092e1b

wait $!