#!/bin/bash
TARGET=$(echo "$@" | sed 's/--target=//')
nmap -sV -Pn "$TARGET"
