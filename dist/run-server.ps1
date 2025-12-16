# run-server.ps1
# Starts the backend and opens the dashboard in the default browser.

$exe = Join-Path (Get-Location) "barbershop.exe"
if (-not (Test-Path $exe)) {
  Write-Host "ERROR: barbershop.exe not found in this folder." -ForegroundColor Red
  exit 1
}

Start-Process -FilePath $exe -WorkingDirectory (Get-Location)
Start-Sleep -Seconds 2
Start-Process "http://127.0.0.1:8080"
