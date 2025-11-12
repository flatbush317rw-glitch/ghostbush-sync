#!/usr/bin/env python3
import os
import datetime

def sync():
    now = datetime.datetime.now()
    timestamp = now.strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] Ghostbush sync executed by Flatbush")

    # Log to status file
    with open("../logs/status.log", "a") as log:
        log.write(f"[{timestamp}] Ghostbush sync executed by Flatbush\n")

    # Auto-push to GitHub
    os.system("cd ~/Ghostbush && git add . && git commit -m 'Auto-sync by Flatbush on {}' && git push".format(timestamp))

if __name__ == "__main__":
    sync()
