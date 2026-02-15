@echo off
echo ========================================
echo   OPENING ALL SETUP GUIDES
echo ========================================
echo.

echo Opening guides in your default text editor...
echo.

start "" "START_HERE.txt"
timeout /t 1 /nobreak >nul

start "" "READY_TO_GO.md"
timeout /t 1 /nobreak >nul

start "" "COMPLETE_SETUP_NOW.md"
timeout /t 1 /nobreak >nul

echo.
echo ✅ All guides opened!
echo.
echo Quick Reference:
echo - START_HERE.txt = Quick start (3 steps)
echo - READY_TO_GO.md = Complete overview
echo - COMPLETE_SETUP_NOW.md = Detailed instructions
echo.
echo ========================================
echo   READY TO START?
echo ========================================
echo.
echo Run these commands:
echo.
echo 1. SHARE_APK_NOW.bat     (Share APK to phone)
echo 2. QUICK_PUBLIC_SERVER.bat (Start public server)
echo.
pause
