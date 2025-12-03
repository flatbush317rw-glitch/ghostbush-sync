# relay_server.py — GhostBush Sync Pulse Listener
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/sync-pulse', methods=['POST'])
def sync_pulse():
    data = request.get_json()
    device_id = data.get('device_id')
    token     = data.get('auth_token')
    pulse     = data.get('pulse')
    cadence   = data.get('cadence')

    if token != "ghostbush-override":
        return jsonify({"status": "unauthorized"}), 403

    print(f"[SYNC] Pulse received from {device_id} — cadence: {cadence}")
    return jsonify({"status": "ok", "echo": "override received"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=2222)
