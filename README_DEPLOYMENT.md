# 🚀 Thazema - Public Server Deployment

## Quick Start

Your Thazema server is ready to deploy! Choose your preferred method:

### 🎯 Option 1: Railway.app (Recommended)

**Fastest and easiest deployment:**

```bash
DEPLOY_RAILWAY.bat
```

This will:
1. Install Railway CLI
2. Login to Railway
3. Deploy your server
4. Give you a permanent public URL

**Time**: 5 minutes  
**Cost**: Free (with $5/month credit)  
**URL**: `https://thazema-production.up.railway.app`

---

### 🎯 Option 2: Render.com

**Reliable free hosting:**

```bash
DEPLOY_RENDER.bat
```

Follow the guide to deploy via GitHub.

**Time**: 10 minutes  
**Cost**: Free  
**URL**: `https://thazema.onrender.com`

---

### 🎯 Option 3: One-Click Deploy

```bash
DEPLOY_NOW.bat
```

Choose your platform and follow the wizard.

---

## After Deployment

### 1. Get Your Public URL

After deployment, you'll get a URL like:
- Railway: `https://thazema-production.up.railway.app`
- Render: `https://thazema.onrender.com`

### 2. Update Mobile App

Edit `client/src/config/api.js`:

```javascript
const SERVER_CONFIG = {
  PRODUCTION_URL: 'https://your-actual-url.up.railway.app',
  USE_PRODUCTION: true
};
```

### 3. Rebuild APK

```bash
cd client
npm run build
cd ..
npx cap copy android
npx cap open android
```

In Android Studio:
- Build → Build APK
- Install on phone

### 4. Test

Your app will now work on:
- ✅ Any WiFi network
- ✅ Mobile data (4G/5G)
- ✅ Anywhere in the world

---

## Environment Variables

Your server needs these environment variables:

```
NODE_ENV=production
JWT_SECRET=thazema-secret-key-2024-abebe
PORT=5000
```

These are automatically set by the deployment scripts.

---

## Troubleshooting

### Deployment Failed?

1. Check logs in your platform dashboard
2. Make sure all files are committed
3. Check `package.json` has `"start": "node server/index.js"`
4. Verify environment variables are set

### Can't Connect from App?

1. Test URL in browser: `https://your-url/api/health`
2. Make sure you updated `api.js` with correct URL
3. Make sure you rebuilt APK
4. Make sure you installed the NEW APK

### Server Errors?

Check logs:
```bash
# Railway
railway logs

# Render
# Check logs in dashboard
```

---

## Features

Your deployed server includes:

- ✅ User authentication (OTP, Email)
- ✅ Real-time messaging (Socket.io)
- ✅ Video/Audio calls (WebRTC)
- ✅ Admin dashboard
- ✅ User management
- ✅ Analytics
- ✅ Notifications

---

## Support

**Administrator**: Abebe Mesfin  
**Phone**: +251 914 319 514  
**Email**: abebemesfin53@gmail.com

---

## Documentation

- `DEPLOY_PUBLIC_SERVER.md` - Detailed deployment guide
- `DEPLOY_RAILWAY.bat` - Automated Railway deployment
- `DEPLOY_RENDER.bat` - Render setup guide
- `DEPLOY_NOW.bat` - Interactive deployment wizard

---

## Quick Commands

```bash
# Deploy to Railway
DEPLOY_RAILWAY.bat

# Deploy to Render
DEPLOY_RENDER.bat

# Interactive deployment
DEPLOY_NOW.bat

# Update app after deployment
cd client && npm run build && cd ..
npx cap copy android
npx cap open android
```

---

**Your server will be live in minutes!** 🚀
