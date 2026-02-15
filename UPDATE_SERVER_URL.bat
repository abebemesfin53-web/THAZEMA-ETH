@echo off
echo ========================================
echo   UPDATE SERVER URL
echo ========================================
echo.
echo This will update your app to use a PUBLIC URL
echo.

set /p ngrok_url="Enter your ngrok URL (e.g., https://abc123.ngrok-free.app): "

if "%ngrok_url%"=="" (
    echo Error: No URL provided!
    pause
    exit /b 1
)

echo.
echo Updating configuration...
echo.

REM Create backup
copy "client\src\config\api.js" "client\src\config\api.js.backup" >nul

REM Update the file using PowerShell
powershell -Command "(Get-Content 'client\src\config\api.js') -replace 'PRODUCTION_URL: ''.*''', 'PRODUCTION_URL: ''%ngrok_url%''' | Set-Content 'client\src\config\api.js'"
powershell -Command "(Get-Content 'client\src\config\api.js') -replace 'USE_PRODUCTION: false', 'USE_PRODUCTION: true' | Set-Content 'client\src\config\api.js'"

echo.
echo ✅ Configuration updated!
echo.
echo Server URL: %ngrok_url%
echo Production mode: ENABLED
echo.
echo ========================================
echo   NEXT: REBUILD APK
echo ========================================
echo.
echo Run these commands:
echo.
echo cd client
echo npm run build
echo cd ..
echo npx cap copy android
echo npx cap open android
echo.
echo Then in Android Studio:
echo Build → Build APK
echo.
pause
