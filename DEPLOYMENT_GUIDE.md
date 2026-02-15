# 🚀 Thazema Public Server Deployment Guide

## Complete guide to deploy Thazema with SMS & WhatsApp integration

---

## 📋 TABLE OF CONTENTS

1. [SMS Integration Setup](#1-sms-integration-setup)
2. [WhatsApp Integration Setup](#2-whatsapp-integration-setup)
3. [Public Server Deployment](#3-public-server-deployment)
4. [Environment Configuration](#4-environment-configuration)
5. [Testing](#5-testing)

---

## 1. 📱 SMS INTEGRATION SETUP

### Option A: Twilio (Recommended - Works Worldwide)

**Step 1: Create Twilio Account**
1. Go to https://www.twilio.com/try-twilio
2. Sign up for free account ($15 credit)
3. Verify your phone number

**Step 2: Get Credentials**
1. Go to Console Dashboard
2. Copy your `Account SID`
3. Copy your `Auth Token`
4. Get a phone number (Phone Numbers → Buy a Number)

**Step 3: Configure in .env**
```env
SMS_PROVIDER=twilio
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token_here
TWILIO_PHONE_NUMBER=+1234567890
```

**Cost**: ~$0.0075 per SMS

---

### Option B: Africa's Talking (Best for Ethiopia!)

**Step 1: Create Account**
1. Go to https://africastalking.com
2. Sign up (Free for testing)
3. Verify your account

**Step 2: Get API Key**
1. Go to Dashboard
2. Click "API Key" in sidebar
3. Generate new API key
4. Copy your username and API key

**Step 3: Add Credits**
1. Go to "Billing"
2. Add credits (minimum $10)
3. Supports Ethiopian numbers (+251)

**Step 4: Configure in .env**
```env
SMS_PROVIDER=africastalking
AFRICASTALKING_API_KEY=your_api_key_here
AFRICASTALKING_USERNAME=your_username
```

**Cost**: ~$0.01 per SMS in Ethiopia

---

### Option C: Ethiopian SMS Gateway

If you have a local Ethiopian SMS provider:

```env
SMS_PROVIDER=ethiopian
ETHIOPIAN_SMS_API_URL=https://your-provider.com/api/send
ETHIOPIAN_SMS_API_KEY=your_api_key
```

Contact local providers:
- Ethio Telecom Business SMS
- Other Ethiopian SMS gateways

---

## 2. 💬 WHATSAPP INTEGRATION SETUP

### Step 1: Create Meta Business Account

1. Go to https://business.facebook.com
2. Create Business Account
3. Verify your business

### Step 2: Set Up WhatsApp Business API

1. Go to https://developers.facebook.com
2. Create new app
3. Select "Business" type
4. Add WhatsApp product

### Step 3: Get Phone Number

1. In WhatsApp settings
2. Add phone number
3. Verify with SMS
4. Copy Phone Number ID

### Step 4: Get Access Token

1. Go to WhatsApp → API Setup
2. Generate temporary access token (24h)
3. For production, create permanent token:
   - Go to System Users
   - Create system user
   - Generate token with `whatsapp_business_messaging` permission

### Step 5: Configure in .env

```env
ENABLE_WHATSAPP=true
WHATSAPP_PHONE_NUMBER_ID=123456789012345
WHATSAPP_ACCESS_TOKEN=EAAxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### Step 6: Create Message Templates

1. Go to WhatsApp → Message Templates
2. Create "OTP Verification" template:
```
Your Thazema verification code is: {{1}}

Valid for 5 minutes.
```
3. Wait for approval (usually 24-48 hours)

**Cost**: Free for first 1,000 conversations/month

---

## 3. 🌐 PUBLIC SERVER DEPLOYMENT

### Option A: Railway.app (Easiest - Recommended)

**Step 1: Prepare Your Code**
```bash
cd "websyit project"
git init
git add .
git commit -m "Initial commit"
```

**Step 2: Deploy to Railway**
1. Go to https://railway.app
2. Sign up with GitHub
3. Click "New Project"
4. Select "Deploy from GitHub repo"
5. Connect your repository
6. Railway will auto-detect Node.js

**Step 3: Add Environment Variables**
1. Go to your project
2. Click "Variables"
3. Add all variables from `.env.example`
4. Click "Deploy"

**Step 4: Get Public URL**
1. Go to "Settings"
2. Click "Generate Domain"
3. Copy your public URL: `https://your-app.railway.app`

**Cost**: Free tier available, then $5/month

---

### Option B: Heroku

**Step 1: Install Heroku CLI**
```bash
npm install -g heroku
heroku login
```

**Step 2: Create Heroku App**
```bash
cd "websyit project"
heroku create thazema-app
```

**Step 3: Add MongoDB**
```bash
heroku addons:create mongolab:sandbox
```

**Step 4: Set Environment Variables**
```bash
heroku config:set JWT_SECRET=your-secret
heroku config:set TWILIO_ACCOUNT_SID=your-sid
heroku config:set TWILIO_AUTH_TOKEN=your-token
# ... add all other variables
```

**Step 5: Deploy**
```bash
git push heroku main
heroku open
```

**Cost**: Free tier available (with limitations)

---

### Option C: Render.com

**Step 1: Create Account**
1. Go to https://render.com
2. Sign up with GitHub

**Step 2: Create Web Service**
1. Click "New +"
2. Select "Web Service"
3. Connect GitHub repository
4. Configure:
   - Name: thazema
   - Environment: Node
   - Build Command: `npm install`
   - Start Command: `npm run server`

**Step 3: Add Environment Variables**
1. Go to "Environment"
2. Add all variables from `.env.example`

**Step 4: Deploy**
- Render will auto-deploy
- Get your URL: `https://thazema.onrender.com`

**Cost**: Free tier available

---

### Option D: Your Own VPS (DigitalOcean, AWS, etc.)

**Step 1: Get a Server**
1. Create Ubuntu 22.04 server
2. Get server IP address

**Step 2: Connect via SSH**
```bash
ssh root@your-server-ip
```

**Step 3: Install Node.js**
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y mongodb
```

**Step 4: Upload Your Code**
```bash
# On your local machine
scp -r "websyit project" root@your-server-ip:/var/www/thazema
```

**Step 5: Install Dependencies**
```bash
cd /var/www/thazema
npm install
cd client && npm install && npm run build
```

**Step 6: Create .env File**
```bash
nano .env
# Paste your environment variables
```

**Step 7: Install PM2 (Process Manager)**
```bash
npm install -g pm2
pm2 start server/index.js --name thazema
pm2 startup
pm2 save
```

**Step 8: Set Up Nginx (Reverse Proxy)**
```bash
sudo apt-get install nginx
sudo nano /etc/nginx/sites-available/thazema
```

Add this configuration:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/thazema /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

**Step 9: Get SSL Certificate (HTTPS)**
```bash
sudo apt-get install certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

**Cost**: $5-10/month for basic VPS

---

## 4. ⚙️ ENVIRONMENT CONFIGURATION

### Create .env File

```bash
cd "websyit project"
cp .env.example .env
nano .env
```

### Required Variables:

```env
# Basic
NODE_ENV=production
PORT=5000
JWT_SECRET=your-super-secret-key-change-this

# Database (use MongoDB Atlas for cloud)
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/thazema

# SMS (choose one)
SMS_PROVIDER=africastalking
AFRICASTALKING_API_KEY=your_key
AFRICASTALKING_USERNAME=your_username

# WhatsApp
ENABLE_WHATSAPP=true
WHATSAPP_PHONE_NUMBER_ID=your_id
WHATSAPP_ACCESS_TOKEN=your_token

# Public URL
PUBLIC_URL=https://your-domain.com
CORS_ORIGINS=https://your-domain.com,https://www.your-domain.com
```

---

## 5. 🧪 TESTING

### Test SMS Integration

```bash
# Send test SMS
curl -X POST https://your-domain.com/api/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone": "+251912345678", "method": "sms"}'
```

### Test WhatsApp Integration

```bash
# Send test WhatsApp message
curl -X POST https://your-domain.com/api/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone": "+251912345678", "method": "whatsapp"}'
```

### Test Full Login Flow

1. Open your app: `https://your-domain.com`
2. Click "Login with Phone"
3. Enter Ethiopian number: `+251 912 345 678`
4. Click "Send OTP"
5. Check your phone for SMS/WhatsApp
6. Enter OTP
7. Should login successfully!

---

## 📱 UPDATE MOBILE APP

### Update API URL in Mobile App

**File**: `client/src/config/api.js`

```javascript
const API_URL = process.env.NODE_ENV === 'production'
  ? 'https://your-domain.com/api'
  : 'http://localhost:5000/api';

export default API_URL;
```

### Rebuild APK

```bash
cd "websyit project"
.\REBUILD_MOBILE_APK.bat
```

---

## 🎯 QUICK START CHECKLIST

- [ ] Choose SMS provider (Twilio or Africa's Talking)
- [ ] Get SMS API credentials
- [ ] Set up WhatsApp Business API
- [ ] Get WhatsApp credentials
- [ ] Choose deployment platform
- [ ] Deploy server
- [ ] Add environment variables
- [ ] Test SMS sending
- [ ] Test WhatsApp sending
- [ ] Update mobile app API URL
- [ ] Rebuild APK
- [ ] Test full login flow
- [ ] Launch! 🚀

---

## 💰 COST ESTIMATE

### Monthly Costs:

**Minimal Setup:**
- Railway/Render: Free tier
- MongoDB Atlas: Free tier (512MB)
- SMS (100 messages): ~$1
- WhatsApp (1000 messages): Free
- **Total: ~$1/month**

**Production Setup:**
- Railway: $5/month
- MongoDB Atlas: $9/month (2GB)
- SMS (1000 messages): ~$10
- WhatsApp (5000 messages): Free
- Domain: $12/year
- **Total: ~$25/month**

---

## 🆘 TROUBLESHOOTING

### SMS Not Sending?
1. Check API credentials in .env
2. Verify phone number format (+251...)
3. Check SMS provider balance
4. Look at server logs

### WhatsApp Not Working?
1. Verify access token is valid
2. Check phone number is verified
3. Ensure message templates are approved
4. Check Meta Business account status

### Server Not Accessible?
1. Check firewall settings
2. Verify port 5000 is open
3. Check CORS configuration
4. Look at deployment logs

---

## 📞 SUPPORT

**Administrator**: Abebe Mesfin  
**Phone**: +251 914 319 514  
**Email**: abebemesfin53@gmail.com

---

## 🎉 YOU'RE READY!

Your Thazema app is now:
- ✅ Publicly accessible
- ✅ Sending real SMS
- ✅ Integrated with WhatsApp
- ✅ Production-ready

**Launch your app and start connecting people!** 🚀

---

*Last Updated: February 2025*
