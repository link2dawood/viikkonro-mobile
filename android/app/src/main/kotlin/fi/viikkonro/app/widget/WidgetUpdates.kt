package fi.viikkonro.app.widget

import android.appwidget.AppWidgetProviderInfo.WIDGET_CATEGORY_HOME_SCREEN
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.collection.intSetOf
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.updateAll
import androidx.work.CoroutineWorker
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.WorkerParameters
import fi.viikkonro.app.BuildConfig
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.time.Duration
import java.time.LocalDate
import java.time.LocalTime
import java.time.ZonedDateTime

/** Every provider in the bundle, so one call refreshes the whole home screen. */
object WidgetUpdater {
    private val widgets: List<() -> GlanceAppWidget> = listOf(
        ::WeekMiniWidget,
        ::WeekCardWidget,
        ::WeekStripWidget,
        ::MonthWidget,
        ::CountdownWidget,
        ::HolidaysWidget,
        ::SchoolHolidayWidget,
    )

    suspend fun updateAll(context: Context) {
        widgets.forEach { it().updateAll(context) }
    }
}

/**
 * FP-W10: the daily refresh at 00:05.
 *
 * This schedules itself one run at a time rather than using a periodic request,
 * because a periodic request drifts and cannot be pinned to a wall-clock time
 * across a daylight-saving change. Each run books the next one from the local
 * calendar, so the job lands just after midnight whether the day was 23, 24 or
 * 25 hours long.
 */
class WidgetUpdateWorker(context: Context, params: WorkerParameters) : CoroutineWorker(context, params) {
    override suspend fun doWork(): Result {
        WidgetUpdater.updateAll(applicationContext)
        UpdateScheduler.scheduleNextMidnight(applicationContext)
        return Result.success()
    }
}

object UpdateScheduler {
    private const val WORK_NAME = "viikkonro-midnight-widget-update"
    private val UPDATE_AT: LocalTime = LocalTime.of(0, 5)

    fun scheduleNextMidnight(context: Context) {
        val now = ZonedDateTime.now()
        var next = now.with(UPDATE_AT)
        if (!next.isAfter(now)) {
            next = now.toLocalDate().plusDays(1).atTime(UPDATE_AT).atZone(now.zone)
        }
        val delay = Duration.between(now, next)
        WorkManager.getInstance(context).enqueueUniqueWork(
            WORK_NAME,
            ExistingWorkPolicy.REPLACE,
            OneTimeWorkRequestBuilder<WidgetUpdateWorker>()
                .setInitialDelay(delay)
                .build(),
        )
    }
}

/**
 * Android 15 can render the real Glance UI in the widget picker. Publish each
 * provider once per app version; the platform rate-limits preview writes.
 * Android 12–14 continue to use the localized previewLayout fallback.
 */
object WidgetPreviewPublisher {
    private const val PREFS = "widget-preview-publication"

    fun publishIfNeeded(context: Context) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.VANILLA_ICE_CREAM) return
        val appContext = context.applicationContext
        val prefs = appContext.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val receivers = listOf(
            WeekMiniReceiver::class,
            WeekCardReceiver::class,
            WeekStripReceiver::class,
            MonthReceiver::class,
            CountdownReceiver::class,
            HolidaysReceiver::class,
            SchoolHolidayReceiver::class,
        ).filter { prefs.getInt(it.java.name, -1) != BuildConfig.VERSION_CODE }
        if (receivers.isEmpty()) return

        CoroutineScope(Dispatchers.Default).launch {
            val manager = GlanceAppWidgetManager(appContext)
            val categories = intSetOf(WIDGET_CATEGORY_HOME_SCREEN)
            receivers.forEach { receiver ->
                val result = runCatching { manager.setWidgetPreviews(receiver, categories) }.getOrNull()
                if (result == GlanceAppWidgetManager.SET_WIDGET_PREVIEWS_RESULT_SUCCESS) {
                    // Store each success independently. If Android rate-limits
                    // later providers, a future launch resumes at that point.
                    prefs.edit().putInt(receiver.java.name, BuildConfig.VERSION_CODE).apply()
                }
            }
        }
    }
}

/**
 * FP-W11: the system tells us the date or the time zone moved, and the widget
 * follows within seconds. Also rebooks the midnight job after a reboot or an
 * app update, because a pending WorkManager request does not survive either.
 */
class DateChangeReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val pending = goAsync()
        CoroutineScope(Dispatchers.Default).launch {
            try {
                WidgetUpdater.updateAll(context.applicationContext)
                UpdateScheduler.scheduleNextMidnight(context.applicationContext)
            } finally {
                pending.finish()
            }
        }
    }
}

/** Exposed for the unit test: the day the widgets should currently be showing. */
internal fun currentWidgetDate(): LocalDate = LocalDate.now()
