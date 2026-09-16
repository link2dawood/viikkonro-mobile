package fi.viikkonro.app.widget.shared

import android.content.Context
import fi.viikkonro.app.R
import java.time.DayOfWeek
import java.time.LocalDate
import java.time.Month
import java.time.format.TextStyle
import java.time.temporal.ChronoUnit
import java.util.Locale

/**
 * Everything the seven widgets draw, computed from the device clock and the
 * bundled snapshot. Nothing here is read back from a stored week number, so a
 * widget stays correct with the app force stopped, its data cleared, or after
 * thirty days without the app being opened (FP-W09).
 */
class WidgetModel(context: Context, val today: LocalDate = LocalDate.now()) {
    private val data = CalendarSnapshot.load(context)

    val week: Int = IsoWeek.week(today)
    val isoYear: Int = IsoWeek.year(today)
    val weeksInYear: Int = IsoWeek.weeksInYear(isoYear)
    val monday: LocalDate = IsoWeek.monday(week, isoYear)
    val days: List<LocalDate> = (0L..6L).map { monday.plusDays(it) }

    val todayObservances: List<Observance> = data.on(today)
    val nextHoliday: Observance? = data.nextHoliday(today)
    val nextFlagDay: Observance? = data.nextFlagDay(today)

    fun isPublicHoliday(date: LocalDate): Boolean = data.isPublicHoliday(date)
    fun observances(date: LocalDate): List<Observance> = data.on(date)
    fun nextSchoolBreak(city: String?): SchoolBreak? = data.nextSchoolBreak(today, city)
    fun schoolCities(): List<String> = data.cities()

    fun daysUntil(date: LocalDate): Long = ChronoUnit.DAYS.between(today, date)

    /** The month grid that the Kuukausi widget draws, Monday first. */
    fun monthGrid(month: LocalDate = today): List<List<LocalDate>> = IsoWeek.monthGrid(month)
}

/**
 * Widget strings come from the platform's own resources, not from the Dart ARB
 * files, because the widget renders without the Flutter engine (FP-G07).
 */
object WidgetText {
    fun week(context: Context): String = context.getString(R.string.widget_week)
    fun weekOf(context: Context, week: Int, total: Int): String =
        context.getString(R.string.widget_week_of, week, total)

    fun dayCount(context: Context, days: Long): String = when (days) {
        0L -> context.getString(R.string.widget_today)
        1L -> context.getString(R.string.widget_day_one)
        else -> context.getString(R.string.widget_day_many, days)
    }

    /// The widget's own locale, which is the device's, not the app's Dart one.
    private fun locale(context: Context): Locale =
        context.resources.configuration.locales[0] ?: Locale.getDefault()

    /**
     * Month and weekday names come from the platform's own calendar data rather
     * than a translated string array: that covers every locale the device can
     * be set to, including ones the app has no interface strings for.
     */
    fun weekdayInitials(context: Context): List<String> {
        val locale = locale(context)
        return (1..7).map {
            DayOfWeek.of(it).getDisplayName(TextStyle.SHORT, locale).lowercase(locale)
        }
    }

    fun monthName(context: Context, month: Int): String =
        Month.of(month).getDisplayName(TextStyle.FULL_STANDALONE, locale(context))

    /** `12.9.` — the short civil form both app languages use in a widget. */
    fun shortDate(date: LocalDate): String = "${date.dayOfMonth}.${date.monthValue}."

    fun span(start: LocalDate, end: LocalDate): String = "${shortDate(start)}–${shortDate(end)}"

    fun confidence(context: Context, tier: String): String? = when (tier) {
        "estimated" -> context.getString(R.string.widget_estimated)
        "unknown" -> context.getString(R.string.widget_unknown)
        else -> null
    }
}
