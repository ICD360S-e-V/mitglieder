# Flutter ProGuard Rules
# Keep Flutter classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep WebRTC
-keep class org.webrtc.** { *; }

# Keep notification classes
-keep class com.dexterous.** { *; }

# Keep background service
-keep class id.flutter.flutter_background_service.** { *; }

# Keep secure storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# Preserve annotations
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Dart VM Service Protocol
-keep class dev.flutter.** { *; }

# Ignore Google Play Core warnings (we don't use it but Flutter references it)
-dontwarn com.google.android.play.core.**
-dontnote com.google.android.play.core.**

# Keep Flutter Play Store classes (even though empty implementations)
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
