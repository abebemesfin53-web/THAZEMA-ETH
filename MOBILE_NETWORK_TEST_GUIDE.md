# 📱 MOBILE NETWORK TESTING GUIDE

## Test Thazema on Mobile Data & WiFi

---

## 🎯 TESTING SCENARIOS

We'll test:
1. ✅ WiFi Connection (Local Network)
2. ✅ Mobile Data Connection (Public Network)
3. ✅ SMS Sending
4. ✅ WhatsApp Sending
5. ✅ Full Login Flow

---

## 🔧 PREPARATION

### Step 1: Get Your Computer's IP Address

**On Windows:**
```bash
ipconfig
```
Look for "IPv4 Address" under your WiFi adapter
Example: `192.168.1.100` or `10.14.28.123`

**On Mac/Linux:**
```bash
ifconfig
```
Look for "inet" address
Example: `192.168.1.100`

### Step 2: Update Server Configuration

**File**: `websyit project/server/index.js`

Make sure server listens on all interfaces:
```javascript
const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📱 Local: http://localhost:${PORT}`);
  console.log(`🌐 Network: http://YOUR_IP:${PORT}`);
});
```

### Step 3: Allow Firewall Access

**On Windows:**
```bash
# Run as Administrator
netsh advfirewall firewall add rule name="Thazema Server" dir=in action=allow protocol=TCP localport=5000
```

Or use the existing script:
```bash
.\FIREWALL_FIX.bat
```

---

## 📱 TEST 1: WiFi CONNECTION (Same Network)

### Setup:
1. **Start Server**
   ```bash
   cd "websyit project"
   npm run dev
   ```

2. **Get Your IP**
   ```bash
   ipconfig
   # Example: 192.168.1.100
   ```

3. **Connect Phone to Same WiFi**
   - Phone Settings → WiFi
   - Connect to same network as computer

### Test on Phone:

**Method A: Browser Test**
1. Open Chrome on phone
2. Go to: `http://YOUR_IP:5000/api/auth/test`
   - Example: `http://192.168.1.100:5000/api/auth/test`
3. Should see: `{"message": "Server connection successful!"}`

**Method B: Test SMS Sending**
1. Open Chrome on phone
2. Go to: `http://YOUR_IP:5000`
3. Open Developer Tools (Chrome menu → Desktop site)
4. Console tab, paste:
```javascript
fetch('http://YOUR_IP:5000/api/auth/send-otp', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    phone: '+251991847960',
    method: 'sms'
  })
})
.then(r => r.json())
.then(data => {
  console.log('Result:', data);
  alert(JSON.stringify(data));
});
```

**Method C: Install APK**
1. Copy APK to phone:
   ```
   android/app/build/outputs/apk/debug/app-debug.apk
   ```
2. Install on phone
3. Open Thazema app
4. Should connect automatically

### Expected Results:
- ✅ Server responds
- ✅ API calls work
- ✅ SMS sends (if configured)
- ✅ App connects

---

## 📶 TEST 2: MOBILE DATA (Public Network)

### Why This is Different:
- WiFi: Direct connection (same network)
- Mobile Data: Needs public server (different network)

### Option A: Use ngrok (Quick Test)

**Step 1: Install ngrok**
```bash
# Download from: https://ngrok.com/download
# Or use npm:
npm install -g ngrok
```

**Step 2: Start ngrok**
```bash
# In new terminal
ngrok http 5000
```

**Step 3: Get Public URL**
```
Forwarding: https://abc123.ngrok.io -> http://localhost:5000
```

**Step 4: Test on Phone (Mobile Data)**
1. Turn OFF WiFi on phone
2. Use mobile data
3. Open browser
4. Go to: `https://abc123.ngrok.io/api/auth/test`
5. Should work!

**Step 5: Update Mobile App**
```javascript
// client/src/config/api.js
const API_BASE_URL = 'https://abc123.ngrok.io';
```

**Step 6: Rebuild APK**
```bash
.\REBUILD_MOBILE_APK.bat
```

### Option B: Deploy to Public Server

**Use Railway.app (Recommended):**

1. **Sign Up**: https://railway.app
2. **Deploy**: Connect GitHub repo
3. **Get URL**: `https://thazema.railway.app`
4. **Test**: Works on any network!

---

## 🧪 TEST 3: COMPLETE TESTING CHECKLIST

### WiFi Testing:

- [ ] Server starts successfully
- [ ] Can access from computer browser
- [ ] Can access from phone browser (same WiFi)
- [ ] API test endpoint works
- [ ] Send OTP works
- [ ] Verify OTP works
- [ ] Login flow completes
- [ ] Mobile app connects

### Mobile Data Testing:

- [ ] ngrok tunnel created
- [ ] Public URL accessible
- [ ] Can access from phone (mobile data)
- [ ] API test endpoint works
- [ ] Send OTP works (SMS)
- [ ] Send OTP works (WhatsApp)
- [ ] Verify OTP works
- [ ] Login flow completes
- [ ] Mobile app connects

### SMS Testing:

- [ ] SMS sends successfully
- [ ] OTP received on phone
- [ ] OTP is 6 digits
- [ ] OTP expires after 5 minutes
- [ ] Can verify OTP
- [ ] Welcome message received (new user)

### WhatsApp Testing:

- [ ] WhatsApp message sends
- [ ] OTP received on WhatsApp
- [ ] Message format is correct
- [ ] Can verify OTP
- [ ] Welcome message received

---

## 🔍 TROUBLESHOOTING

### Issue: Can't Connect on WiFi

**Solution 1: Check Firewall**
```bash
# Run as Administrator
.\FIREWALL_FIX.bat
```

**Solution 2: Check IP Address**
```bash
ipconfig
# Make sure using correct IP
```

**Solution 3: Check Server Binding**
```javascript
// server/index.js
app.listen(PORT, '0.0.0.0', () => {
  // Should bind to 0.0.0.0, not localhost
});
```

### Issue: Can't Connect on Mobile Data

**Solution: Use Public Server**
- ngrok (temporary)
- Railway.app (permanent)
- Heroku (permanent)

You CANNOT access localhost from mobile data!

### Issue: SMS Not Sending

**Check:**
1. Africa's Talking credentials in .env
2. API key is correct
3. Account has credits
4. Phone number format (+251...)

**Test Manually:**
```bash
curl -X POST http://localhost:5000/api/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone": "+251991847960", "method": "sms"}'
```

### Issue: WhatsApp Not Working

**Check:**
1. WhatsApp credentials in .env
2. Access token is valid (24h expiry)
3. Phone number verified in Meta
4. Business account approved

---

## 📊 NETWORK COMPARISON

| Feature | WiFi (Local) | Mobile Data (Public) |
|---------|-------------|---------------------|
| **Setup** | Easy | Needs public server |
| **Speed** | Fast | Depends on signal |
| **Cost** | Free | Data charges apply |
| **Access** | Same network only | Anywhere |
| **Best For** | Development | Production |

---

## 🚀 QUICK TEST COMMANDS

### Test Server (Computer):
```bash
# Start server
npm run dev

# Test endpoint
curl http://localhost:5000/api/auth/test
```

### Test WiFi (Phone Browser):
```
http://YOUR_IP:5000/api/auth/test
```

### Test Mobile Data (Phone Browser):
```
https://your-ngrok-url.ngrok.io/api/auth/test
```

### Test SMS:
```bash
curl -X POST http://localhost:5000/api/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone": "+251991847960", "method": "sms"}'
```

### Test WhatsApp:
```bash
curl -X POST http://localhost:5000/api/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone": "+251991847960", "method": "whatsapp"}'
```

---

## 📱 MOBILE APP CONFIGURATION

### For WiFi Testing:
```javascript
// client/src/config/api.js
const API_BASE_URL = 'http://192.168.1.100:5000';
```

### For Mobile Data Testing (ngrok):
```javascript
// client/src/config/api.js
const API_BASE_URL = 'https://abc123.ngrok.io';
```

### For Production:
```javascript
// client/src/config/api.js
const API_BASE_URL = 'https://thazema.railway.app';
```

---

## ✅ SUCCESS CRITERIA

### WiFi Test Passed:
- ✅ Phone connects to server
- ✅ API calls work
- ✅ Can send OTP
- ✅ Can verify OTP
- ✅ Login works

### Mobile Data Test Passed:
- ✅ Phone connects via public URL
- ✅ API calls work
- ✅ SMS sends successfully
- ✅ WhatsApp sends successfully
- ✅ Full login flow works

---

## 🎯 RECOMMENDED TESTING ORDER

1. **Start Local** (WiFi)
   - Test on computer
   - Test on phone (same WiFi)
   - Verify all features work

2. **Test Public** (Mobile Data)
   - Set up ngrok
   - Test on phone (mobile data)
   - Verify all features work

3. **Deploy Production**
   - Deploy to Railway/Heroku
   - Test on phone (mobile data)
   - Final verification

---

## 📞 SUPPORT

**Administrator**: Abebe Mesfin  
**Phone**: +251 914 319 514  
**Email**: abebemesfin53@gmail.com  
**WhatsApp**: +251 991 847 960

---

## 🎉 YOU'RE READY TO TEST!

Follow this guide step by step and your Thazema app will work on both WiFi and mobile data! 🚀

---

*Test thoroughly before launching!* ✨
