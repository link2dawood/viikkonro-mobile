package fi.viikkonro.app

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.core.view.WindowCompat
import fi.viikkonro.app.widget.ROUTE_EXTRA
import fi.viikkonro.app.widget.UpdateScheduler
import fi.viikkonro.app.widget.WidgetPreviewPublisher
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
        const val ROUTES_CHANNEL = "fi.viikkonro.app/routes"
        const val ADS_CHANNEL = "fi.viikkonro.app/ads"
    }

    private var channel: MethodChannel? = null
    private var pendingRoute: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        // Android 15+ enforces edge-to-edge for this target SDK. Use the
        // focused decor-insets API on older versions too: unlike
        // WindowCompat.enableEdgeToEdge(), it does not set legacy system-bar
        // colors or LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES.
        WindowCompat.setDecorFitsSystemWindows(window, false)
        super.onCreate(savedInstanceState)
        pendingRoute = routeFrom(intent)
        UpdateScheduler.scheduleNextMidnight(this)
        WidgetPreviewPublisher.publishIfNeeded(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ROUTES_CHANNEL).apply {
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
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ADS_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                // The value is generated from ignored android/key.properties.
                // Debug builds always expose Google's official test ad unit.
                "configuration" -> result.success(mapOf(
                    "bannerAdUnitId" to BuildConfig.ADMOB_BANNER_AD_UNIT_ID,
                ))
                else -> result.notImplemented()
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
