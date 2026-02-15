@echo off
echo ========================================
echo    QUICK PUBLIC SERVER
echo ========================================
echo.
echo Making your server PUBLIC in 30 seconds...
echo.

REM Install ngrok if not installed
where ngrok >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing ngrok...
    call npm install -g ngrok
)

echo Starting server...
start /min cmd /c "npm run dev"
timeout /t 5 /nobreak >nul

echo Creating public URL...
start cmd /k "ngrok http 5000"

echo.
echo ========================================
echo    YOUR SERVER IS NOW PUBLIC!
echo ========================================
echo.
echo Look at the ngrok window for your URL
echo Example: https://abc123.ngrok-free.app
echo.
echo Test it: https://your-url.ngrok-free.app/api/health
echo.
echo This URL works EVERYWHERE! 🌍
echo.
pause
