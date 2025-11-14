#!/bin/bash
PAYLOAD=$(echo "$@" | sed 's/--payload=//')
scp "$PAYLOAD" user@192.168.1.1:/tmp/
