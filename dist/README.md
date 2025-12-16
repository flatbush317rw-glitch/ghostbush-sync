# Barbershop App

## Quick start
1. Unzip `barbershop-app-package.zip`.
2. Edit `config.json` to set repo, branch, and options.
3. Run the backend:
   - Windows: double-click `barbershop.exe` or run `.\barbershop.exe` in PowerShell.
4. Open the dashboard:
   - If backend serves static files: open http://127.0.0.1:8080
   - If not, run a local static server from the `web` folder and open http://localhost:9000

## Contents
- `barbershop.exe` — backend server (release build)
- `config.json` — runtime configuration
- `web/` — frontend dashboard (Appointments, Services, Clients, Sync)
- `README.md` — this file

## Troubleshooting
- If the dashboard cannot reach the API, check `BASE_URL` in `web/app.js`.
- If CORS blocks requests, serve `web/` from the backend or run a local static server.
