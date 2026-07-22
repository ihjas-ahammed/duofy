# Flutter rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**

# Serious Python & CPython rules
-keep class com.seriouspython.** { *; }
-keepclassmembers class com.seriouspython.** { *; }
-dontwarn com.seriouspython.**
-keep class **.libpythonbundle { *; }
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Preserve reflection calls for ProcessEnvironment
-keepclassmembers class java.lang.ProcessEnvironment$Variable { *; }
-keepclassmembers class java.lang.ProcessEnvironment$Value { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}
