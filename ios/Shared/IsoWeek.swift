import Foundation

/// Shared native date math for the app and future WidgetKit timeline entries.
enum IsoWeek {
    // Construct on use so a time-zone change cannot leave a stale calendar.
    static func calendar(timeZone: TimeZone = .autoupdatingCurrent) -> Calendar {
        var calendar = Calendar(identifier: .iso8601)
        calendar.firstWeekday = 2
        calendar.minimumDaysInFirstWeek = 4
        calendar.timeZone = timeZone
        return calendar
    }

    static func week(_ date: Date, calendar: Calendar = calendar()) -> Int {
        calendar.component(.weekOfYear, from: date)
    }

    static func year(_ date: Date, calendar: Calendar = calendar()) -> Int {
        calendar.component(.yearForWeekOfYear, from: date)
    }

    static func weeksInYear(_ year: Int, calendar: Calendar = calendar()) -> Int {
        let december28 = calendar.date(from: DateComponents(year: year, month: 12, day: 28))!
        return week(december28, calendar: calendar)
    }

    static func monday(week: Int, year: Int, calendar: Calendar = calendar()) -> Date? {
        guard (1...weeksInYear(year, calendar: calendar)).contains(week) else { return nil }
        return calendar.date(from: DateComponents(
            weekday: 2, weekOfYear: week, yearForWeekOfYear: year
        ))
    }

    static func sunday(week: Int, year: Int, calendar: Calendar = calendar()) -> Date? {
        guard let monday = monday(week: week, year: year, calendar: calendar) else { return nil }
        return calendar.date(byAdding: .day, value: 6, to: monday)
    }
}
