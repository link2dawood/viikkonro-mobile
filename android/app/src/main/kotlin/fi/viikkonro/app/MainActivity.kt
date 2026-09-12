package fi.viikkonro.app

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import fi.viikkonro.app.widget.ROUTE_EXTRA
import fi.viikkonro.app.widget.UpdateScheduler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Hands widget taps to the Dart router (FP-W12) and keeps the midnight widget
 * job booked whenever the app is opened, which also re-arms it after the user
 * clears the app's data.
 */
class MainActivity : FlutterActivity() {
    private companion object {
        const val CHANNEL = "fi.viikkonro.app/routes"
    }

    private var channel: MethodChannel? = null
    private var pendingRoute: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        pendingRoute = routeFrom(intent)
        UpdateScheduler.scheduleNextMidnight(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    // Read once at startup: a cold start has to find the route
                    // that launched it before it has drawn anything.
                    "initialRoute" -> {
                        result.success(pendingRoute)
                        pendingRoute = null
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        val route = routeFrom(intent) ?: return
        val target = channel
        if (target == null) pendingRoute = route else target.invokeMethod("route", route)
    }

    /** `viikkonro://widget/viikko-37-2026` and `https://viikkonro.fi/...` alike. */
    private fun routeFrom(intent: Intent?): String? {
        intent?.getStringExtra(ROUTE_EXTRA)?.takeIf { it.isNotBlank() }?.let { return it }
        val data: Uri = intent?.data ?: return null
        val path = data.path?.takeIf { it.isNotBlank() } ?: return null
        val allowed = data.scheme == "viikkonro" || (data.host == "viikkonro.fi" && data.scheme in listOf("http", "https"))
        if (!allowed) return null
        return path + (data.query?.let { "?$it" } ?: "")
    }
}
