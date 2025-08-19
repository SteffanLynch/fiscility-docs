# Production Deployment Checklists - Personal Finance Analytics App

---

## Checklist 1: Initial Production Setup (One-Time)

### 🔧 Core Environment Setup
- [ ] Configure environment variables in hosting platform (Vercel/Netlify dashboard)
- [ ] Set `NODE_ENV=production` in hosting environment
- [ ] Set up production domain and SSL certificate
- [ ] Test application loads on production domain

### 🔐 Security Essentials
- [ ] Update OAuth redirect URIs to production domain
- [ ] Configure CORS for production domain
- [ ] Set strong session secrets
- [ ] Enable HTTPS redirects

### 📊 Basic Monitoring
- [ ] Set up error tracking (**Sentry** - free tier, or **LogRocket**)
- [ ] Configure uptime monitoring (**UptimeRobot** - free tier, or **Pingdom**)
- [ ] Set up email alerts for critical errors

### ✅ Production Smoke Test
- [ ] Application loads without errors
- [ ] User can register/login
- [ ] Plaid bank connection works
- [ ] Database queries execute properly
- [ ] No console errors in browser

---

## Checklist 2: Regular Deployment (Every Push)

### 🧪 Pre-Deploy Testing
- [ ] All tests pass in staging
- [ ] Manual test of changed features
- [ ] No console errors in staging
- [ ] Production build creates successfully (`npm run build`)

### 🚀 Deploy & Verify
- [ ] Deploy to production
- [ ] Application loads on production URL
- [ ] Login/authentication works
- [ ] Database connections stable
- [ ] Plaid integration functioning
- [ ] No new errors in monitoring dashboard

### 🔄 Housekeeping
- [ ] Tag release in Git
- [ ] Check error monitoring for 15 minutes post-deploy
- [ ] Remove any debug code or console.logs

---

## 🚨 Non-Negotiables

**Must Have Before Going Live:**
1. **SSL certificate** configured and working
2. **Error monitoring** set up (you need to know when things break)
3. **Environment variables** properly configured in hosting platform
4. **OAuth redirects** updated for production domain
5. **Database backups** enabled (if not automatic in Supabase)

**Strong Recommendations:**
1. **Uptime monitoring** - know immediately when site goes down
2. **Git tagging** - track what version is in production
3. **Manual smoke test** after every deployment
4. **Keep staging environment** for testing before production pushes