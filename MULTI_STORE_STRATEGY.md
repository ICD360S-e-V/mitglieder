# 🏪 MULTI-STORE STRATEGY - Dependencies per Flavor

## Strategii de Configurare

### STRATEGY 1: Universal APK (CURRENT) ✅

**Un singur cod pentru toate magazinele**

```yaml
# pubspec.yaml (CURRENT)
dependencies:
  # No Google Services
  # No Huawei Services
  # Backend propriu pentru totul
```

**Avantaje:**
- ✅ Simplitate maximă
- ✅ Maintenance ușor (un singur codebase)
- ✅ Funcționează pe TOATE magazinele
- ✅ F-Droid compatible

**Dezavantaje:**
- ⚠️ Nu folosim features native (Google Maps, HMS Push)
- ⚠️ Experience suboptimal pe anumite platforme

**Când să folosești:**
- ✅ App backend-driven (ca al nostru!)
- ✅ Vrei simplitate
- ✅ F-Droid este priority

---

### STRATEGY 2: Optimized per Store (ADVANCED) 🎯

**Dependencies diferite per flavor**

#### pubspec.yaml Configuration:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Common dependencies (toate flavors)
  http: ^1.2.0
  shared_preferences: ^2.3.0
  flutter_secure_storage: ^10.0.0

  # Conditional dependencies (doar anumite flavors)
  # Se activează prin environment variables

# Separate dependency files per flavor
dependency_overrides:
  # Managed via flavor-specific imports
```

#### Flavor-Specific Dependencies:

**F-Droid flavor:**
```yaml
# lib/config/fdroid_dependencies.dart
// No Google Services
// No proprietary libraries
// FOSS only!
```

**Google Play flavor:**
```yaml
# lib/config/googleplay_dependencies.dart
dependencies:
  google_maps_flutter: ^2.5.0
  firebase_messaging: ^14.7.0
  firebase_analytics: ^10.8.0
  google_sign_in: ^6.1.5
```

**Huawei flavor:**
```yaml
# lib/config/huawei_dependencies.dart
dependencies:
  huawei_map: ^6.10.0+300        # Huawei Maps
  huawei_push: ^6.10.0+300       # Push Kit
  huawei_account: ^6.10.0+300    # Account Kit
```

**Amazon flavor:**
```yaml
# lib/config/amazon_dependencies.dart
dependencies:
  # Amazon IAP, ADM (Amazon Device Messaging)
```

**Samsung flavor:**
```yaml
# lib/config/samsung_dependencies.dart
dependencies:
  # Samsung Pay, Samsung Pass (optional)
```

---

## 🔧 Implementation Methods

### Method 1: Environment Variables (Simple)

```dart
// lib/config/app_config.dart
class AppConfig {
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'fdroid',
  );

  static bool get isGooglePlay => flavor == 'googleplay';
  static bool get isFDroid => flavor == 'fdroid';
  static bool get isHuawei => flavor == 'huawei';
  static bool get isAmazon => flavor == 'amazon';
  static bool get isSamsung => flavor == 'samsung';

  // Feature flags per store
  static bool get useGoogleMaps => isGooglePlay || isSamsung;
  static bool get useHuaweiMaps => isHuawei;
  static bool get useFirebase => isGooglePlay;
  static bool get useHMS => isHuawei;
}
```

**Build command:**
```bash
flutter build apk --release --flavor googleplay --dart-define=FLAVOR=googleplay
```

### Method 2: Separate Entry Points

```
lib/
├── main.dart              # Common
├── main_fdroid.dart       # F-Droid entry
├── main_googleplay.dart   # Google Play entry
├── main_huawei.dart       # Huawei entry
├── main_amazon.dart       # Amazon entry
└── main_samsung.dart      # Samsung entry
```

**Build command:**
```bash
flutter build apk --release --flavor fdroid --target lib/main_fdroid.dart
```

### Method 3: Conditional Imports (Recommended)

```dart
// lib/services/maps_service.dart
import 'package:flutter/foundation.dart';

// Conditional imports based on flavor
import 'maps/google_maps_impl.dart' if (dart.library.js) 'maps/web_maps_impl.dart';
import 'maps/huawei_maps_impl.dart' if (const bool.fromEnvironment('HUAWEI')) 'maps/fallback_maps.dart';
import 'maps/osm_maps_impl.dart' if (const bool.fromEnvironment('FDROID')) 'maps/osm_maps_impl.dart';

abstract class MapsService {
  factory MapsService() {
    if (AppConfig.isHuawei) return HuaweiMapsImpl();
    if (AppConfig.isGooglePlay) return GoogleMapsImpl();
    return OSMMapsImpl(); // F-Droid, Amazon, Samsung fallback
  }
}
```

---

## 📊 Comparison Table

| Feature | F-Droid | Google Play | Huawei | Amazon | Samsung |
|---------|---------|-------------|--------|--------|---------|
| **Google Services** | ❌ Banned | ✅ Optional | ❌ Not available | ❌ Not on Fire | ✅ Optional |
| **HMS** | ⚠️ Allowed | ⚠️ Allowed | ✅ Recommended | ⚠️ Allowed | ⚠️ Allowed |
| **Custom Backend** | ✅ Required | ✅ Allowed | ✅ Allowed | ✅ Allowed | ✅ Allowed |
| **Proprietary Libs** | ❌ Banned | ✅ Allowed | ✅ Allowed | ✅ Allowed | ✅ Allowed |
| **Analytics** | FOSS only | ✅ Any | ✅ Huawei | ✅ Amazon | ✅ Any |
| **Maps** | OSM only | ✅ Google | ✅ Huawei | ✅ Amazon | ✅ Google |
| **Push** | Local only | ✅ FCM | ✅ Push Kit | ✅ ADM | ✅ FCM |
| **IAP** | ❌ None | ✅ Play Billing | ✅ IAP | ✅ Amazon IAP | ✅ Galaxy IAP |

---

## 🎯 OUR APP - Current Status

### What We Use NOW:
```
✅ Custom backend (icd360sev.icd360s.de)
✅ WebSocket propriu (wss://)
✅ Local notifications (flutter_local_notifications)
✅ APK download pentru updates
✅ No Google Services
✅ No Huawei Services
✅ No third-party analytics
```

### Compatibility:
```
✅ F-Droid: PERFECT (no proprietary dependencies)
✅ Google Play: WORKS (Google Services optional!)
✅ Huawei: PERFECT (works without GMS)
✅ Amazon: PERFECT (Fire OS compatible)
✅ Samsung: WORKS (no extras needed)
```

**Concluzie:** 🎉 **ACELAȘI APK FUNCȚIONEAZĂ PE TOATE MAGAZINELE!**

---

## 🔧 WHEN to Add Store-Specific Features

### Scenario 1: Need Google Maps
```dart
// Only for googleplay and samsung flavors
dependencies:
  google_maps_flutter:
    # Only included in googleplay/samsung builds
```

### Scenario 2: Need Push Notifications (Better)
```dart
// googleplay → Firebase Cloud Messaging
// huawei → Huawei Push Kit
// fdroid → Local notifications only
// amazon → Amazon Device Messaging
// samsung → Firebase Cloud Messaging
```

### Scenario 3: Need In-App Purchases
```dart
// googleplay → Google Play Billing
// huawei → Huawei IAP
// amazon → Amazon IAP
// samsung → Galaxy Store IAP
// fdroid → Not applicable (FOSS)
```

---

## 🎯 RECOMMENDATION FOR OUR APP

### ✅ **KEEP CURRENT STRATEGY (Option 1)**

**Why:**
1. ✅ **Simplicity** - Un singur codebase
2. ✅ **F-Droid compatible** - Cel mai restrictiv magazin
3. ✅ **Works everywhere** - Backend propriu
4. ✅ **Easy maintenance** - No conditional code
5. ✅ **No vendor lock-in** - Independent de Google/Huawei

**What this means:**
- Același cod Dart pentru toate flavors
- Diferă doar: applicationId, versionName suffix
- ProGuard rules identice
- Permissions identice
- Features identice

### Example Build Output:

```
app-fdroid-release.apk       (87 MB)
├── Code: Identic cu restul
├── Dependencies: flutter_local_notifications, http, websocket
├── Google Services: ❌ None
└── HMS: ❌ None

app-googleplay-release.apk  (87 MB)
├── Code: Identic cu fdroid
├── Dependencies: Identice
├── Google Services: ❌ None (opțional - nu le folosim)
└── Difference: Application ID suffix only

app-huawei-release.apk      (87 MB)
├── Code: Identic
├── Dependencies: Identice
├── HMS: ❌ None (opțional - nu le folosim)
└── Difference: Application ID suffix only
```

---

Vrei să:
1. ✅ **Păstrăm strategia curentă** (un singur cod, funcționează peste tot)?
2. 🔧 **Adăugăm Google Services** pentru Google Play flavor (cod condiționat)?

Recomand **Opțiunea 1** pentru simplitate și compatibilitate maximă!