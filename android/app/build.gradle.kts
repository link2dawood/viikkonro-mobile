@file:Suppress("DEPRECATION")

import java.util.Properties
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    id("com.android.application")
    id("kotlin-android")
    // Glance widgets are Compose; the widgets are the only Compose in the app.
    id("org.jetbrains.kotlin.plugin.compose")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Firebase's project file is local-only in this public repository. Applying
// these plugins conditionally keeps a fresh clone buildable while enabling
// Analytics resources and Crashlytics symbol processing when configured.
val firebaseConfigFile = file("google-services.json")
val firebaseConfigured = firebaseConfigFile.exists()
if (firebaseConfigured) {
    apply(plugin = "com.google.gms.google-services")
    apply(plugin = "com.google.firebase.crashlytics")
}

// Release signing and AdMob credentials stay in the ignored key.properties.
// The conditional setup preserves debug builds in fresh public clones while
// release tasks fail explicitly below until production has been configured.
val signingPropertiesFile = rootProject.file("key.properties")
val signingProperties = Properties().apply {
    if (signingPropertiesFile.exists()) {
        signingPropertiesFile.inputStream().use { load(it) }
    }
}
val releaseSigningConfigured = signingPropertiesFile.exists() &&
    listOf("storePassword", "keyPassword", "keyAlias", "storeFile")
        .all { !signingProperties.getProperty(it).isNullOrBlank() }

// The official Google sample IDs keep a fresh clone safe for debug builds;
// release packaging is rejected until the local production IDs are supplied.
val sampleAdmobAppId = "ca-app-pub-3940256099942544~3347511713"
val sampleBannerAdUnitId = "ca-app-pub-3940256099942544/6300978111"
val admobPublisherId = signingProperties.getProperty("ADMOB_PUBLISHER_ID")
    ?.trim().orEmpty()
val releaseAdmobAppId = signingProperties.getProperty("ADMOB_ANDROID_APP_ID")
    ?.trim().orEmpty()
val releaseBannerAdUnitId = signingProperties
    .getProperty("ADMOB_ANDROID_BANNER_AD_UNIT_ID")?.trim().orEmpty()
val releaseAdmobConfigured = admobPublisherId.matches(Regex("pub-[0-9]{16}")) &&
    releaseAdmobAppId.matches(Regex("ca-app-${Regex.escape(admobPublisherId)}~[0-9]+")) &&
    releaseBannerAdUnitId.matches(Regex("ca-app-${Regex.escape(admobPublisherId)}/[0-9]+"))
fun buildConfigString(value: String) = "\"${value.replace("\\", "\\\\").replace("\"", "\\\"")}\""

android {
    namespace = "fi.viikkonro.app"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildFeatures {
        compose = true
        buildConfig = true
    }

    defaultConfig {
        applicationId = "fi.viikkonro.app"
        minSdk = 24
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // Use the real app identity when available so debug builds can test the
        // app's UMP message, while the banner itself remains Google's test unit.
        manifestPlaceholders["admobAppId"] = releaseAdmobAppId.ifEmpty { sampleAdmobAppId }
        buildConfigField("boolean", "FIREBASE_CONFIGURED", firebaseConfigured.toString())
    }

    signingConfigs {
        if (releaseSigningConfigured) {
            create("release") {
                keyAlias = signingProperties.getProperty("keyAlias")
                keyPassword = signingProperties.getProperty("keyPassword")
                storeFile = file(signingProperties.getProperty("storeFile"))
                storePassword = signingProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        debug {
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
            // Never send development traffic to the production ad unit.
            buildConfigField("String", "ADMOB_BANNER_AD_UNIT_ID", buildConfigString(sampleBannerAdUnitId))
        }
        release {
            if (releaseSigningConfigured) {
                signingConfig = signingConfigs.getByName("release")
            }
            // R8 removes unreachable bytecode and resources from distributed
            // builds. AGP 9 uses its integrated optimized resource shrinker.
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"))
            buildConfigField("String", "ADMOB_BANNER_AD_UNIT_ID", buildConfigString(releaseBannerAdUnitId))
        }
    }

    sourceSets.getByName("test").resources.srcDir("../../test/fixtures")
    // The widget parser test reads the same bundled snapshot the widgets do.
    sourceSets.getByName("test").resources.srcDir("../../assets/data")
    // Static picker previews are a compatibility contract for Android 7–11.
    sourceSets.getByName("test").resources.srcDir("src/main/res/drawable-nodpi")
}

// Do not accidentally package a release with Google's demo identity or with ads
// silently disabled. Debug/unit-test tasks continue to work in a fresh clone.
tasks.configureEach {
    if (name == "packageRelease" || name == "bundleRelease") {
        doFirst {
            check(releaseSigningConfigured) {
                "Release signing is missing: configure android/key.properties and its upload keystore"
            }
            check(releaseAdmobConfigured) {
                "Release AdMob IDs are missing, malformed, or belong to a different publisher; " +
                    "configure ADMOB_PUBLISHER_ID, ADMOB_ANDROID_APP_ID, and " +
                    "ADMOB_ANDROID_BANNER_AD_UNIT_ID in android/key.properties"
            }
        }
    }
}

// A distributed build must report to the intended Firebase project. Local
// debug builds intentionally remain available before console configuration.
tasks.configureEach {
    if (name == "packageRelease" || name == "bundleRelease") {
        doFirst {
            check(firebaseConfigured) {
                "Firebase config is missing: place google-services.json in android/app"
            }
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    // Supplies the modern decor-insets API used to make Android 15's enforced
    // edge-to-edge behavior consistent on every supported Android version.
    implementation("androidx.core:core-ktx:1.18.0")
    // Home screen widgets. These run with the Flutter engine dead, so nothing
    // here may reach into the Dart side or a Flutter-managed cache.
    implementation(platform("androidx.compose:compose-bom:2025.08.00"))
    implementation("androidx.glance:glance-appwidget:1.2.0")
    implementation("androidx.glance:glance-material3:1.2.0")
    implementation("androidx.work:work-runtime-ktx:2.10.2")
    testImplementation("junit:junit:4.13.2")
    testImplementation("org.json:json:20240303")
}

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
