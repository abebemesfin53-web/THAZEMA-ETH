@echo off
echo ========================================
echo   DEPLOY THAZEMA PUBLIC SERVER
echo ========================================
echo.
echo Choose your deployment platform:
echo.
echo 1. Railway.app (Recommended - Fast, Free)
echo 2. Render.com (Free, Reliable)
echo 3. Manual GitHub Setup
echo 4. Exit
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto railway
if "%choice%"=="2" goto render
if "%choice%"=="3" goto github
if "%choice%"=="4" goto end

:railway
echo.
echo ========================================
echo   DEPLOYING TO RAILWAY.APP
echo ========================================
echo.
call DEPLOY_RAILWAY.bat
goto end

:render
echo.
echo ========================================
echo   DEPLOYING TO RENDER.COM
echo ========================================
echo.
call DEPLOY_RENDER.bat
goto end

:github
echo.
echo ========================================
echo   GITHUB SETUP
echo ========================================
echo.
echo Setting up GitHub repository...
echo.

set /p github_username="Enter your GitHub username: "
set /p repo_name="Enter repository name (default: thazema): "

if "%repo_name%"=="" set repo_name=thazema

echo.
echo Creating local git repository...
git init
if %errorlevel% neq 0 (
    echo.
    echo ❌ Git not found. Please install Git first.
    echo Download from: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo.
echo Adding files...
git add .

echo.
echo Committing...
git commit -m "Initial commit - Thazema app"

echo.
echo ========================================
echo   NEXT STEPS:
echo ========================================
echo.
echo 1. Create a new repository on GitHub:
echo    https://github.com/new
echo.
echo 2. Repository name: %repo_name%
echo 3. Make it Public
echo 4. Click "Create repository"
echo.
echo 5. Then run these commands:
echo.
echo    git remote add origin https://github.com/%github_username%/%repo_name%.git
echo    git branch -M main
echo    git push -u origin main
echo.
echo 6. Then deploy using Railway or Render
echo.
pause
goto end

:end
echo.
echo ========================================
echo   DEPLOYMENT GUIDE
echo ========================================
echo.
echo For detailed instructions, see:
echo - DEPLOY_PUBLIC_SERVER.md
echo - DEPLOY_RAILWAY.bat (automated Railway deployment)
echo - DEPLOY_RENDER.bat (Render setup guide)
echo.
echo After deployment:
echo 1. Get your public URL
echo 2. Update client/src/config/api.js
echo 3. Rebuild APK
echo 4. Install on phone
echo.
pause
