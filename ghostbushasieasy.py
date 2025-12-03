import json, time, requests, os

with open("config.json", "r") as f:
    config = json.load(f)

device_id     = config["device_id"]
relayhost     = config["relayhost"]
relay_port    = config["relay_port"]
auth_token    = config["auth_token"]
sync_interval = config["sync_interval"]
log_path      = config["log_path"]

os.makedirs(os.path.dirname(log_path), exist_ok=True)

def log(message):
    timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
    with open(log_path, "a") as log_file:
        log_file.write(f"[{timestamp}] {message}\n")

def inject_override():
    try:
        payload = {
            "device_id": device_id,
            "auth_token": auth_token,
            "pulse": "override-sync",
            "cadence": "sovereign"
        }
        url = f"http://{relayhost}:{relay_port}/sync-pulse"
        response = requests.post(url, json=payload)
        log(f"Relay response: {response.status_code} — {response.text}")
    except Exception as e:
        log(f"Injection failed: {str(e)}")

log("GhostBush ASI Injector started — override-grade sync active")

while True:
    inject_override()
    time.sleep(sync_interval)
