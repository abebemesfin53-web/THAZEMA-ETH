@echo off
color 0A
echo.
echo ========================================
echo    THAZEMA PUBLIC SERVER
echo ========================================
echo.
echo This will make your server PUBLIC!
echo Works on ANY network (WiFi + Mobile Data)
echo.
pause

echo.
echo ========================================
echo    Step 1: Install ngrok
echo ========================================
echo.
echo ngrok creates a public URL for your local server
echo.

REM Check if ngrok is installed
where ngrok >nul 2>nul
if %errorlevel% equ 0 (
    echo ✓ ngrok is already installed
    goto start_server
)

echo Installing ngrok...
call npm install -g ngrok
echo.

:start_server
echo ========================================
echo    Step 2: Start Thazema Server
echo ========================================
echo.
echo Starting server on port 5000...
echo.

REM Start server in background
start "Thazema Server" cmd /k "cd /d "%~dp0" && npm run dev"

echo Waiting for server to start...
timeout /t 5 /nobreak >nul
echo.

echo ========================================
echo    Step 3: Create Public URL
echo ========================================
echo.
echo Creating public tunnel with ngrok...
echo.

REM Start ngrok
start "ngrok" cmd /k "ngrok http 5000"

echo.
echo ========================================
echo    YOUR PUBLIC SERVER IS READY!
echo ========================================
echo.
echo Look at the ngrok window for your public URL
echo.
echo It will look like:
echo   https://abc123-xyz.ngrok-free.app
echo.
echo This URL works on:
echo   ✓ Any WiFi network
echo   ✓ Mobile data (4G/5G)
echo   ✓ Anywhere in the world
echo.
echo ========================================
echo    NEXT STEPS
echo ========================================
echo.
echo 1. Copy your ngrok URL from the ngrok window
echo 2. Test it in browser: https://your-url.ngrok-free.app/api/health
echo 3. Update mobile app with this URL
echo 4. Rebuild APK
echo 5. Test on phone!
echo.
echo ========================================
echo    UPDATE MOBILE APP
echo ========================================
echo.
set /p ngrok_url="Paste your ngrok URL here: "

echo.
echo Updating mobile app configuration...
echo.

REM Update API configuration
if not exist "client\src\config" mkdir client\src\config
echo const API_BASE_URL = '%ngrok_url%'; > client\src\config\api.js
echo export default API_BASE_URL; >> client\src\config\api.js

echo ✓ API URL updated to: %ngrok_url%
echo.

echo ========================================
echo    REBUILD APK
echo ========================================
echo.
set /p rebuild="Do you want to rebuild APK now? (y/n): "

if /i "%rebuild%"=="y" (
    echo.
    echo Building React app...
    cd client
    call npm run build
    cd ..
    echo.
    
    echo Copying to Capacitor...
    call npx cap copy android
    echo.
    
    echo Opening Android Studio...
    call npx cap open android
    echo.
    
    echo ========================================
    echo    Build APK in Android Studio
    echo ========================================
    echo.
    echo 1. Wait for Gradle sync
    echo 2. Build → Build APK
    echo 3. Install on phone
    echo 4. Test with your public URL!
    echo.
)

echo ========================================
echo    YOUR PUBLIC SERVER INFO
echo ========================================
echo.
echo Public URL: %ngrok_url%
echo Local Server: http://localhost:5000
echo.
echo Status: RUNNING
echo Access: WORLDWIDE
echo.
echo Test your public server:
echo   Browser: %ngrok_url%/api/health
echo   Mobile: Install APK and test!
echo.
echo ========================================
echo    IMPORTANT NOTES
echo ========================================
echo.
echo • Keep this window open (server is running)
echo • Keep ngrok window open (tunnel is active)
echo • ngrok URL changes when you restart
echo • For permanent URL, deploy to Railway/Heroku
echo.
echo Your server is now PUBLIC! 🚀
echo.
pause
