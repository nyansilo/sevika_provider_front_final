import groovy.json.JsonSlurper

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    //id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.sevika.sevika_pro"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // 🎯 ADD THIS BLOCK: Tell Android it is allowed to generate our Facebook strings
    buildFeatures {
        resValues = true
    }

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        // 🎯 FIXED: Aligned Java version with Kotlin (17)
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

  defaultConfig {
    applicationId = "com.sevika.sevika_pro"
    minSdk = flutter.minSdkVersion
    targetSdk = flutter.targetSdkVersion
    versionCode = flutter.versionCode
    versionName = flutter.versionName

    // --- AUTO-INJECT secret.env.json WITH SAFE FALLBACKS ---
    val configFile = rootProject.file("../secret.env.json")
    val parsed = if (configFile.exists()) {
        @Suppress("UNCHECKED_CAST")
        groovy.json.JsonSlurper().parse(configFile) as Map<String, *>
    } else {
        emptyMap<String, Any?>()
    }

    // 1. Manifest Placeholders (Maps & General)
    manifestPlaceholders["MAPS_API_KEY_ANDROID"] = parsed["MAPS_API_KEY_ANDROID"]?.toString() ?: ""
    manifestPlaceholders.putAll(parsed.mapValues { it.value.toString() })

    // 2. Facebook String Resources (Always generated so AAPT never fails)
    val fbAppId = parsed["FACEBOOK_APP_ID"]?.toString() ?: "0"
    val fbClientToken = parsed["FACEBOOK_CLIENT_TOKEN"]?.toString() ?: "0"
    val fbScheme = parsed["FACEBOOK_URL_SCHEME"]?.toString() ?: "fb0"

    resValue("string", "facebook_app_id", fbAppId)
    resValue("string", "facebook_client_token", fbClientToken)
    resValue("string", "facebook_login_protocol_scheme", fbScheme)
}

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
  // 🎯 Correctly formatted for Kotlin DSL
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}