@echo off
color 0A
echo.
echo ========================================
echo    THAZEMA OFFICIAL LAUNCH
echo ========================================
echo.
echo This will deploy your server publicly
echo and build the official APK!
echo.
echo Your app will work on:
echo   ✓ Any WiFi network
echo   ✓ Mobile data (4G/5G)
echo   ✓ Anywhere in the world
echo.
pause

echo.
echo ========================================
echo    STEP 1: Prepare for Deployment
echo ========================================
echo.

REM Check if git is initialized
if not exist ".git" (
    echo Initializing Git repository...
    git init
    echo.
)

echo Adding all files to Git...
git add .
echo.

echo Committing changes...
git commit -m "Thazema official launch - ready for deployment"
echo.

echo ========================================
echo    STEP 2: Choose Deployment Method
echo ========================================
echo.
echo 1. Railway.app (Recommended - Easiest)
echo 2. Render.com (Alternative)
echo 3. Heroku (Traditional)
echo 4. Manual (I'll do it myself)
echo.
set /p deploy_choice="Enter your choice (1-4): "

if "%deploy_choice%"=="1" goto railway
if "%deploy_choice%"=="2" goto render
if "%deploy_choice%"=="3" goto heroku
if "%deploy_choice%"=="4" goto manual

:railway
cls
echo.
echo ========================================
echo    RAILWAY.APP DEPLOYMENT
echo ========================================
echo.
echo Follow these steps:
echo.
echo 1. Go to: https://railway.app
echo 2. Click "Start a New Project"
echo 3. Click "Deploy from GitHub repo"
echo 4. Select your "thazema" repository
echo 5. Railway will auto-deploy!
echo.
echo 6. Add Environment Variables:
echo    - Click "Variables" tab
echo    - Add all variables from .env.example
echo.
echo 7. Generate Domain:
echo    - Go to "Settings" tab
echo    - Click "Generate Domain"
echo    - Copy your URL
echo.
echo Your URL will be something like:
echo https://thazema-production.up.railway.app
echo.
set /p public_url="Paste your Railway URL here: "
goto update_app

:render
cls
echo.
echo ========================================
echo    RENDER.COM DEPLOYMENT
echo ========================================
echo.
echo Follow these steps:
echo.
echo 1. Go to: https://render.com
echo 2. Sign up with GitHub
echo 3. Click "New +" → "Web Service"
echo 4. Connect your repository
echo 5. Configure:
echo    - Name: thazema
echo    - Environment: Node
echo    - Build: npm install
echo    - Start: node server/index.js
echo 6. Add environment variables
echo 7. Click "Create Web Service"
echo.
echo Your URL will be something like:
echo https://thazema.onrender.com
echo.
set /p public_url="Paste your Render URL here: "
goto update_app

:heroku
cls
echo.
echo ========================================
echo    HEROKU DEPLOYMENT
echo ========================================
echo.
echo Installing Heroku CLI...
call npm install -g heroku
echo.

echo Logging in to Heroku...
call heroku login
echo.

echo Creating Heroku app...
call heroku create thazema-ethiopia
echo.

echo Deploying to Heroku...
git push heroku main
echo.

echo Getting your Heroku URL...
for /f "tokens=*" %%i in ('heroku info -s ^| findstr web_url') do set public_url=%%i
set public_url=%public_url:web_url=%
echo.
echo Your Heroku URL: %public_url%
echo.

echo.
echo IMPORTANT: Set environment variables in Heroku dashboard!
echo Go to: https://dashboard.heroku.com
echo.
pause
goto update_app

:manual
cls
echo.
echo ========================================
echo    MANUAL DEPLOYMENT
echo ========================================
echo.
echo Please follow DEPLOY_NOW.md for detailed instructions.
echo.
echo After deploying, come back and run this script again
echo to update the mobile app and build APK.
echo.
pause
exit

:update_app
cls
echo.
echo ========================================
echo    STEP 3: Update Mobile App
echo ========================================
echo.
echo Updating API configuration with your public URL...
echo.

REM Create config directory if it doesn't exist
if not exist "client\src\config" mkdir client\src\config

REM Update api.js
echo const API_BASE_URL = '%public_url%'; > client\src\config\api.js
echo export default API_BASE_URL; >> client\src\config\api.js

echo ✓ API URL updated to: %public_url%
echo.

REM Update capacitor.config.ts
echo import { CapacitorConfig } from '@capacitor/core'; > capacitor.config.ts
echo. >> capacitor.config.ts
echo const config: CapacitorConfig = { >> capacitor.config.ts
echo   appId: 'com.thazema.app', >> capacitor.config.ts
echo   appName: 'Thazema', >> capacitor.config.ts
echo   webDir: 'client/build', >> capacitor.config.ts
echo   server: { >> capacitor.config.ts
echo     url: '%public_url%', >> capacitor.config.ts
echo     cleartext: true >> capacitor.config.ts
echo   } >> capacitor.config.ts
echo }; >> capacitor.config.ts
echo. >> capacitor.config.ts
echo export default config; >> capacitor.config.ts

echo ✓ Capacitor config updated
echo.

echo ========================================
echo    STEP 4: Build React App
echo ========================================
echo.
echo Building optimized production build...
cd client
call npm run build
if %errorlevel% neq 0 (
    echo ❌ Build failed!
    pause
    exit /b 1
)
cd ..
echo.
echo ✓ React app built successfully
echo.

echo ========================================
echo    STEP 5: Copy to Capacitor
echo ========================================
echo.
echo Copying web assets to Android...
call npx cap copy android
call npx cap sync android
echo.
echo ✓ Files copied to Android project
echo.

echo ========================================
echo    STEP 6: Build APK
echo ========================================
echo.
echo Opening Android Studio...
call npx cap open android
echo.

echo ========================================
echo    NEXT STEPS IN ANDROID STUDIO
echo ========================================
echo.
echo 1. Wait for Gradle sync to complete
echo    (Check bottom status bar)
echo.
echo 2. Build APK:
echo    Build → Build Bundle(s)/APK(s) → Build APK(s)
echo.
echo 3. Wait 2-5 minutes for build
echo.
echo 4. Find your APK at:
echo    android\app\build\outputs\apk\debug\app-debug.apk
echo.
echo 5. Install on your phone and test!
echo.

echo ========================================
echo    YOUR OFFICIAL DEPLOYMENT
echo ========================================
echo.
echo ✓ Server URL: %public_url%
echo ✓ APK Location: android\app\build\outputs\apk\debug\app-debug.apk
echo.
echo ========================================
echo    TEST YOUR APK
echo ========================================
echo.
echo 1. Install APK on phone
echo 2. Turn OFF WiFi (use mobile data)
echo 3. Open Thazema app
echo 4. Should connect automatically!
echo 5. Test login with: +251 991 847 960
echo.
echo ========================================
echo    DISTRIBUTE YOUR APK
echo ========================================
echo.
echo Share your APK via:
echo   • WhatsApp
echo   • Telegram
echo   • Google Drive
echo   • Email
echo   • Play Store (official)
echo.
echo ========================================
echo    CONGRATULATIONS!
echo ========================================
echo.
echo Your Thazema app is now OFFICIALLY LAUNCHED! 🚀
echo.
echo Server: %public_url%
echo Works on: Any WiFi + Mobile Data
echo Ready for: All developers and users
echo.
echo Share your app and start connecting people! 🎉
echo.
pause
