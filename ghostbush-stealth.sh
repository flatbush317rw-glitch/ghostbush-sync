#!/data/data/com.termux/files/usr/bin/bash

# Silence all output
exec &>/dev/null

# Capsule registry
capsules=("alpha" "flood")

# Run capsules in background
for cap in "${capsules[@]}"; do
  if [ -f ~/.ghostbush/reels/$cap.sh ]; then
    bash ~/.ghostbush/reels/$cap.sh &
    echo "$(date): Reel $cap injected" >> ~/.ghostbush/audit.log
  elif [ -f ~/.ghostbush/disruptors/$cap.sh ]; then
    bash ~/.ghostbush/disruptors/$cap.sh &
    echo "$(date): Disruptor $cap deployed" >> ~/.ghostbush/audit.log
  fi
done

# Vault the activation
vault_file=~/.ghostbush/vault/stealth-$(date +%s).txt
echo "stealth:$(date)" > "$vault_file"

# Trigger GitHub sync
bash ~/.ghostbush/ghostbush-sync.sh &
