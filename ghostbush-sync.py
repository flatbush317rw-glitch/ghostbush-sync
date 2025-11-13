import subprocess
from datetime import datetime
import os

def sync():
    os.chdir(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

    subprocess.run(["git", "add", "."])
    subprocess.run(["git", "commit", "-m", f"GhostBush sync at {datetime.now()}"])
    subprocess.run(["git", "push", "origin", "main"])

log_path = os.path.join(os.path.dirname(__file__), "..", "logs", "status.log")
log_path = os.path.abspath(log_path)
with open(log_path, "a") as log:
    log.write(f"[{datetime.now()}] GhostBush sync pushed by Flatbush\n")

if __name__ == "__main__":
    sync()