#!/bin/bash

# Print current directory
pwd

# Print environment variables
printenv

# Start OpenSSH server
service ssh restart

# Wait forever
# You might want to rewrite the following command
tail -f /dev/null
