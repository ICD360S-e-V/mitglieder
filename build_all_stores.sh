#!/bin/bash
# Build script for multiple Android app stores
# Usage: ./build_all_stores.sh
#
# Security: --obfuscate makes Dart code unreadable after decompilation
# Performance: --split-per-abi generates smaller APKs per architecture
# Debugging: --split-debug-info saves symbol maps for crash de-obfuscation

set -e  # Exit on error

FLUTTER="/Users/ionut-claudiuduinea/development/flutter/bin/flutter"
PROJECT_DIR="/Users/ionut-claudiuduinea/Documents/icd360sev_mitglieder_android"
OUTPUT_DIR="$PROJECT_DIR/build/releases"
SYMBOLS_DIR="$PROJECT_DIR/build/symbols"

# Obfuscation + debug symbols (common flags for all builds)
OBFUSCATE="--obfuscate --split-debug-info=$SYMBOLS_DIR"

cd "$PROJECT_DIR"

echo "🚀 Building ICD360S Mitglieder for 5 Android App Stores..."
echo "🔒 Obfuscation: ENABLED (Dart code unreadable after decompilation)"
echo "📦 Split per ABI: arm64-v8a only (smaller APKs)"
echo ""

# Create output directories
mkdir -p "$OUTPUT_DIR"
mkdir -p "$SYMBOLS_DIR"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
$FLUTTER clean
rm -rf build/
$FLUTTER pub get
echo "✅ Clean complete"
echo ""

# 1. F-DROID (FOSS - Primary distribution) - split-per-abi for smaller APK
echo "📦 Building for F-Droid (FOSS)..."
$FLUTTER build apk --release --flavor fdroid --target lib/main.dart \
  $OBFUSCATE --split-per-abi
cp build/app/outputs/flutter-apk/app-fdroid-arm64-v8a-release.apk "$OUTPUT_DIR/icd360sev-fdroid.apk"
echo "✅ F-Droid APK: $OUTPUT_DIR/icd360sev-fdroid.apk"
echo ""

# 2. GOOGLE PLAY (AAB preferred - Google handles ABI splitting)
echo "📦 Building for Google Play Store..."
$FLUTTER build appbundle --release --flavor googleplay --target lib/main.dart \
  $OBFUSCATE
$FLUTTER build apk --release --flavor googleplay --target lib/main.dart \
  $OBFUSCATE --split-per-abi
cp build/app/outputs/bundle/googleplayRelease/app-googleplay-release.aab "$OUTPUT_DIR/icd360sev-googleplay.aab"
cp build/app/outputs/flutter-apk/app-googleplay-arm64-v8a-release.apk "$OUTPUT_DIR/icd360sev-googleplay.apk"
echo "✅ Google Play AAB: $OUTPUT_DIR/icd360sev-googleplay.aab"
echo "✅ Google Play APK: $OUTPUT_DIR/icd360sev-googleplay.apk"
echo ""

# 3. AMAZON APPSTORE
echo "📦 Building for Amazon Appstore..."
$FLUTTER build apk --release --flavor amazon --target lib/main.dart \
  $OBFUSCATE --split-per-abi
cp build/app/outputs/flutter-apk/app-amazon-arm64-v8a-release.apk "$OUTPUT_DIR/icd360sev-amazon.apk"
echo "✅ Amazon APK: $OUTPUT_DIR/icd360sev-amazon.apk"
echo ""

# 4. HUAWEI APPGALLERY
echo "📦 Building for Huawei AppGallery..."
$FLUTTER build apk --release --flavor huawei --target lib/main.dart \
  $OBFUSCATE --split-per-abi
cp build/app/outputs/flutter-apk/app-huawei-arm64-v8a-release.apk "$OUTPUT_DIR/icd360sev-huawei.apk"
echo "✅ Huawei APK: $OUTPUT_DIR/icd360sev-huawei.apk"
echo ""

# 5. SAMSUNG GALAXY STORE
echo "📦 Building for Samsung Galaxy Store..."
$FLUTTER build apk --release --flavor samsung --target lib/main.dart \
  $OBFUSCATE --split-per-abi
cp build/app/outputs/flutter-apk/app-samsung-arm64-v8a-release.apk "$OUTPUT_DIR/icd360sev-samsung.apk"
echo "✅ Samsung APK: $OUTPUT_DIR/icd360sev-samsung.apk"
echo ""

# Save symbols for this release
VERSION=$(grep 'version:' pubspec.yaml | head -1 | awk '{print $2}' | cut -d'+' -f1)
SYMBOLS_ARCHIVE="$PROJECT_DIR/build/symbols_v${VERSION}"
cp -r "$SYMBOLS_DIR" "$SYMBOLS_ARCHIVE" 2>/dev/null || true
echo "🔍 Debug symbols saved: $SYMBOLS_ARCHIVE"
echo "   (Use: flutter symbolize -i crash.txt -d $SYMBOLS_ARCHIVE/)"
echo ""

# Summary
echo "🎉 BUILD COMPLETE! All 5 app stores ready:"
echo ""
echo "📱 F-DROID (Primary - FOSS):"
echo "   → $OUTPUT_DIR/icd360sev-fdroid.apk"
echo ""
echo "📱 GOOGLE PLAY:"
echo "   → $OUTPUT_DIR/icd360sev-googleplay.aab (Android App Bundle - preferred)"
echo "   → $OUTPUT_DIR/icd360sev-googleplay.apk (APK - fallback)"
echo ""
echo "📱 AMAZON APPSTORE:"
echo "   → $OUTPUT_DIR/icd360sev-amazon.apk"
echo ""
echo "📱 HUAWEI APPGALLERY:"
echo "   → $OUTPUT_DIR/icd360sev-huawei.apk"
echo ""
echo "📱 SAMSUNG GALAXY STORE:"
echo "   → $OUTPUT_DIR/icd360sev-samsung.apk"
echo ""
echo "📊 Total builds: 6 files (1 AAB + 5 APK)"
echo "🔒 Dart obfuscation: ENABLED (code unreadable after decompilation)"
echo "📦 ABI: arm64-v8a only (~50MB instead of ~98MB)"
echo "🔍 Debug symbols: $SYMBOLS_ARCHIVE/"
echo "✅ Ready for upload to all stores!"
