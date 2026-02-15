@echo off
echo ========================================
echo   SETUP GITHUB REPOSITORY
echo ========================================
echo.
echo This will prepare your code for GitHub
echo.

REM Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Git is not installed!
    echo.
    echo Please install Git first:
    echo https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo ✅ Git is installed
echo.

REM Get GitHub username
set /p github_user="Enter your GitHub username: "
if "%github_user%"=="" (
    echo Error: GitHub username is required
    pause
    exit /b 1
)

echo.
echo ========================================
echo   INITIALIZING GIT REPOSITORY
echo ========================================
echo.

REM Initialize git if not already done
if not exist ".git" (
    echo Initializing git repository...
    git init
    echo ✅ Git initialized
) else (
    echo ✅ Git already initialized
)

echo.
echo Adding files...
git add .

echo.
echo Committing...
git commit -m "Initial commit - Thazema app ready for deployment"

echo.
echo ========================================
echo   NEXT STEPS:
echo ========================================
echo.
echo 1. Create a new repository on GitHub:
echo    https://github.com/new
echo.
echo 2. Repository settings:
echo    - Name: thazema
echo    - Description: Thazema - Real-time video and audio calling app
echo    - Visibility: Public
echo    - DON'T initialize with README
echo.
echo 3. Click "Create repository"
echo.
echo 4. Then run these commands:
echo.
echo    git remote add origin https://github.com/%github_user%/thazema.git
echo    git branch -M main
echo    git push -u origin main
echo.
echo ========================================
echo.

set /p open_github="Open GitHub in browser? (y/n): "
if /i "%open_github%"=="y" (
    start https://github.com/new
)

echo.
echo After creating the repository, run:
echo.
echo git remote add origin https://github.com/%github_user%/thazema.git
echo git branch -M main
echo git push -u origin main
echo.
pause
