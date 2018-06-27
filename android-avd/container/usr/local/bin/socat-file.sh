#!/bin/bash

# This script detects the external IP address of this container and opens access to one of local ports.

IP=$(ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | sed 's|/[0-9]*||')
sudo socat file:$1 tcp-listen:$2,bind=$IP
