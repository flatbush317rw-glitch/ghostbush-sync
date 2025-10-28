#!/data/data/com.termux/files/usr/bin/bash

# Silence output
exec &>/dev/null

# Load latest mesh packet
mesh_packet=$(cat ~/.ghostbush/mesh/incoming.txt)

# Validate
if [[ -z "$mesh_packet" ]]; then
  echo "$(date): No mesh packet for uplink" >> ~/.ghostbush/audit.log
  exit 1
fi

# Encrypt payload (optional)
encrypted=$(echo "$mesh_packet" | openssl enc -aes-256-cbc -a -salt -pass pass:$GHOSTBUSH_KEY)

# Fire to tower uplink
curl -X POST -d "payload=$encrypted" https://tower.flatbush317rw.com/uplink &

# Log + vault
echo "$(date): Uplink fired: $mesh_packet" >> ~/.ghostbush/audit.log
echo "uplink:$(date):$mesh_packet" > ~/.ghostbush/vault/uplink-$(date +%s).txt

# Trigger sync
bash ~/.ghostbush/ghostbush-sync.sh &
