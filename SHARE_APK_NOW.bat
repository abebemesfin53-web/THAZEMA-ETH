@echo off
echo ========================================
echo   THAZEMA - SHARE APK TO PHONE
echo ========================================
echo.

echo Your APK is ready at:
echo android\app\build\outputs\apk\debug\app-debug.apk
echo.
echo Size: 10.5 MB
echo.

echo ========================================
echo   CHOOSE YOUR METHOD:
echo ========================================
echo.
echo 1. Copy APK to Desktop (then share via WhatsApp/Email)
echo 2. Open APK folder (then copy to phone via USB)
echo 3. Start local web server (download on phone via WiFi)
echo 4. Show all methods
echo 5. Exit
echo.

set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto desktop
if "%choice%"=="2" goto folder
if "%choice%"=="3" goto webserver
if "%choice%"=="4" goto allmethods
if "%choice%"=="5" goto end

:desktop
echo.
echo Copying APK to Desktop...
copy "android\app\build\outputs\apk\debug\app-debug.apk" "%USERPROFILE%\Desktop\Thazema.apk"
echo.
echo ✅ DONE! APK copied to Desktop as "Thazema.apk"
echo.
echo Now you can:
echo - Send it via WhatsApp to yourself
echo - Email it to: abebemesfin53@gmail.com
echo - Upload to Google Drive
echo.
pause
goto end

:folder
echo.
echo Opening APK folder...
explorer "android\app\build\outputs\apk\debug"
echo.
echo ✅ Folder opened!
echo.
echo Now:
echo 1. Connect your phone via USB
echo 2. Copy app-debug.apk to phone's Download folder
echo 3. On phone, open Files app and tap the APK to install
echo.
pause
goto end

:webserver
echo.
echo Starting local web server...
echo.
echo Your computer IP address:
ipconfig | findstr /i "IPv4"
echo.
echo Starting server on port 8000...
echo.
cd android\app\build\outputs\apk\debug
echo.
echo ========================================
echo   SERVER RUNNING!
echo ========================================
echo.
echo On your phone (connected to SAME WiFi):
echo 1. Open Chrome browser
echo 2. Go to: http://YOUR_IP_ADDRESS:8000
echo 3. Click on app-debug.apk to download
echo 4. Install the APK
echo.
echo Press Ctrl+C to stop server
echo.
python -m http.server 8000
goto end

:allmethods
echo.
echo ========================================
echo   ALL METHODS TO SHARE APK:
echo ========================================
echo.
echo METHOD 1: USB Cable (FASTEST)
echo - Connect phone via USB
echo - Copy APK to phone's Download folder
echo - Install from Files app
echo.
echo METHOD 2: WhatsApp (EASIEST)
echo - Send APK to yourself on WhatsApp
echo - Download on phone and install
echo.
echo METHOD 3: Email
echo - Email APK to: abebemesfin53@gmail.com
echo - Download on phone and install
echo.
echo METHOD 4: Google Drive
echo - Upload APK to Google Drive
echo - Share link and download on phone
echo.
echo METHOD 5: Local Web Server
echo - Run option 3 from main menu
echo - Download on phone via WiFi
echo.
echo See SHARE_APK_TO_PHONE.md for detailed instructions
echo.
pause
goto end

:end
echo.
echo ========================================
echo   NEXT STEPS:
echo ========================================
echo.
echo After installing APK on phone:
echo 1. Run: QUICK_PUBLIC_SERVER.bat
echo 2. Get your public URL from ngrok
echo 3. Test the app on your phone!
echo.
echo ========================================
pause
