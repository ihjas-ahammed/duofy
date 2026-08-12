package com.example.duofy.widgets

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import es.antonborri.home_widget.HomeWidgetProvider
import com.example.duofy.R

class StreakWidget : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        for (id in appWidgetIds) {
            render(context, appWidgetManager, id, widgetData)
        }
    }

    private fun render(context: Context, mgr: AppWidgetManager, widgetId: Int, prefs: SharedPreferences) {
        val views = RemoteViews(context.packageName, R.layout.widget_streak)

        val streakCount = WidgetCommon.getSafeInt(prefs, "duofy.streak.count", 0)
        views.setTextViewText(
            R.id.widget_streak_count,
            if (streakCount == 1) "1 Day" else "$streakCount Days"
        )

        // 7-day week pips (Mon - Sun)
        val dayPipIds = intArrayOf(
            R.id.widget_streak_pip_0,
            R.id.widget_streak_pip_1,
            R.id.widget_streak_pip_2,
            R.id.widget_streak_pip_3,
            R.id.widget_streak_pip_4,
            R.id.widget_streak_pip_5,
            R.id.widget_streak_pip_6,
        )
        val dayTextIds = intArrayOf(
            R.id.widget_streak_day_0,
            R.id.widget_streak_day_1,
            R.id.widget_streak_day_2,
            R.id.widget_streak_day_3,
            R.id.widget_streak_day_4,
            R.id.widget_streak_day_5,
            R.id.widget_streak_day_6,
        )

        val defaultDays = arrayOf("M", "T", "W", "T", "F", "S", "S")

        for (i in 0..6) {
            val isActive = WidgetCommon.getSafeBoolean(prefs, "duofy.streak.day$i.active", false)
            val isToday = WidgetCommon.getSafeBoolean(prefs, "duofy.streak.day$i.today", false)
            val dayName = WidgetCommon.getSafeString(prefs, "duofy.streak.day$i.name", defaultDays[i])

            views.setTextViewText(dayTextIds[i], dayName)
            if (isActive) {
                views.setInt(dayPipIds[i], "setBackgroundResource", R.drawable.widget_pip_streak_on)
                views.setTextColor(dayTextIds[i], ContextCompat.getColor(context, R.color.widget_accent_orange))
            } else if (isToday) {
                views.setInt(dayPipIds[i], "setBackgroundResource", R.drawable.widget_pip_streak_today)
                views.setTextColor(dayTextIds[i], ContextCompat.getColor(context, R.color.widget_accent_blue))
            } else {
                views.setInt(dayPipIds[i], "setBackgroundResource", R.drawable.widget_pip_streak_off)
                views.setTextColor(dayTextIds[i], ContextCompat.getColor(context, R.color.widget_text_muted))
            }
        }

        views.setOnClickPendingIntent(
            R.id.widget_streak_root,
            WidgetCommon.launchIntent(context, "open_app"),
        )

        mgr.updateAppWidget(widgetId, views)
    }
}
