#!/data/data/com.termux/files/usr/bin/bash

# Silence output
exec &>/dev/null

# Watch target directory
watch_dir="$HOME/.ghostbush"
snapshot="$HOME/.ghostbush/.sentinel-snapshot.txt"
vault_dir="$HOME/.ghostbush/vault"
audit_log="$HOME/.ghostbush/audit.log"

# Ensure vault exists
mkdir -p "$vault_dir"

# Get current state
find "$watch_dir" -type f | sort > "$snapshot.new"

# Compare with previous snapshot
if [ -f "$snapshot" ]; then
  diff_output=$(diff "$snapshot" "$snapshot.new")
  if [ -n "$diff_output" ]; then
    # Vault the change
    vault_file="$vault_dir/sentinel-$(date +%s).txt"
    echo "Sentinel change detected: $(date)" > "$vault_file"
    echo "$diff_output" >> "$vault_file"

    # Log to audit
    echo "$(date): Sentinel detected change in .ghostbush" >> "$audit_log"

    # Trigger sync
    bash "$HOME/.ghostbush/ghostbush-sync.sh" &

    # Optional: auto-inject audit capsule
    bash "$HOME/.ghostbush/ghostbush-audit.sh" &
  fi
fi

# Update snapshot
mv "$snapshot.new" "$snapshot"
