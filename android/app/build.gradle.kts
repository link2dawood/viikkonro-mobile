plugins {
    id("com.android.application")
    id("kotlin-android")
    // Glance widgets are Compose; the widgets are the only Compose in the app.
    id("org.jetbrains.kotlin.plugin.compose")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "fi.viikkonro.app"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    buildFeatures {
        compose = true
    }

    defaultConfig {
        applicationId = "fi.viikkonro.app"
        minSdk = 24
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        debug {
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
        }
        release {
            // Configure production signing before distributing a release.
        }
    }

    sourceSets.getByName("test").resources.srcDir("../../test/fixtures")
    // The widget parser test reads the same bundled snapshot the widgets do.
    sourceSets.getByName("test").resources.srcDir("../../assets/data")
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    // Home screen widgets. These run with the Flutter engine dead, so nothing
    // here may reach into the Dart side or a Flutter-managed cache.
    implementation(platform("androidx.compose:compose-bom:2025.08.00"))
    implementation("androidx.glance:glance-appwidget:1.1.1")
    implementation("androidx.glance:glance-material3:1.1.1")
    implementation("androidx.work:work-runtime-ktx:2.10.2")
    testImplementation("junit:junit:4.13.2")
    testImplementation("org.json:json:20240303")
}

flutter {
    source = "../.."
}
