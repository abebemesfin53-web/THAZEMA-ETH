@echo off
echo ========================================
echo   DEPLOY TO RENDER.COM
echo ========================================
echo.
echo This will help you deploy to Render.com
echo.
echo Render.com provides:
echo - Free tier
echo - Permanent URL
echo - Automatic HTTPS
echo - Easy deployment
echo.
pause

echo.
echo ========================================
echo   DEPLOYMENT STEPS:
echo ========================================
echo.
echo 1. Go to: https://render.com
echo 2. Sign up with GitHub
echo 3. Click "New +" then "Web Service"
echo 4. Connect your GitHub repository
echo.
echo If you don't have a GitHub repo yet:
echo.

set /p has_github="Do you have a GitHub repository? (y/n): "

if /i "%has_github%"=="n" (
    echo.
    echo Creating GitHub repository...
    echo.
    echo Please follow these steps:
    echo.
    echo 1. Go to: https://github.com/new
    echo 2. Repository name: thazema
    echo 3. Make it Public
    echo 4. Click "Create repository"
    echo.
    echo Then run these commands:
    echo.
    echo cd "websyit project"
    echo git init
    echo git add .
    echo git commit -m "Initial commit"
    echo git remote add origin https://github.com/YOUR_USERNAME/thazema.git
    echo git push -u origin main
    echo.
    pause
)

echo.
echo ========================================
echo   RENDER CONFIGURATION:
echo ========================================
echo.
echo When setting up on Render, use these settings:
echo.
echo Name: thazema
echo Environment: Node
echo Build Command: npm install
echo Start Command: npm start
echo Plan: Free
echo.
echo Environment Variables:
echo - NODE_ENV = production
echo - JWT_SECRET = thazema-secret-key-2024-abebe
echo - PORT = 5000
echo.
echo ========================================
echo.

echo Opening Render.com...
start https://render.com

echo.
echo After deployment:
echo 1. Copy your Render URL (e.g., https://thazema.onrender.com)
echo 2. Update client/src/config/api.js with your URL
echo 3. Rebuild APK
echo 4. Install on phone
echo.
echo See DEPLOY_PUBLIC_SERVER.md for detailed instructions
echo.
pause
