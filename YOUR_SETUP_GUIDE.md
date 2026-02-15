# 🎯 YOUR THAZEMA SETUP GUIDE

## Personalized Setup for +251 991 847 960

---

## ✅ CONFIGURED PHONE NUMBER

**Your Sender Number**: +251 991 847 960

This number will be used for:
- 📱 Sending SMS OTP codes
- 💬 Sending WhatsApp messages
- 🎉 Sending welcome messages

---

## 🚀 QUICK SETUP (3 STEPS)

### STEP 1: Get Africa's Talking Credentials (5 minutes)

**Why Africa's Talking?**
- Best for Ethiopian numbers (+251)
- Cheap SMS rates (~$0.01 per SMS)
- Easy setup
- Reliable delivery

**Setup Instructions:**

1. **Sign Up**
   - Go to: https://africastalking.com/register
   - Use your email: abebemesfin53@gmail.com
   - Verify your account

2. **Get API Credentials**
   - Login to dashboard
   - Go to: Settings → API Key
   - Click "Generate API Key"
   - Copy your:
     - Username (usually "sandbox" for testing)
     - API Key (long string)

3. **Add Credits**
   - Go to: Billing → Add Credits
   - Add minimum $10 (gets you ~1000 SMS)
   - Use mobile money or card

4. **Register Your Number**
   - Go to: SMS → Sender IDs
   - Add: +251991847960
   - Wait for approval (usually instant for testing)

5. **Update .env File**
   ```env
   AFRICASTALKING_API_KEY=paste_your_api_key_here
   AFRICASTALKING_USERNAME=paste_your_username_here
   ```

---

### STEP 2: Get WhatsApp Business API (10 minutes)

**Setup Instructions:**

1. **Create Meta Business Account**
   - Go to: https://business.facebook.com
   - Click "Create Account"
   - Business Name: "Thazema"
   - Your Name: Abebe Mesfin
   - Email: abebemesfin53@gmail.com

2. **Set Up WhatsApp Business**
   - Go to: https://developers.facebook.com
   - Click "My Apps" → "Create App"
   - Select "Business" type
   - App Name: "Thazema"
   - Contact Email: abebemesfin53@gmail.com

3. **Add WhatsApp Product**
   - In your app dashboard
   - Click "Add Product"
   - Select "WhatsApp"
   - Click "Set Up"

4. **Add Your Phone Number**
   - Go to: WhatsApp → Getting Started
   - Click "Add Phone Number"
   - Enter: +251 991 847 960
   - Verify with SMS code
   - Copy "Phone Number ID"

5. **Get Access Token**
   - In WhatsApp settings
   - Click "Generate Token"
   - Copy the temporary token (valid 24 hours)
   - For permanent token:
     - Go to: Settings → System Users
     - Create system user
     - Generate token with `whatsapp_business_messaging` permission

6. **Update .env File**
   ```env
   WHATSAPP_PHONE_NUMBER_ID=paste_phone_id_here
   WHATSAPP_ACCESS_TOKEN=paste_token_here
   ```

---

### STEP 3: Test Everything (2 minutes)

**Start Your Server:**
```bash
cd "websyit project"
npm run dev
```

**Test SMS Sending:**

Open browser console (F12) and run:
```javascript
fetch('http://localhost:5000/api/auth/send-otp', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    phone: '+251991847960',  // Your number
    method: 'sms'
  })
})
.then(r => r.json())
.then(data => {
  console.log('SMS Result:', data);
  alert('Check your phone for SMS!');
});
```

**Test WhatsApp Sending:**
```javascript
fetch('http://localhost:5000/api/auth/send-otp', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    phone: '+251991847960',  // Your number
    method: 'whatsapp'
  })
})
.then(r => r.json())
.then(data => {
  console.log('WhatsApp Result:', data);
  alert('Check your WhatsApp!');
});
```

**Check Your Phone!** 📱
- You should receive OTP via SMS
- You should receive OTP via WhatsApp

---

## 📝 YOUR COMPLETE .env FILE

```env
# Thazema Environment Configuration

# Server Configuration
NODE_ENV=development
PORT=5000
JWT_SECRET=thazema-secret-key-2024-abebe

# Database
MONGODB_URI=mongodb://localhost:27017/thazema

# SMS Configuration
SMS_PROVIDER=africastalking
SMS_SENDER_PHONE=+251991847960

# Africa's Talking Credentials
# Get from: https://africastalking.com
AFRICASTALKING_API_KEY=your_api_key_here
AFRICASTALKING_USERNAME=your_username_here

# WhatsApp Configuration
ENABLE_WHATSAPP=true
WHATSAPP_SENDER_PHONE=+251991847960

# WhatsApp Business API Credentials
# Get from: https://developers.facebook.com
WHATSAPP_PHONE_NUMBER_ID=your_phone_id_here
WHATSAPP_ACCESS_TOKEN=your_token_here

# Public Server URL (update when deployed)
PUBLIC_URL=http://localhost:5000
CORS_ORIGINS=http://localhost:3000,http://localhost:5000

# Feature Flags
ENABLE_SMS=true
ENABLE_WHATSAPP=true

# Administrator Contact
ADMIN_NAME=Abebe Mesfin
ADMIN_PHONE=+251914319514
ADMIN_EMAIL=abebemesfin53@gmail.com
```

---

## 🧪 TESTING CHECKLIST

Test with your own number first:

- [ ] Start server: `npm run dev`
- [ ] Test SMS to +251991847960
- [ ] Receive SMS OTP
- [ ] Test WhatsApp to +251991847960
- [ ] Receive WhatsApp OTP
- [ ] Test login flow with OTP
- [ ] Verify auto-registration works
- [ ] Check welcome message received

---

## 💰 COST ESTIMATE

### For Your Setup:

**Africa's Talking:**
- Initial credit: $10
- SMS cost: ~$0.01 per message
- Total SMS: ~1000 messages
- **Lasts**: 2-3 months (for testing)

**WhatsApp:**
- First 1000 conversations: FREE
- After that: ~$0.005 per conversation
- **Cost**: $0 for first month

**Total Monthly Cost**: ~$3-5 (after free tier)

---

## 🌐 DEPLOY TO PUBLIC SERVER

### Option 1: Railway.app (Recommended)

1. **Sign Up**: https://railway.app
2. **New Project** → Deploy from GitHub
3. **Add Environment Variables**:
   - Copy all from your .env file
   - Paste in Railway Variables section
4. **Generate Domain**
5. **Your app is live!**

**Your Public URL**: `https://thazema-abebe.railway.app`

### Option 2: Heroku

```bash
heroku create thazema-abebe
heroku config:set AFRICASTALKING_API_KEY=your_key
heroku config:set AFRICASTALKING_USERNAME=your_username
heroku config:set WHATSAPP_PHONE_NUMBER_ID=your_id
heroku config:set WHATSAPP_ACCESS_TOKEN=your_token
git push heroku main
```

---

## 📱 UPDATE MOBILE APP

**File**: `client/src/config/api.js`

```javascript
// Update this when you deploy
const API_BASE_URL = process.env.NODE_ENV === 'production'
  ? 'https://thazema-abebe.railway.app'
  : 'http://localhost:5000';

export default API_BASE_URL;
```

**Rebuild APK:**
```bash
.\REBUILD_MOBILE_APK.bat
```

---

## 🎯 WHAT USERS WILL SEE

### Login Screen:
```
┌─────────────────────────────┐
│      Welcome to Thazema     │
│                             │
│  🇪🇹 +251                   │
│  [991 847 960]              │
│                             │
│  ○ SMS    ○ WhatsApp        │
│                             │
│  [Send OTP]                 │
└─────────────────────────────┘
```

### SMS Received:
```
From: +251991847960
Message: Your Thazema verification 
code is: 123456. Valid for 5 minutes.
```

### WhatsApp Received:
```
From: +251 991 847 960
🔐 Your Thazema verification code is: 123456

Valid for 5 minutes.

Don't share this code with anyone.
```

---

## 🆘 TROUBLESHOOTING

### SMS Not Sending?
1. Check Africa's Talking balance
2. Verify API credentials in .env
3. Check sender ID is approved
4. Look at server logs

### WhatsApp Not Working?
1. Verify phone number in Meta
2. Check access token is valid
3. Ensure business account approved
4. Test with your own number first

### Server Errors?
```bash
# Check logs
npm run dev

# Look for errors in console
# Common issues:
# - Missing .env file
# - Wrong API credentials
# - Network issues
```

---

## 📞 YOUR CONTACT INFO

**Name**: Abebe Mesfin  
**Phone**: +251 914 319 514  
**Email**: abebemesfin53@gmail.com  
**WhatsApp**: +251 991 847 960  

---

## ✅ FINAL CHECKLIST

Before going live:

- [ ] Africa's Talking account created
- [ ] API credentials added to .env
- [ ] Credits added ($10 minimum)
- [ ] WhatsApp Business API set up
- [ ] Phone number verified
- [ ] Credentials added to .env
- [ ] Tested SMS sending
- [ ] Tested WhatsApp sending
- [ ] Tested full login flow
- [ ] Server deployed publicly
- [ ] Mobile app updated
- [ ] APK rebuilt
- [ ] End-to-end test completed

---

## 🎉 YOU'RE READY!

**Your Thazema app is configured with:**
- ✅ Your phone number: +251 991 847 960
- ✅ SMS sending ready
- ✅ WhatsApp sending ready
- ✅ Auto-registration enabled
- ✅ Welcome messages configured

**Next Steps:**
1. Get Africa's Talking credentials
2. Get WhatsApp Business API credentials
3. Update .env file
4. Test locally
5. Deploy to Railway
6. Launch! 🚀

---

**Good luck with your Thazema app!** 🎊

*Made with ❤️ for Ethiopia* 🇪🇹
