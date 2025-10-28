#!/data/data/com.termux/files/usr/bin/bash

cd ~/.ghostbush

# Initialize Git if not already
if [ ! -d ".git" ]; then
  git init
  git remote add origin https://github.com/flatbush317rw-glitch/ghostbush-sync.git
fi

# Stage and commit changes
git add .
git commit -m "Ghostbush sync: $(date)"

# Push to GitHub
git push origin master
