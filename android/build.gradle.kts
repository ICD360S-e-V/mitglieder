allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Force Java 17 for all subprojects to fix deprecation warnings
    afterEvaluate {
        if (project.hasProperty("android")) {
            val android = project.extensions.getByName("android") as com.android.build.gradle.BaseExtension
            android.compileOptions {
                sourceCompatibility = JavaVersion.VERSION_17
                targetCompatibility = JavaVersion.VERSION_17
            }
            // Force every Android subproject up to the app's compileSdk. Some
            // plugins (e.g. flutter_ringtone_player, compiled against android-33)
            // otherwise fail checkReleaseAarMetadata against androidx libs
            // (fragment 1.7.1, window 1.2.0, activity 1.8.1) that require 34+.
            //
            // WARNING: this SETS the value, it does not merely raise it. A
            // plugin that asks for MORE than the number here is dragged back
            // down to it -- and that is exactly how the Android build of
            // v1.102.0 broke. permission_handler_android 14.1.0 declares
            // compileSdk 37 and uses Manifest.permission.ACCESS_LOCAL_NETWORK
            // and Build.VERSION_CODES.CINNAMON_BUN; pulled down to 36 neither
            // symbol exists and javac stops.
            //
            // Whoever touches this number next is probably looking at the
            // same failure. The durable fix is a floor instead of a fixed
            // value; until that exists, the number here has to follow the
            // highest compileSdk any plugin asks for.
            android.compileSdkVersion(37)
        }

        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
            compilerOptions {
                jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
