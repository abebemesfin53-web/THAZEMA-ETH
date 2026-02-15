@echo off
echo 🌐 THAZEMA NETWORK DIAGNOSTIC
echo ============================
echo.

echo 📋 Step 1: Checking your computer's IP addresses...
echo.
ipconfig | findstr "IPv4"
echo.

echo 📋 Step 2: Checking if server is running...
echo Looking for Node.js processes on port 3001...
netstat -an | findstr ":3001"
echo.
echo Looking for Node.js processes on port 8080...
netstat -an | findstr ":8080"
echo.

echo 📋 Step 3: Testing local server connection...
echo Testing localhost connection...
curl -s http://localhost:3001/api/health 2>nul
if %errorlevel% equ 0 (
    echo ✅ Local server is responding
) else (
    echo ❌ Local server is not responding
)
echo.

echo 📋 Step 4: Testing IP address connection...
echo Testing IP address connection...
curl -s http://10.14.28.123:3001/api/health 2>nul
if %errorlevel% equ 0 (
    echo ✅ IP address connection works
) else (
    echo ❌ IP address connection failed
)
echo.

echo 📋 Step 5: Checking Windows Firewall status...
netsh advfirewall show allprofiles | findstr "State"
echo.

echo 📋 Step 6: Checking for firewall rules...
netsh advfirewall firewall show rule name="Node.js Server" 2>nul
if %errorlevel% equ 0 (
    echo ✅ Firewall rule exists
) else (
    echo ❌ No firewall rule found
    echo Run FIREWALL_FIX.bat as administrator to add rules
)
echo.

echo 🔧 NEXT STEPS:
echo 1. Make sure server is running: npm start
echo 2. If no firewall rule, run: FIREWALL_FIX.bat (as admin)
echo 3. Test on phone browser: http://10.14.28.123:3001/api/health
echo 4. If still fails, try mobile hotspot
echo.
pause