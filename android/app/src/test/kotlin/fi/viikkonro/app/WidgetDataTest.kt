package fi.viikkonro.app

import fi.viikkonro.app.widget.shared.CalendarSnapshot
import fi.viikkonro.app.widget.shared.IsoWeek
import java.time.DayOfWeek
import java.time.LocalDate
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * The widgets read the bundled snapshot themselves rather than a payload the
 * Flutter side writes, so the parser is the thing that has to hold up with the
 * engine dead. These tests exercise it directly, without an Android context.
 */
class WidgetDataTest {
    private val snapshot = CalendarSnapshot.parse(
        checkNotNull(javaClass.classLoader?.getResourceAsStream("calendar.json"))
            .bufferedReader().use { it.readText() }
    )

    @Test fun snapshotCoversTheWholePublishedRange() {
        assertEquals(2020, snapshot.observances.first().date.year)
        assertEquals(2035, snapshot.observances.last().date.year)
        assertTrue(snapshot.observances.size > 400)
    }

    @Test fun holidaysAndFlagDaysStaySeparate() {
        val christmas = LocalDate.of(2026, 12, 25)
        assertTrue(snapshot.isPublicHoliday(christmas))
        assertEquals("Joulupäivä", snapshot.on(christmas).single { !it.flag }.name)
        // Christmas Eve is a juhlapäivä, not a public holiday: it stays a
        // working day, which is what the day counters depend on.
        assertEquals(false, snapshot.isPublicHoliday(LocalDate.of(2026, 12, 24)))
        val fathersDay = LocalDate.of(2026, 11, 8)
        assertTrue(snapshot.on(fathersDay).all { it.flag })
        assertEquals(false, snapshot.isPublicHoliday(fathersDay))
    }

    @Test fun nextHolidayAndFlagDayLookForward() {
        val from = LocalDate.of(2026, 11, 20)
        assertEquals(LocalDate.of(2026, 12, 6), snapshot.nextHoliday(from)?.date)
        assertEquals(LocalDate.of(2026, 12, 8), snapshot.nextFlagDay(from)?.date)
        // A date that is itself a holiday returns itself, so a widget shows
        // "today" rather than skipping to next year.
        assertEquals(LocalDate.of(2026, 12, 6), snapshot.nextHoliday(LocalDate.of(2026, 12, 6))?.date)
    }

    @Test fun schoolBreaksKeepTheirConfidenceTier() {
        assertTrue(snapshot.schoolBreaks.isNotEmpty())
        assertTrue(snapshot.schoolBreaks.all { it.confidence.isNotBlank() })
        val helsinki = snapshot.nextSchoolBreak(LocalDate.of(2026, 1, 1), "Helsinki")
        assertNotNull(helsinki)
        assertTrue(helsinki!!.cities.contains("Helsinki"))
    }

    @Test fun monthGridStartsOnMondayAndCoversTheMonth() {
        for (month in 1..12) {
            val grid = IsoWeek.monthGrid(LocalDate.of(2026, month, 1))
            assertEquals(DayOfWeek.MONDAY, grid.first().first().dayOfWeek)
            assertTrue(grid.all { it.size == 7 })
            val days = grid.flatten()
            assertTrue(days.contains(LocalDate.of(2026, month, 1)))
            assertTrue(days.contains(LocalDate.of(2026, month, 1).withDayOfMonth(
                LocalDate.of(2026, month, 1).lengthOfMonth())))
        }
    }

    @Test fun theGridAndTheGutterAgreeAcrossAYearBoundary() {
        // January 2027 opens in week 53 of ISO year 2026; the gutter has to say
        // so, which is why the widget recomputes both from the row's Monday.
        val grid = IsoWeek.monthGrid(LocalDate.of(2027, 1, 1))
        val firstMonday = grid.first().first()
        assertEquals(53, IsoWeek.week(firstMonday))
        assertEquals(2026, IsoWeek.year(firstMonday))
    }
}
