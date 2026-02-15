@echo off
echo ========================================
echo   FIX THAZEMA CONNECTION
echo ========================================
echo.
echo This will:
echo 1. Start your server
echo 2. Create a PUBLIC URL with ngrok
echo 3. Show you the URL to update in your app
echo.
pause

echo.
echo Starting server...
start /min cmd /c "cd /d "%~dp0" && npm run dev"
timeout /t 5 /nobreak >nul

echo.
echo Creating PUBLIC URL with ngrok...
echo.
start cmd /k "ngrok http 5000"

echo.
echo ========================================
echo   IMPORTANT - COPY YOUR PUBLIC URL!
echo ========================================
echo.
echo Look at the ngrok window and find your URL:
echo Example: https://abc123-xyz.ngrok-free.app
echo.
echo COPY THAT URL!
echo.
echo Then:
echo 1. Update client/src/config/api.js
echo 2. Change PRODUCTION_URL to your ngrok URL
echo 3. Change USE_PRODUCTION to true
echo 4. Rebuild APK
echo.
echo OR use the automatic fix script:
echo UPDATE_SERVER_URL.bat
echo.
pause
