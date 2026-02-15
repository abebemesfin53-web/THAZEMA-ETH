@echo off
echo ========================================
echo    Thazema Mobile Connection Test
echo ========================================
echo.

echo [Step 1] Getting your computer's IP address...
echo.
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set IP=%%a
    set IP=!IP:~1!
    echo Your IP Address: !IP!
)
echo.

echo [Step 2] Testing server connection...
echo.
curl -s http://localhost:5000/api/health
echo.
echo.

echo [Step 3] Instructions for mobile testing:
echo.
echo ========================================
echo    WiFi Testing (Same Network)
echo ========================================
echo.
echo 1. Connect your phone to the SAME WiFi as this computer
echo 2. Open Chrome browser on your phone
echo 3. Go to: http://!IP!:5000/api/health
echo 4. You should see: {"status":"ok",...}
echo.
echo ========================================
echo    Mobile Data Testing (Public Network)
echo ========================================
echo.
echo For mobile data, you need a public server.
echo.
echo Option 1: Use ngrok (Quick test)
echo   - Download: https://ngrok.com/download
echo   - Run: ngrok http 5000
echo   - Use the https URL on your phone
echo.
echo Option 2: Deploy to Railway.app
echo   - Sign up: https://railway.app
echo   - Deploy your code
echo   - Get public URL
echo   - Works on any network!
echo.
echo ========================================
echo    Test SMS/WhatsApp
echo ========================================
echo.
echo Test SMS:
echo curl -X POST http://!IP!:5000/api/auth/send-otp -H "Content-Type: application/json" -d "{\"phone\":\"+251991847960\",\"method\":\"sms\"}"
echo.
echo Test WhatsApp:
echo curl -X POST http://!IP!:5000/api/auth/send-otp -H "Content-Type: application/json" -d "{\"phone\":\"+251991847960\",\"method\":\"whatsapp\"}"
echo.
echo ========================================
pause
