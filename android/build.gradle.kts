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
}

// ⚠️ flutter_ringtone_player übersetzt gegen android-33. Seine androidx-
// Abhängigkeiten (fragment 1.7.1, window 1.2.0, activity 1.8.1) verlangen
// 34+, sonst scheitert checkReleaseAarMetadata (#191) — unter AGP 9 ist das
// ein FEHLER. Deshalb hebt NUR dieses eine Plugin auf 37.
//
// ⚠️ Bis hierher stand an dieser Stelle ein afterEvaluate über ALLE
// Subprojekte (compileSdk 37, Java/Kotlin 17). Unter AGP 9 lässt so ein
// flächendeckender Eingriff Plugins ohne Klassen zurück (vorsitzer #553:
// file_picker, workmanager). Außerdem SETZTE er den Wert, statt ihn nur
// anzuheben — so brach v1.102.0 (permission_handler_android will 37). Jetzt
// behält jedes andere Plugin sein eigenes compileSdk.
//
// ⚠️ In `afterEvaluate` und VOR `evaluationDependsOn(":app")`: früher ist
// das Plugin noch nicht ausgewertet und setzt sein compileSdk danach selbst;
// später wirft Gradle „Cannot run Project.afterEvaluate when the project is
// already evaluated".
val pluginsMitZuAltemCompileSdk = setOf("flutter_ringtone_player")

subprojects {
    if (name in pluginsMitZuAltemCompileSdk) {
        afterEvaluate {
            extensions.findByType(com.android.build.gradle.LibraryExtension::class.java)
                ?.compileSdk = 37
        }
    }
}

// Wie im Flutter-Template: :app — und damit Flutters Gradle-Plugin — zuerst
// auswerten. Muss nach den afterEvaluate-Blöcken oben stehen. ⚠️ Nötig für
// android_file_picker (file_picker ≥ 12): es liest die Erweiterung `flutter`,
// die es erst gibt, wenn :app ausgewertet ist.
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
