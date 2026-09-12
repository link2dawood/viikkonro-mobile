package fi.viikkonro.app

import fi.viikkonro.app.widget.shared.IsoWeek
import java.time.LocalDate
import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Test

class IsoWeekParityTest {
    private val fixture = JSONObject(
        checkNotNull(javaClass.classLoader?.getResourceAsStream("iso_week_fixture.json"))
            .bufferedReader().use { it.readText() }
    )

    @Test fun everyDateMatchesWebsite() {
        val dates = fixture.getJSONArray("dates")
        assertEquals(5844, dates.length())
        for (index in 0 until dates.length()) {
            val row = dates.getJSONObject(index)
            val date = LocalDate.parse(row.getString("date"))
            assertEquals(date.toString(), row.getInt("week"), IsoWeek.week(date))
            assertEquals(date.toString(), row.getInt("isoYear"), IsoWeek.year(date))
        }
    }

    @Test fun everyWeekSpanMatchesWebsite() {
        val years = fixture.getJSONArray("years")
        var count = 0
        for (index in 0 until years.length()) {
            val row = years.getJSONObject(index)
            val year = row.getInt("year")
            assertEquals(row.getInt("weeksInYear"), IsoWeek.weeksInYear(year))
            val weeks = row.getJSONArray("weeks")
            for (weekIndex in 0 until weeks.length()) {
                val entry = weeks.getJSONObject(weekIndex)
                val week = entry.getInt("week")
                assertEquals(entry.getString("monday"), IsoWeek.monday(week, year).toString())
                assertEquals(entry.getString("sunday"), IsoWeek.sunday(week, year).toString())
                count++
            }
        }
        assertEquals(835, count)
    }

    @Test(expected = IllegalArgumentException::class)
    fun rejectsInvalidWeek() { IsoWeek.monday(53, 2025) }
}
