package fi.viikkonro.app.widget

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.updateAll
import androidx.work.CoroutineWorker
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.WorkerParameters
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
