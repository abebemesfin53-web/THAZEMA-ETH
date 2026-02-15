@echo off
echo 🔥 WINDOWS FIREWALL FIX FOR THAZEMA
echo =====================================
echo.

echo 📋 Step 1: Adding Node.js to Windows Firewall...
netsh advfirewall firewall add rule name="Node.js Server" dir=in action=allow protocol=TCP localport=3001
netsh advfirewall firewall add rule name="Node.js Server Out" dir=out action=allow protocol=TCP localport=3001

echo.
echo 📋 Step 2: Adding alternative port 8080...
netsh advfirewall firewall add rule name="Node.js Alt Port" dir=in action=allow protocol=TCP localport=8080
netsh advfirewall firewall add rule name="Node.js Alt Port Out" dir=out action=allow protocol=TCP localport=8080

echo.
echo 📋 Step 3: Checking current IP address...
echo Your computer's IP addresses:
ipconfig | findstr "IPv4"

echo.
echo 📋 Step 4: Testing server connectivity...
echo Testing if server is running on port 3001...
netstat -an | findstr ":3001"

echo.
echo ✅ FIREWALL RULES ADDED!
echo.
echo 📱 NEXT STEPS:
echo 1. Make sure your server is running (npm start)
echo 2. Test in phone browser: http://10.14.28.123:3001/api/health
echo 3. If still not working, try mobile hotspot
echo.
echo 🔧 TROUBLESHOOTING:
echo - Make sure phone and computer are on SAME WiFi
echo - Try temporarily disabling Windows Firewall
echo - Check router settings for device isolation
echo.
pause