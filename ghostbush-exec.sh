#!/data/data/com.termux/files/usr/bin/bash

cmd="$1"

case "$cmd" in
  vault)
    bash ~/.ghostbush/ghostbush-vault.sh
    ;;
  audit)
    bash ~/.ghostbush/ghostbush-audit.sh
    ;;
  sync)
    bash ~/.ghostbush/ghostbush-sync.sh
    ;;
  stealth)
    bash ~/.ghostbush/ghostbush-stealth.sh
    ;;
  inject:*)
    reel="${cmd#inject:}"
    bash ~/.ghostbush/reels/$reel.sh
    ;;
  disrupt:*)
    disruptor="${cmd#disrupt:}"
    bash ~/.ghostbush/disruptors/$disruptor.sh
    ;;
  *)
    echo "Unknown command: $cmd"
    ;;
esac
