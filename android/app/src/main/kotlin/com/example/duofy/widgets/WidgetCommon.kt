package com.example.duofy.widgets

import android.app.PendingIntent
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import com.example.duofy.MainActivity

object WidgetCommon {
    const val PREFS_NAME = "HomeWidgetPreferences"

    fun prefs(context: Context): SharedPreferences =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    fun getSafeInt(prefs: SharedPreferences, key: String, defaultVal: Int): Int {
        val value = prefs.all[key] ?: return defaultVal
        return when (value) {
            is Int -> value
            is Long -> value.toInt()
            is Number -> value.toInt()
            is String -> value.toIntOrNull() ?: defaultVal
            else -> defaultVal
        }
    }

    fun getSafeBoolean(prefs: SharedPreferences, key: String, defaultVal: Boolean): Boolean {
        val value = prefs.all[key] ?: return defaultVal
        return when (value) {
            is Boolean -> value
            is String -> value.toBoolean()
            is Number -> value.toInt() != 0
            else -> defaultVal
        }
    }

    fun getSafeString(prefs: SharedPreferences, key: String, defaultVal: String): String {
        val value = prefs.all[key] ?: return defaultVal
        return value.toString()
    }

    fun launchIntent(context: Context, action: String): PendingIntent {
        val uri = Uri.parse("duofy://widget?action=$action")
        return HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java,
            uri,
        )
    }
}
