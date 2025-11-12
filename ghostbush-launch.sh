#!/data/data/com.termux/files/usr/bin/bash
cd ~/Ghostbush/core
./ghostbush-sync.py
echo "[`date`] Ghostbush sync executed by Flatbush" >> ../logs/status.log
