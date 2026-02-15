@echo off
echo ========================================
echo   DEPLOY TO RAILWAY.APP
echo ========================================
echo.
echo This will deploy your Thazema server to Railway
echo You'll get a permanent public URL!
echo.
pause

echo.
echo Step 1: Checking Railway CLI...
where railway >nul 2>nul
if %errorlevel% neq 0 (
    echo Railway CLI not found. Installing...
    call npm install -g @railway/cli
    if %errorlevel% neq 0 (
        echo.
        echo ❌ Failed to install Railway CLI
        echo Please install manually: npm install -g @railway/cli
        pause
        exit /b 1
    )
)

echo ✅ Railway CLI is ready
echo.

echo Step 2: Login to Railway...
echo (A browser window will open)
echo.
call railway login
if %errorlevel% neq 0 (
    echo.
    echo ❌ Login failed
    pause
    exit /b 1
)

echo.
echo ✅ Logged in successfully
echo.

echo Step 3: Initialize Railway project...
call railway init
if %errorlevel% neq 0 (
    echo.
    echo ❌ Initialization failed
    pause
    exit /b 1
)

echo.
echo ✅ Project initialized
echo.

echo Step 4: Setting environment variables...
call railway variables set NODE_ENV=production
call railway variables set JWT_SECRET=thazema-secret-key-2024-abebe
call railway variables set PORT=5000

echo.
echo ✅ Environment variables set
echo.

echo Step 5: Deploying to Railway...
echo (This may take a few minutes)
echo.
call railway up
if %errorlevel% neq 0 (
    echo.
    echo ❌ Deployment failed
    echo Check the error messages above
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✅ DEPLOYMENT SUCCESSFUL!
echo ========================================
echo.

echo Getting your public URL...
call railway domain
echo.

echo ========================================
echo   NEXT STEPS:
echo ========================================
echo.
echo 1. Copy your Railway URL (shown above)
echo 2. Update client/src/config/api.js:
echo    - PRODUCTION_URL: 'https://your-railway-url.up.railway.app'
echo    - USE_PRODUCTION: true
echo.
echo 3. Rebuild APK:
echo    cd client
echo    npm run build
echo    cd ..
echo    npx cap copy android
echo    npx cap open android
echo.
echo 4. Build APK in Android Studio
echo 5. Install on phone and test!
echo.
echo ========================================
echo.
echo Your server is now LIVE and PUBLIC! 🚀
echo.
pause
