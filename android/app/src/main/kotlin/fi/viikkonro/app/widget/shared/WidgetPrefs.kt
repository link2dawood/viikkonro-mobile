package fi.viikkonro.app.widget.shared

import android.content.Context

/**
 * The handful of user choices the widgets need. shared_preferences writes into
 * `FlutterSharedPreferences` with a `flutter.` prefix; reading it directly keeps
 * the widget independent of the engine while still following the app's setting.
 */
object WidgetPrefs {
    private const val FILE = "FlutterSharedPreferences"

    fun city(context: Context): String? =
        context.getSharedPreferences(FILE, Context.MODE_PRIVATE)
            .getString("flutter.schoolCity", null)
            ?.takeIf { it.isNotBlank() }
}
