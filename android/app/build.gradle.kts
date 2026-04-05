plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "de.icd360s.mitglieder"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    // Build flavors for different app stores
    flavorDimensions += "store"
    productFlavors {
        create("googleplay") {
            dimension = "store"
            applicationIdSuffix = ".googleplay"
            versionNameSuffix = "-gp"
            // Google Play specific config
        }
        create("fdroid") {
            dimension = "store"
            // F-Droid: No suffix, use base applicationId
            // F-Droid: FOSS only, no Google Services
        }
        create("amazon") {
            dimension = "store"
            applicationIdSuffix = ".amazon"
            versionNameSuffix = "-amz"
            // Amazon Appstore specific
        }
        create("huawei") {
            dimension = "store"
            applicationIdSuffix = ".huawei"
            versionNameSuffix = "-huawei"
            // Huawei AppGallery specific (HMS instead of GMS)
        }
        create("samsung") {
            dimension = "store"
            applicationIdSuffix = ".samsung"
            versionNameSuffix = "-galaxy"
            // Samsung Galaxy Store specific
        }
    }

    signingConfigs {
        create("release") {
            val keystorePath = System.getenv("KEYSTORE_PATH") ?: "release-keystore.jks"
            storeFile = file(keystorePath)
            storePassword = System.getenv("KEYSTORE_PASSWORD") ?: ""
            keyAlias = System.getenv("KEY_ALIAS") ?: "release"
            keyPassword = System.getenv("KEY_PASSWORD") ?: ""
        }
    }

    defaultConfig {
        applicationId = "de.icd360s.mitglieder"
        minSdk = flutter.minSdkVersion  // Android 6.0+ (Flutter minimum)
        targetSdk = 36  // Android 15
        versionCode = 111
        versionName = "1.1.15"

        // ABI filtering handled by Flutter --split-per-abi flag
        // Do NOT set ndk.abiFilters here (conflicts with split-per-abi)
    }

    buildTypes {
        release {
            // Security: Code obfuscation and shrinking enabled
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // Use release keystore if available (CI), otherwise debug
            signingConfig = if (file("release-keystore.jks").exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

flutter {
    source = "../.."
}
