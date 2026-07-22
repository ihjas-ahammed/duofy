// Ensure SERIOUS_PYTHON_SITE_PACKAGES environment variable is populated so serious_python_android build succeeds
run {
    val existingEnv = System.getenv("SERIOUS_PYTHON_SITE_PACKAGES")
    if (existingEnv.isNullOrBlank()) {
        val dummyDir = java.io.File(rootDir, "build/dummy_site_packages")
        val abis = listOf("arm64-v8a", "armeabi-v7a", "x86_64", "x86")
        for (abi in abis) {
            java.io.File(dummyDir, "$abi/opt").mkdirs()
        }
        val targetPath = dummyDir.absolutePath
        try {
            val processEnvironmentClass = Class.forName("java.lang.ProcessEnvironment")
            val theEnvironmentField = processEnvironmentClass.getDeclaredField("theEnvironment")
            theEnvironmentField.isAccessible = true
            val env = theEnvironmentField.get(null) as MutableMap<String, String>
            env["SERIOUS_PYTHON_SITE_PACKAGES"] = targetPath

            val theCaseInsensitiveEnvironmentField = processEnvironmentClass.getDeclaredField("theCaseInsensitiveEnvironment")
            theCaseInsensitiveEnvironmentField.isAccessible = true
            val cienv = theCaseInsensitiveEnvironmentField.get(null) as MutableMap<String, String>
            cienv["SERIOUS_PYTHON_SITE_PACKAGES"] = targetPath
        } catch (_: Exception) {
            try {
                val envMap = System.getenv()
                val field = envMap.javaClass.getDeclaredField("m")
                field.isAccessible = true
                val map = field.get(envMap) as MutableMap<String, String>
                map["SERIOUS_PYTHON_SITE_PACKAGES"] = targetPath
            } catch (_: Exception) {}
        }
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
