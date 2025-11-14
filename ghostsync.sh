#!/bin/bash
git add .
git commit -m "Auto-sync by Flatbush on $(date '+%Y-%m-%d %H:%M:%S')"
git pull --rebase
git push
