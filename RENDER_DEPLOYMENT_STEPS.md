# 🚀 RENDER.COM DEPLOYMENT - STEP BY STEP

## Overview

Render.com provides free hosting with a permanent URL. Let's deploy your Thazema server!

---

## 📋 PREREQUISITES

Before starting, you need:
1. GitHub account (free)
2. Render.com account (free)
3. Your code pushed to GitHub

---

## STEP 1: PUSH CODE TO GITHUB

### Option A: Create New Repository

1. **Go to GitHub**: https://github.com/new

2. **Create repository**:
   - Repository name: `thazema`
   - Description: `Thazema - Real-time video and audio calling app`
   - Make it **Public**
   - Don't initialize with README (we have code already)
   - Click "Create repository"

3. **Push your code**:
   ```bash
   cd "websyit project"
   
   # Initialize git (if not already done)
   git init
   
   # Add all files
   git add .
   
   # Commit
   git commit -m "Initial commit - Thazema app ready for deployment"
   
   # Add remote (replace YOUR_USERNAME with your GitHub username)
   git remote add origin https://github.com/YOUR_USERNAME/thazema.git
   
   # Push to GitHub
   git branch -M main
   git push -u origin main
   ```

### Option B: Use Existing Repository

If you already have a GitHub repo:
```bash
cd "websyit project"
git add .
git commit -m "Update for Render deployment"
git push
```

---

## STEP 2: CREATE RENDER ACCOUNT

1. **Go to Render**: https://render.com

2. **Sign up with GitHub**:
   - Click "Get Started"
   - Click "GitHub" to sign up
   - Authorize Render to access your GitHub

3. **You're logged in!** ✅

---

## STEP 3: CREATE WEB SERVICE

1. **Click "New +"** (top right)

2. **Select "Web Service"**

3. **Connect Repository**:
   - Click "Connect account" if needed
   - Find your `thazema` repository
   - Click "Connect"

---

## STEP 4: CONFIGURE SERVICE

Fill in these settings:

### Basic Settings:
- **Name**: `thazema` (or any name you prefer)
- **Region**: Choose closest to Ethiopia (e.g., Frankfurt, Singapore)
- **Branch**: `main`
- **Root Directory**: Leave empty
- **Runtime**: `Node`

### Build & Deploy:
- **Build Command**: `npm install`
- **Start Command**: `npm start`

### Instance Type:
- **Plan**: Select **"Free"** (0$/month)

---

## STEP 5: ADD ENVIRONMENT VARIABLES

Scroll down to **"Environment Variables"** section:

Click **"Add Environment Variable"** and add these:

1. **NODE_ENV**
   - Key: `NODE_ENV`
   - Value: `production`

2. **JWT_SECRET**
   - Key: `JWT_SECRET`
   - Value: `thazema-secret-key-2024-abebe`

3. **PORT** (optional, Render sets this automatically)
   - Key: `PORT`
   - Value: `5000`

---

## STEP 6: DEPLOY

1. **Click "Create Web Service"** (bottom of page)

2. **Wait for deployment** (5-10 minutes):
   - You'll see build logs
   - Status will change from "Building" → "Live"
   - Don't close the page!

3. **Deployment complete!** ✅

---

## STEP 7: GET YOUR PUBLIC URL

After deployment:

1. **Your URL is shown at the top**:
   ```
   https://thazema.onrender.com
   ```
   (or similar)

2. **Copy this URL!** You'll need it for the mobile app.

3. **Test it in browser**:
   ```
   https://thazema.onrender.com/api/health
   ```
   
   Should show:
   ```json
   {"status":"ok","message":"Thazema server is running"}
   ```

---

## STEP 8: UPDATE MOBILE APP

Now update your mobile app to use the public URL:

1. **Open file**: `client/src/config/api.js`

2. **Update these lines**:
   ```javascript
   const SERVER_CONFIG = {
     LOCAL_IP: '10.14.28.123',
     PORT: '5000',
     
     // YOUR RENDER URL HERE
     PRODUCTION_URL: 'https://thazema.onrender.com',
     
     // ENABLE PRODUCTION MODE
     USE_PRODUCTION: true
   };
   ```

3. **Save the file**

---

## STEP 9: REBUILD APK

Now rebuild your APK with the new URL:

```bash
# Build React app
cd client
npm run build
cd ..

# Copy to Capacitor
npx cap copy android

# Open Android Studio
npx cap open android
```

In Android Studio:
1. Wait for Gradle sync to complete
2. Click **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
3. Wait for build to complete
4. APK location: `android/app/build/outputs/apk/debug/app-debug.apk`

---

## STEP 10: INSTALL & TEST

1. **Share APK to phone** (use any method from SHARE_APK_TO_PHONE.md)

2. **Install on phone**

3. **Open Thazema app**

4. **Test connection**:
   - Should show your Render URL
   - Connection should succeed ✅
   - Login should work
   - All features should work

5. **Test on mobile data**:
   - Turn OFF WiFi
   - Use mobile data
   - App should still work! ✅

---

## ✅ VERIFICATION CHECKLIST

- [ ] Code pushed to GitHub
- [ ] Render account created
- [ ] Web service created
- [ ] Environment variables added
- [ ] Deployment successful
- [ ] Public URL obtained
- [ ] URL tested in browser
- [ ] Mobile app updated with URL
- [ ] APK rebuilt
- [ ] APK installed on phone
- [ ] App connects successfully
- [ ] Works on mobile data

---

## 🎉 SUCCESS!

Your Thazema server is now:
- ✅ Live and public
- ✅ Accessible worldwide
- ✅ Works on mobile data
- ✅ Free forever
- ✅ Permanent URL

---

## 🔧 TROUBLESHOOTING

### Build Failed?

**Check logs in Render dashboard**:
- Look for error messages
- Common issues:
  - Missing dependencies
  - Wrong start command
  - Port configuration

**Solutions**:
1. Make sure `package.json` has `"start": "node server/index.js"`
2. Check all dependencies are in `package.json`
3. Verify environment variables are set

### Can't Connect from App?

1. **Test URL in browser first**:
   ```
   https://your-app.onrender.com/api/health
   ```

2. **Check you updated the correct file**:
   - File: `client/src/config/api.js`
   - Line: `PRODUCTION_URL: 'https://your-render-url.onrender.com'`
   - Line: `USE_PRODUCTION: true`

3. **Make sure you rebuilt APK**:
   - Run build commands again
   - Install NEW APK on phone

4. **Check server logs**:
   - Go to Render dashboard
   - Click on your service
   - Click "Logs" tab
   - Look for errors

### Server Sleeping?

Render free tier sleeps after 15 minutes of inactivity:
- First request takes 30-60 seconds to wake up
- Subsequent requests are fast
- This is normal for free tier

**Solution**: Upgrade to paid tier ($7/month) for always-on

---

## 📊 RENDER DASHBOARD

Access your dashboard: https://dashboard.render.com

From here you can:
- View logs
- Monitor performance
- Update environment variables
- Redeploy
- View metrics

---

## 🔄 UPDATING YOUR APP

When you make changes:

1. **Push to GitHub**:
   ```bash
   git add .
   git commit -m "Update description"
   git push
   ```

2. **Render auto-deploys**:
   - Detects changes automatically
   - Rebuilds and redeploys
   - Takes 5-10 minutes

3. **Manual deploy**:
   - Go to Render dashboard
   - Click "Manual Deploy"
   - Select branch
   - Click "Deploy"

---

## 💡 TIPS

### For Better Performance:
1. Enable "Auto-Deploy" (on by default)
2. Use environment variables for all secrets
3. Monitor logs regularly
4. Set up health checks

### For Production:
1. Use custom domain (optional)
2. Enable HTTPS (automatic)
3. Set up monitoring
4. Configure backups

---

## 📞 SUPPORT

**Administrator**: Abebe Mesfin  
**Phone**: +251 914 319 514  
**Email**: abebemesfin53@gmail.com

**Render Support**: https://render.com/docs

---

## 🎯 QUICK REFERENCE

### Your URLs:
- **Render Dashboard**: https://dashboard.render.com
- **Your App**: https://thazema.onrender.com
- **Health Check**: https://thazema.onrender.com/api/health

### Important Files:
- **Server**: `server/index.js`
- **Config**: `client/src/config/api.js`
- **Package**: `package.json`
- **Procfile**: `Procfile`

### Commands:
```bash
# Rebuild APK
cd client && npm run build && cd ..
npx cap copy android
npx cap open android

# Push updates
git add .
git commit -m "Update"
git push
```

---

**Your public server is now live!** 🚀🌍

**Next**: Install the new APK on your phone and test!
