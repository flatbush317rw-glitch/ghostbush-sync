# Ghostbush Arsenal Full Sync Ritual

cargo clean
cargo build --release --verbose

$exe = Get-ChildItem .\target\release\ -Filter *.exe | Select-Object -First 1
if ($exe) {
    Write-Host "🚀 Running $($exe.Name)..."
    & $exe.FullName
} else {
    Write-Host "❌ No executable found in target\release"
    exit 1
}

if (Test-Path ops.log) {
    $stamp = Get-Date -Format "yyyyMMddHHmmss"
    $zipName = "ops-$stamp.zip"
    Compress-Archive ops.log $zipName -Force
    Remove-Item ops.log
    Write-Host "📦 Rotated ops.log into $zipName"
    git add $zipName
}

@"
* text eol=lf
"@ | Out-File -FilePath .gitattributes -Encoding ascii -Force
git add .gitattributes

git commit -m "Ghostbush Arsenal full sync + log rotation"
git push
