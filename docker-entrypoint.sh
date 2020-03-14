#!/bin/bash

_term() {
  echo "Caught SIGTERM signal!"
  # TODO: add a curl cmd to notify in SNS?
  mcrcon -H 127.0.0.1 -p 1PASSWD1 -w 1 "say Server is restarting now!" save-all stop
}

trap _term SIGTERM

# Print current directory
pwd

# Print environment variables
printenv

# Start OpenSSH server
service ssh restart

cd /root/FrogMCS_S4_1_15_2_Paper
java -Dpaper.playerconnection.keepalive=180 -jar -Xms4G -Xmx8G paper-122.jar &

# Wait forever
# You might want to rewrite the following command
tail -f /dev/null
