#!/data/data/com.termux/files/usr/bin/bash

while true; do
  if [ -f ~/.ghostbush/incoming.txt ]; then
    cmd=$(cat ~/.ghostbush/incoming.txt)
    bash ~/.ghostbush/ghostbush-exec.sh "$cmd"
    rm ~/.ghostbush/incoming.txt
  fi
  sleep 2
done
