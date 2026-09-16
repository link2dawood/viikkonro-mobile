package fi.viikkonro.app.widget.shared

import android.content.Context

data class WidgetOptions(
    val city: String? = null,
    val countdownTarget: String = TARGET_HOLIDAY,
    val showEvents: Boolean = true,
    val dynamicColors: Boolean = false,
) {
    companion object {
        const val TARGET_HOLIDAY = "holiday"
        const val TARGET_FLAG_DAY = "flag"
    }
}

/**
 * Per-instance choices live in native preferences because the widgets must be
 * configurable and render while Flutter is not running. The legacy Flutter
 * city remains a fallback for widgets created before configuration existed.
 */
object WidgetPrefs {
    private const val FILE = "ViikkonroWidgetPreferences"
    private const val FLUTTER_FILE = "FlutterSharedPreferences"

    fun options(context: Context, appWidgetId: Int): WidgetOptions {
        val prefs = context.getSharedPreferences(FILE, Context.MODE_PRIVATE)
        val legacyCity = context.getSharedPreferences(FLUTTER_FILE, Context.MODE_PRIVATE)
            .getString("flutter.schoolCity", null)
            ?.takeIf { it.isNotBlank() }
        return WidgetOptions(
            city = prefs.getString(key(appWidgetId, "city"), null)?.takeIf { it.isNotBlank() } ?: legacyCity,
            countdownTarget = prefs.getString(key(appWidgetId, "countdownTarget"), null)
                ?: WidgetOptions.TARGET_HOLIDAY,
            showEvents = prefs.getBoolean(key(appWidgetId, "showEvents"), true),
            dynamicColors = prefs.getBoolean(key(appWidgetId, "dynamicColors"), false),
        )
    }

    fun save(context: Context, appWidgetId: Int, options: WidgetOptions) {
        context.getSharedPreferences(FILE, Context.MODE_PRIVATE).edit()
            .putString(key(appWidgetId, "city"), options.city)
            .putString(key(appWidgetId, "countdownTarget"), options.countdownTarget)
            .putBoolean(key(appWidgetId, "showEvents"), options.showEvents)
            .putBoolean(key(appWidgetId, "dynamicColors"), options.dynamicColors)
            .apply()
    }

    fun clear(context: Context, appWidgetId: Int) {
        val prefix = "widget.$appWidgetId."
        val prefs = context.getSharedPreferences(FILE, Context.MODE_PRIVATE)
        prefs.edit().also { editor ->
            prefs.all.keys.filter { it.startsWith(prefix) }.forEach(editor::remove)
        }.apply()
    }

    private fun key(appWidgetId: Int, name: String) = "widget.$appWidgetId.$name"
}
