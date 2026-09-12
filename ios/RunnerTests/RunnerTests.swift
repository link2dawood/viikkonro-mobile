import Foundation
import XCTest

class RunnerTests: XCTestCase {

    private struct Fixture: Decodable {
        struct Day: Decodable { let date: String; let week: Int; let isoYear: Int }
        struct Year: Decodable {
            struct Week: Decodable { let week: Int; let monday: String; let sunday: String }
            let year: Int
            let weeksInYear: Int
            let weeks: [Week]
        }
        let dates: [Day]
        let years: [Year]
    }

    private func loadFixture() throws -> Fixture {
        let url = try XCTUnwrap(Bundle(for: Self.self).url(
            forResource: "iso_week_fixture", withExtension: "json"
        ))
        return try JSONDecoder().decode(Fixture.self, from: Data(contentsOf: url))
    }

    private func formatter(calendar: Calendar) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = calendar
        formatter.timeZone = calendar.timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    func testEveryDateMatchesWebsiteInMultipleTimeZones() throws {
        let fixture = try loadFixture()
        XCTAssertEqual(fixture.dates.count, 5844)
        for zone in ["Europe/Helsinki", "UTC", "America/New_York", "Pacific/Auckland"] {
            let calendar = IsoWeek.calendar(timeZone: try XCTUnwrap(TimeZone(identifier: zone)))
            let formatter = formatter(calendar: calendar)
            for row in fixture.dates {
                let date = try XCTUnwrap(formatter.date(from: row.date))
                XCTAssertEqual(IsoWeek.week(date, calendar: calendar), row.week, "\(zone) \(row.date)")
                XCTAssertEqual(IsoWeek.year(date, calendar: calendar), row.isoYear, "\(zone) \(row.date)")
            }
        }
    }

    func testEveryWeekSpanMatchesWebsite() throws {
        let fixture = try loadFixture()
        for zone in ["Europe/Helsinki", "UTC", "America/New_York", "Pacific/Auckland"] {
            let calendar = IsoWeek.calendar(timeZone: try XCTUnwrap(TimeZone(identifier: zone)))
            let formatter = formatter(calendar: calendar)
            var count = 0
            for year in fixture.years {
                XCTAssertEqual(IsoWeek.weeksInYear(year.year, calendar: calendar), year.weeksInYear)
                for week in year.weeks {
                    let monday = try XCTUnwrap(IsoWeek.monday(week: week.week, year: year.year, calendar: calendar))
                    let sunday = try XCTUnwrap(IsoWeek.sunday(week: week.week, year: year.year, calendar: calendar))
                    XCTAssertEqual(formatter.string(from: monday), week.monday)
                    XCTAssertEqual(formatter.string(from: sunday), week.sunday)
                    XCTAssertEqual(calendar.component(.hour, from: monday), 0)
                    XCTAssertEqual(calendar.component(.hour, from: sunday), 0)
                    count += 1
                }
            }
            XCTAssertEqual(count, 835)
        }
    }

    func testInvalidWeekIsRejected() {
        XCTAssertNil(IsoWeek.monday(week: 0, year: 2026))
        XCTAssertNil(IsoWeek.monday(week: 53, year: 2025))
    }

}
