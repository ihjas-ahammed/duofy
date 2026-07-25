// Ensure SERIOUS_PYTHON_SITE_PACKAGES dummy directory exists and serious_python_android uses it if env var is missing
run {
    val dummyDir = java.io.File(rootDir, "build/dummy_site_packages")
    val abis = listOf("arm64-v8a", "armeabi-v7a", "x86_64", "x86")
    for (abi in abis) {
        java.io.File(dummyDir, "$abi/opt").mkdirs()
    }
    val existingEnv = System.getenv("SERIOUS_PYTHON_SITE_PACKAGES")
    if (existingEnv.isNullOrBlank()) {
        try {
            val userHome = System.getProperty("user.home")
            val possiblePubCaches = listOfNotNull(
                System.getenv("PUB_CACHE")?.let { java.io.File(it, "hosted/pub.dev") },
                java.io.File(userHome, ".pub-cache/hosted/pub.dev"),
                java.io.File(userHome, "AppData/Local/Pub/Cache/hosted/pub.dev")
            )
            for (pubCacheDir in possiblePubCaches) {
                if (pubCacheDir.exists()) {
                    pubCacheDir.walk().filter { it.name == "build.gradle" && it.parentFile.name == "android" && it.parentFile.parentFile.name.startsWith("serious_python_android") }.forEach { gradleFile ->
                        val content = gradleFile.readText()
                        if (content.contains("throw new InvalidUserDataException(\"SERIOUS_PYTHON_SITE_PACKAGES environment variable is not set.\")")) {
                            val patchedContent = content.replace(
                                "throw new InvalidUserDataException(\"SERIOUS_PYTHON_SITE_PACKAGES environment variable is not set.\")",
                                "srcDir = \"\${rootProject.rootDir}/build/dummy_site_packages\""
                            )
                            gradleFile.writeText(patchedContent)
                        }
                    }
                }
            }
        } catch (_: Exception) {}
    }
}

pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version("4.3.15") apply false
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")
