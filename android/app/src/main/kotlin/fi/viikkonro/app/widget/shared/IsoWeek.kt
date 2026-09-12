package fi.viikkonro.app.widget.shared

import java.time.LocalDate
import java.time.temporal.WeekFields

/** Shared by native widgets. Never depends on the Flutter process or a cache. */
object IsoWeek {
    fun week(date: LocalDate): Int = date.get(WeekFields.ISO.weekOfWeekBasedYear())
    fun year(date: LocalDate): Int = date.get(WeekFields.ISO.weekBasedYear())
    fun weeksInYear(year: Int): Int = week(LocalDate.of(year, 12, 28))

    fun monday(week: Int, year: Int): LocalDate {
        require(week in 1..weeksInYear(year)) { "Invalid ISO week: $year-W$week" }
        val january4 = LocalDate.of(year, 1, 4)
        return january4.minusDays(january4.dayOfWeek.value.toLong() - 1)
            .plusWeeks(week.toLong() - 1)
    }

    fun sunday(week: Int, year: Int): LocalDate = monday(week, year).plusDays(6)

    /** The Monday-first grid for the month containing [date], whole weeks only. */
    fun monthGrid(date: LocalDate): List<List<LocalDate>> {
        val first = date.withDayOfMonth(1)
        val start = first.minusDays(first.dayOfWeek.value.toLong() - 1)
        val rows = (first.dayOfWeek.value - 1 + first.lengthOfMonth() + 6) / 7
        return (0 until rows).map { row -> (0L..6L).map { start.plusDays(row * 7 + it) } }
    }
}
