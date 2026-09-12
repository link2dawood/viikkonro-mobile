package fi.viikkonro.app.widget.shared

import android.content.Context
import org.json.JSONObject
import java.time.LocalDate

/** One dated entry from the bundled snapshot. */
data class Observance(val date: LocalDate, val name: String, val official: Boolean, val flag: Boolean)

/** One school break, with the confidence tier it was published at. */
data class SchoolBreak(
    val kind: String,
    val start: LocalDate?,
    val end: LocalDate?,
    val cities: List<String>,
    val confidence: String,
)

/**
 * The calendar data, read straight out of the APK.
 *
 * Widgets must render with the Flutter engine dead and after the app's data has
 * been cleared, so this never reads a Flutter-written cache. It parses the same
 * bundled asset the Dart side ships with, and week arithmetic is always
 * recomputed in [IsoWeek] rather than read from a stored number.
 */
object CalendarSnapshot {
    private const val ASSET = "flutter_assets/assets/data/calendar.json"

    @Volatile
    private var cached: CalendarSnapshotData? = null

    fun load(context: Context): CalendarSnapshotData {
        cached?.let { return it }
        return synchronized(this) {
            cached ?: read(context).also { cached = it }
        }
    }

    private fun read(context: Context): CalendarSnapshotData {
        val text = try {
            context.assets.open(ASSET).bufferedReader().use { it.readText() }
        } catch (error: Exception) {
            // A missing or unreadable asset must not take the widget down; the
            // week number is computed without it.
            return CalendarSnapshotData(emptyList(), emptyList(), 0)
        }
        return parse(text)
    }

    /** Exposed so the parser can be tested without an Android context. */
    fun parse(text: String): CalendarSnapshotData {
        val root = JSONObject(text)
        val observances = mutableListOf<Observance>()
        val years = root.optJSONArray("years")
        for (y in 0 until (years?.length() ?: 0)) {
            val year = years!!.getJSONObject(y)
            val holidays = year.optJSONArray("holidays")
            for (h in 0 until (holidays?.length() ?: 0)) {
                val entry = holidays!!.getJSONObject(h)
                observances += Observance(
                    date = LocalDate.parse(entry.getString("date")),
                    name = entry.getString("name"),
                    official = entry.optBoolean("official", false),
                    flag = false,
                )
            }
            val flagDays = year.optJSONArray("flagDays")
            for (f in 0 until (flagDays?.length() ?: 0)) {
                val entry = flagDays!!.getJSONObject(f)
                val date = LocalDate.parse(entry.getString("date"))
                val names = entry.optJSONArray("names")
                for (n in 0 until (names?.length() ?: 0)) {
                    observances += Observance(date, names!!.getString(n), official = false, flag = true)
                }
            }
        }
        observances.sortBy { it.date }

        val breaks = mutableListOf<SchoolBreak>()
        val pages = root.optJSONArray("schoolHolidays")
        for (p in 0 until (pages?.length() ?: 0)) {
            val page = pages!!.getJSONObject(p)
            for (kind in listOf("winter", "autumn")) {
                val rows = page.optJSONArray(kind) ?: continue
                for (r in 0 until rows.length()) {
                    val row = rows.getJSONObject(r)
                    breaks += SchoolBreak(
                        kind = kind,
                        start = row.optString("startDate").takeIf { it.isNotEmpty() }?.let(LocalDate::parse),
                        end = row.optString("endDate").takeIf { it.isNotEmpty() }?.let(LocalDate::parse),
                        cities = (0 until (row.optJSONArray("cities")?.length() ?: 0))
                            .map { row.getJSONArray("cities").getString(it) },
                        // FP-D08: the tier is carried through, never flattened.
                        confidence = row.optString("confidence", "unknown"),
                    )
                }
            }
        }
        breaks.sortBy { it.start ?: LocalDate.MAX }
        return CalendarSnapshotData(observances, breaks, root.optInt("version", 0))
    }
}

class CalendarSnapshotData(
    val observances: List<Observance>,
    val schoolBreaks: List<SchoolBreak>,
    val version: Int,
) {
    fun on(date: LocalDate): List<Observance> = observances.filter { it.date == date }

    fun isPublicHoliday(date: LocalDate): Boolean =
        observances.any { it.date == date && it.official && !it.flag }

    fun nextHoliday(from: LocalDate): Observance? =
        observances.firstOrNull { !it.date.isBefore(from) && it.official && !it.flag }

    fun nextFlagDay(from: LocalDate): Observance? =
        observances.firstOrNull { !it.date.isBefore(from) && it.flag }

    fun nextSchoolBreak(from: LocalDate, city: String?): SchoolBreak? = schoolBreaks.firstOrNull {
        val end = it.end ?: return@firstOrNull false
        !end.isBefore(from) && (city == null || it.cities.contains(city))
    }
}
