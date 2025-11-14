#!/bin/bash
PAYLOAD=$(echo "$@" | sed 's/--payload=//')
ssh user@192.168.1.1 "python3 /tmp/$PAYLOAD"
