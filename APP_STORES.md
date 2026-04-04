# 📱 ANDROID APP STORES - CONFIGURATION & DISTRIBUTION

## Supported App Stores (5 Total)

### 1. 🟢 **F-Droid** (PRIMARY - RECOMMENDED)
**URL:** https://f-droid.org
**Custom Repo:** https://icd360sev.icd360s.de/fdroid/repo
**Users:** FOSS community
**Format:** APK only
**Requirements:**
- ✅ Must be Free and Open Source Software
- ✅ No Google Play Services
- ✅ Reproducible builds (optional but recommended)
- ✅ Signed by F-Droid or developer key

**Build Flavor:** `fdroid`

**Build Command:**
```bash
flutter build apk --release --flavor fdroid
# Output: build/app/outputs/flutter-apk/app-fdroid-release.apk
```

**Advantages:**
- ✅ Privacy-focused users
- ✅ No tracking or ads
- ✅ Auto-updates via F-Droid client
- ✅ Trusted by security-conscious users

---

### 2. 🔵 **Google Play Store**
**URL:** https://play.google.com/console
**Users:** 2.5+ billion devices worldwide
**Format:** AAB (preferred) or APK
**Requirements:**
- ✅ Google Play Services allowed
- ✅ App signing by Google (recommended)
- ✅ 64-bit support required
- ✅ TargetSdk 34+ (Android 14+)
- ⚠️ 30% commission on in-app purchases

**Build Flavor:** `googleplay`

**Build Commands:**
```bash
# AAB (Android App Bundle) - RECOMMENDED by Google
flutter build appbundle --release --flavor googleplay
# Output: build/app/outputs/bundle/googleplayRelease/app-googleplay-release.aab

# APK (fallback)
flutter build apk --release --flavor googleplay
# Output: build/app/outputs/flutter-apk/app-googleplay-release.apk
```

**Advantages:**
- ✅ Largest user base (2.5B)
- ✅ Best discoverability
- ✅ Automatic updates
- ✅ In-app billing infrastructure

---

### 3. 🟠 **Amazon Appstore**
**URL:** https://developer.amazon.com
**Users:** 500M+ (Fire devices + Android)
**Format:** APK or AAB
**Requirements:**
- ✅ Works on Fire tablets/TV
- ✅ No Google dependencies (Fire OS = Android fork)
- ✅ Amazon In-App Purchasing API (optional)
- ✅ Free submission (no developer fee)

**Build Flavor:** `amazon`

**Build Command:**
```bash
flutter build apk --release --flavor amazon
# Output: build/app/outputs/flutter-apk/app-amazon-release.apk
```

**Advantages:**
- ✅ Access to Fire device market
- ✅ No annual developer fee
- ✅ Amazon's promotion (if featured)

---

### 4. 🔴 **Huawei AppGallery**
**URL:** https://appgallery.huawei.com
**Users:** 580M+ users, 170 countries (3rd largest!)
**Format:** APK
**Requirements:**
- ✅ HMS (Huawei Mobile Services) instead of GMS
- ✅ No Google Play Services
- ✅ Mandatory for Huawei devices (no Google Play)
- ✅ Strong presence in China, Europe, Middle East

**Build Flavor:** `huawei`

**Build Command:**
```bash
flutter build apk --release --flavor huawei
# Output: build/app/outputs/flutter-apk/app-huawei-release.apk
```

**Advantages:**
- ✅ **580 million users** (huge market!)
- ✅ Strong in regions where Google is limited
- ✅ Lower competition than Google Play
- ✅ Free developer account

---

### 5. 🟣 **Samsung Galaxy Store**
**URL:** https://seller.samsungapps.com
**Users:** Pre-installed on Samsung devices (180 countries)
**Format:** APK
**Requirements:**
- ✅ Optimized for Samsung devices
- ✅ Samsung-specific features (optional)
- ✅ Quality guidelines enforced
- ✅ Available in 180 countries

**Build Flavor:** `samsung`

**Build Command:**
```bash
flutter build apk --release --flavor samsung
# Output: build/app/outputs/flutter-apk/app-samsung-release.apk
```

**Advantages:**
- ✅ Pre-installed on Samsung devices
- ✅ High-quality app curation
- ✅ Samsung promotion opportunities
- ✅ Direct access to Galaxy users

---

## 🛠️ **BUILD ALL STORES - ONE COMMAND**

### Quick Build Script

```bash
# Make script executable (first time only)
chmod +x build_all_stores.sh

# Build for all 5 stores
./build_all_stores.sh
```

**Output:** 6 files in `build/releases/`
- `icd360sev-fdroid.apk` (F-Droid)
- `icd360sev-googleplay.aab` (Google Play - primary)
- `icd360sev-googleplay.apk` (Google Play - fallback)
- `icd360sev-amazon.apk` (Amazon)
- `icd360sev-huawei.apk` (Huawei)
- `icd360sev-samsung.apk` (Samsung)

---

## 📊 **COMPARISON TABLE**

| Store | Users | Format | Fee | Commission | Review Time | Best For |
|-------|-------|--------|-----|------------|-------------|----------|
| **F-Droid** | FOSS community | APK | Free | 0% | 1-7 days | Privacy users |
| **Google Play** | 2.5B+ | AAB/APK | $25 once | 15-30% | 1-7 days | Mass market |
| **Amazon** | 500M+ | APK | Free | 20% | 1-3 days | Fire devices |
| **Huawei** | 580M+ | APK | Free | 15% | 3-5 days | China/EU/ME |
| **Samsung** | Samsung users | APK | Free | 0% | 3-7 days | Galaxy users |

---

## 🎯 **DISTRIBUTION STRATEGY**

### **Recommended Priority:**

1. **F-Droid** (PRIMARY) - Already configured!
   - Custom repo: https://icd360sev.icd360s.de/fdroid/repo
   - Auto-updates working
   - Privacy-focused distribution

2. **Google Play** (SECONDARY) - Largest reach
   - 2.5 billion potential users
   - Best discoverability

3. **Huawei AppGallery** (TERTIARY) - Growing market
   - 580M users (3rd largest!)
   - Strong in EU/Asia

4. **Samsung Galaxy Store** (OPTIONAL) - Samsung ecosystem
   - Pre-installed on devices
   - Good for brand visibility

5. **Amazon Appstore** (OPTIONAL) - Fire devices
   - Niche but dedicated users

---

## 🔧 **FLAVOR DIFFERENCES**

### **Application IDs:**
```
fdroid:      de.icd360s.mitglieder               (base)
googleplay:  de.icd360s.mitglieder.googleplay    (+suffix)
amazon:      de.icd360s.mitglieder.amazon        (+suffix)
huawei:      de.icd360s.mitglieder.huawei        (+suffix)
samsung:     de.icd360s.mitglieder.samsung       (+suffix)
```

### **Version Names:**
```
fdroid:      1.0.86
googleplay:  1.0.86-gp
amazon:      1.0.86-amz
huawei:      1.0.86-huawei
samsung:     1.0.86-galaxy
```

**De ce ID-uri diferite?**
- Utilizatorii pot instala din **multiple stores** simultan
- Fiecare build are tracking separat
- No conflicts între instalări

---

## 📋 **UPLOAD CHECKLIST**

### Per Store:

**F-Droid:**
- [x] Configurare deja activă
- [x] Repository la https://icd360sev.icd360s.de/fdroid/repo
- [ ] Upload APK → `fdroid update`

**Google Play:**
- [ ] Developer account ($25 one-time)
- [ ] Upload AAB (preferred) sau APK
- [ ] App listing (screenshots, description)
- [ ] Privacy policy URL
- [ ] Content rating questionnaire

**Amazon:**
- [ ] Developer account (free)
- [ ] Upload APK
- [ ] Amazon Device Targeting
- [ ] Screenshots for Fire devices

**Huawei:**
- [ ] Developer account (free)
- [ ] Upload APK
- [ ] App listing (Chinese + English)
- [ ] HMS integration testing (optional)

**Samsung:**
- [ ] Seller Office account
- [ ] Upload APK
- [ ] Galaxy device optimization
- [ ] Quality check (strict)

---

## 🚀 **QUICK START**

### Build all stores:
```bash
./build_all_stores.sh
```

### Build individual store:
```bash
# F-Droid only
flutter build apk --release --flavor fdroid

# Google Play only (AAB)
flutter build appbundle --release --flavor googleplay

# Amazon only
flutter build apk --release --flavor amazon

# Huawei only
flutter build apk --release --flavor huawei

# Samsung only
flutter build apk --release --flavor samsung
```

---

## 📈 **MARKET REACH**

**Total potential users:** 3.5+ billion devices

**Distribution breakdown:**
- F-Droid: Security-focused community
- Google Play: 2.5B+ (71% global market share)
- Huawei: 580M+ (16% - 3rd largest!)
- Amazon: 500M+ (Fire ecosystem)
- Samsung: 100M+ active Galaxy users

**Geographic coverage:**
- 🌍 Global: Google Play, F-Droid
- 🇨🇳 China: Huawei AppGallery (Google blocked)
- 🇪🇺 Europe: All stores
- 🌎 Americas: Google Play, Amazon
- 🌏 Asia: Huawei, Samsung

---

**Status:** ✅ **READY FOR MULTI-STORE DEPLOYMENT!**

**Sources:**
- [Top Android App Stores 2026](https://www.mobiloud.com/blog/list-of-mobile-app-stores)
- [Flutter Build Flavors](https://docs.flutter.dev/deployment/flavors)
- [F-Droid Reproducible Builds](https://f-droid.org/en/docs/Reproducible_Builds/)
