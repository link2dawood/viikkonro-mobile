import Foundation
import SwiftUI
import UIKit
import WidgetKit

private let green = Color(uiColor: UIColor { traits in
    traits.userInterfaceStyle == .dark
        ? UIColor(red: 145 / 255, green: 212 / 255, blue: 183 / 255, alpha: 1)
        : UIColor(red: 31 / 255, green: 122 / 255, blue: 92 / 255, alpha: 1)
})
private let amber = Color(uiColor: UIColor { traits in
    traits.userInterfaceStyle == .dark
        ? UIColor(red: 1, green: 211 / 255, blue: 138 / 255, alpha: 1)
        : UIColor(red: 112 / 255, green: 71 / 255, blue: 0, alpha: 1)
})
private let card = Color(uiColor: .secondarySystemBackground)

private struct Event {
    let date: Date
    let name: String
    let official: Bool
    let flag: Bool
}

private struct SchoolBreak {
    let kind: String
    let start: Date?
    let end: Date?
    let cities: [String]
    let confidence: String
}

private struct Snapshot {
    let events: [Event]
    let breaks: [SchoolBreak]

    static func load(calendar: Calendar) -> Snapshot {
        guard let url = Bundle.main.url(forResource: "calendar", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let object = try? JSONSerialization.jsonObject(with: data),
              let root = object as? [String: Any]
        else { return Snapshot(events: [], breaks: []) }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = calendar
        formatter.timeZone = calendar.timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        var events: [Event] = []
        for year in root["years"] as? [[String: Any]] ?? [] {
            for row in year["holidays"] as? [[String: Any]] ?? [] {
                guard let raw = row["date"] as? String, let date = formatter.date(from: raw) else { continue }
                events.append(Event(date: date, name: row["name"] as? String ?? "", official: row["official"] as? Bool ?? false, flag: false))
            }
            for row in year["flagDays"] as? [[String: Any]] ?? [] {
                guard let raw = row["date"] as? String, let date = formatter.date(from: raw) else { continue }
                for name in row["names"] as? [String] ?? [] {
                    events.append(Event(date: date, name: name, official: false, flag: true))
                }
            }
        }
        var breaks: [SchoolBreak] = []
        for page in root["schoolHolidays"] as? [[String: Any]] ?? [] {
            for kind in ["winter", "autumn"] {
                for row in page[kind] as? [[String: Any]] ?? [] {
                    breaks.append(SchoolBreak(
                        kind: kind,
                        start: (row["startDate"] as? String).flatMap { formatter.date(from: $0) },
                        end: (row["endDate"] as? String).flatMap { formatter.date(from: $0) },
                        cities: row["cities"] as? [String] ?? [],
                        confidence: row["confidence"] as? String ?? "unknown"
                    ))
                }
            }
        }
        return Snapshot(events: events.sorted { $0.date < $1.date }, breaks: breaks.sorted { ($0.start ?? .distantFuture) < ($1.start ?? .distantFuture) })
    }
}

private struct WidgetEntry: TimelineEntry {
    let date: Date
    let calendar: Calendar
    let snapshot: Snapshot

    var week: Int { IsoWeek.week(date, calendar: calendar) }
    var year: Int { IsoWeek.year(date, calendar: calendar) }
    var monday: Date { IsoWeek.monday(week: week, year: year, calendar: calendar) ?? date }
    var days: [Date] { (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: monday) } }
    var nextHoliday: Event? { snapshot.events.first { !$0.date.isBeforeDay(date, calendar) && $0.official && !$0.flag } }
    var nextFlag: Event? { snapshot.events.first { !$0.date.isBeforeDay(date, calendar) && $0.flag } }
    var nextBreak: SchoolBreak? { snapshot.breaks.first { ($0.end ?? .distantPast) >= calendar.startOfDay(for: date) } }
    func daysUntil(_ target: Date) -> Int {
        calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: date),
            to: calendar.startOfDay(for: target)
        ).day ?? 0
    }
}

private extension Date {
    func isBeforeDay(_ other: Date, _ calendar: Calendar) -> Bool { calendar.startOfDay(for: self) < calendar.startOfDay(for: other) }
}

private struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry { entry(Date()) }
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) { completion(entry(Date())) }
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let current = entry(Date())
        let next = current.calendar.date(byAdding: .day, value: 1, to: current.calendar.startOfDay(for: current.date)) ?? current.date.addingTimeInterval(3600)
        completion(Timeline(entries: [current], policy: .after(next)))
    }
    private func entry(_ date: Date) -> WidgetEntry {
        let calendar = IsoWeek.calendar()
        return WidgetEntry(date: date, calendar: calendar, snapshot: Snapshot.load(calendar: calendar))
    }
}

private struct Surface<Content: View>: View {
    @ViewBuilder let content: Content
    @ViewBuilder var body: some View {
        if #available(iOSApplicationExtension 17.0, *) {
            content.padding(12).containerBackground(card, for: .widget)
        } else {
            content.padding(12).background(card)
        }
    }
}

private struct Header: View {
    let title: String
    var body: some View {
        HStack(spacing: 6) {
            Text("V").font(.caption2.bold()).foregroundStyle(card).frame(width: 16, height: 16).background(green, in: RoundedRectangle(cornerRadius: 5))
            Text(title).font(.caption.bold()).foregroundStyle(green).lineLimit(1)
        }
    }
}

private func shortDate(_ date: Date) -> String { date.formatted(.dateTime.day().month()) }
private func dayCount(_ entry: WidgetEntry, _ date: Date) -> String {
    let days = entry.daysUntil(date)
    return days == 0 ? String(localized: "today") : String(format: String(localized: "days"), Int64(days))
}
private func confidenceLabel(_ confidence: String) -> String? {
    switch confidence {
    case "estimated": return String(localized: "estimated")
    case "unknown": return String(localized: "not_published")
    default: return nil
    }
}

private struct WeekMiniView: View {
    let entry: WidgetEntry
    @Environment(\.widgetFamily) private var family
    var body: some View {
        if family == .accessoryCircular {
            Gauge(value: Double(entry.week), in: 1...53) {
                Text(String(localized: "week"))
            } currentValueLabel: {
                Text("\(entry.week)").font(.title.bold())
            }.gaugeStyle(.accessoryCircular)
        } else if family == .accessoryInline {
            Text("\(String(localized: "week")) \(entry.week)")
        } else {
            Surface {
                VStack(spacing: 2) {
                    Text(String(localized: "week").uppercased())
                        .font(.caption2)
                        .foregroundStyle(green)
                    Text("\(entry.week)")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                }
            }
        }
    }
}

private struct WeekCardView: View {
    let entry: WidgetEntry
    var body: some View {
        Surface {
            VStack(alignment: .leading, spacing: 5) {
                Header(title: String(localized: "week").uppercased())
                Text("\(entry.week) / \(entry.year)").font(.system(size: 32, weight: .bold, design: .rounded))
                Text("\(shortDate(entry.monday))–\(shortDate(entry.days.last ?? entry.monday))").font(.caption)
                if let event = entry.nextHoliday {
                    Label(event.name, systemImage: "circle.fill")
                        .font(.caption)
                        .foregroundStyle(amber)
                        .lineLimit(2)
                    Text(dayCount(entry, event.date)).font(.caption2).foregroundStyle(amber)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.widgetURL(URL(string: "viikkonro://widget/viikko-\(entry.week)-\(entry.year)"))
    }
}

private struct WeekStripView: View {
    let entry: WidgetEntry
    var body: some View {
        Surface {
            VStack(spacing: 8) {
                HStack {
                    Header(title: "\(String(localized: "week")) \(entry.week)")
                    Spacer()
                    Text("\(shortDate(entry.monday))–\(shortDate(entry.days.last ?? entry.monday))")
                        .font(.caption2)
                }
                HStack {
                    ForEach(entry.days, id: \.self) { date in DayCell(date: date, entry: entry) }
                }
            }
        }.widgetURL(URL(string: "viikkonro://widget/viikko-\(entry.week)-\(entry.year)"))
    }
}

private struct DayCell: View {
    let date: Date; let entry: WidgetEntry
    var body: some View {
        let today = entry.calendar.isDate(date, inSameDayAs: entry.date)
        let holiday = entry.snapshot.events.contains { entry.calendar.isDate($0.date, inSameDayAs: date) && $0.official }
        VStack(spacing: 3) {
            Text(date.formatted(.dateTime.weekday(.narrow))).font(.caption2).foregroundStyle(holiday ? amber : .secondary)
            Text("\(entry.calendar.component(.day, from: date))")
                .font(.caption.bold())
                .frame(width: 28, height: 28)
                .background(today ? green.opacity(0.2) : .clear, in: RoundedRectangle(cornerRadius: 9))
            Circle().fill(holiday ? amber : .clear).frame(width: 5, height: 5)
        }.frame(maxWidth: .infinity)
    }
}

private struct MonthView: View {
    let entry: WidgetEntry
    private var grid: [[Date]] {
        let start = entry.calendar.date(from: entry.calendar.dateComponents([.year, .month], from: entry.date)) ?? entry.date
        let weekday = entry.calendar.component(.weekday, from: start)
        let offset = (weekday + 5) % 7
        let monday = entry.calendar.date(byAdding: .day, value: -offset, to: start) ?? start
        return (0..<6).map { week in (0..<7).compactMap { entry.calendar.date(byAdding: .day, value: week * 7 + $0, to: monday) } }
    }
    var body: some View {
        Surface {
            VStack(spacing: 7) {
                Header(title: entry.date.formatted(.dateTime.month(.wide).year()))
                HStack {
                    Text("#").frame(width: 24)
                    ForEach(entry.days, id: \.self) {
                        Text($0.formatted(.dateTime.weekday(.narrow))).frame(maxWidth: .infinity)
                    }
                }
                .font(.caption2)
                .foregroundStyle(.secondary)
                ForEach(Array(grid.enumerated()), id: \.offset) { _, week in
                    HStack {
                        Text("\(IsoWeek.week(week[0], calendar: entry.calendar))")
                            .foregroundStyle(green)
                            .frame(width: 24)
                        ForEach(week, id: \.self) { date in
                            MonthDay(date: date, entry: entry)
                        }
                    }.font(.caption)
                }
            }
        }.widgetURL(URL(string: "viikkonro://widget/kuukausi-\(entry.calendar.component(.month, from: entry.date))-\(entry.calendar.component(.year, from: entry.date))"))
    }
}

private struct MonthDay: View {
    let date: Date
    let entry: WidgetEntry
    var body: some View {
        let inMonth = entry.calendar.isDate(date, equalTo: entry.date, toGranularity: .month)
        let today = entry.calendar.isDate(date, inSameDayAs: entry.date)
        let holiday = entry.snapshot.events.contains {
            entry.calendar.isDate($0.date, inSameDayAs: date) && $0.official && !$0.flag
        }
        Text("\(entry.calendar.component(.day, from: date))")
            .frame(maxWidth: .infinity)
            .foregroundStyle(holiday ? amber : (inMonth ? Color.primary : Color.secondary))
            .background(today ? green.opacity(0.2) : .clear, in: Circle())
    }
}

private struct CountdownView: View {
    let entry: WidgetEntry
    @Environment(\.widgetFamily) private var family
    var body: some View {
        if family == .accessoryRectangular {
            if let event = entry.nextHoliday {
                VStack(alignment: .leading) {
                    Text("\(entry.daysUntil(event.date))").font(.title.bold())
                    Text(event.name).lineLimit(1)
                }
            } else {
                Text(String(localized: "not_published"))
            }
        } else {
            Surface {
                if let event = entry.nextHoliday {
                    VStack {
                        Text("\(entry.daysUntil(event.date))")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                        Text(dayCount(entry, event.date)).font(.caption).foregroundStyle(green)
                        Text(event.name).font(.caption).multilineTextAlignment(.center).lineLimit(2)
                    }
                } else {
                    Text(String(localized: "not_published"))
                }
            }
        }
    }
}

private struct HolidaysView: View {
    let entry: WidgetEntry
    var body: some View {
        Surface {
            HStack(spacing: 14) {
                EventView(
                    title: String(localized: "next_holiday"),
                    event: entry.nextHoliday,
                    entry: entry,
                    holiday: true
                )
                Divider()
                EventView(
                    title: String(localized: "next_flag"),
                    event: entry.nextFlag,
                    entry: entry,
                    holiday: false
                )
            }
        }
            .widgetURL(URL(string: "viikkonro://widget/pyhapaivat-\(entry.calendar.component(.year, from: entry.date))"))
    }
}

private struct EventView: View {
    let title: String
    let event: Event?
    let entry: WidgetEntry
    let holiday: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Label(title.uppercased(), systemImage: holiday ? "circle.fill" : "flag.fill")
                .font(.caption2)
                .foregroundStyle(holiday ? amber : green)
                .lineLimit(1)
            Text(event?.name ?? String(localized: "not_published"))
                .font(.caption.bold())
                .lineLimit(2)
            if let event {
                Text("\(shortDate(event.date)) · \(dayCount(entry, event.date))")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct SchoolView: View {
    let entry: WidgetEntry
    var body: some View {
        Surface {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Header(title: String(localized: "school_break").uppercased())
                    Spacer()
                    if let confidence = entry.nextBreak?.confidence,
                       let badge = confidenceLabel(confidence) {
                        Text(badge)
                            .font(.caption2)
                            .foregroundStyle(amber)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(green.opacity(0.12), in: Capsule())
                    }
                }
                if let period = entry.nextBreak, let start = period.start, let end = period.end {
                    Text(
                        period.kind == "winter"
                            ? String(localized: "winter_break")
                            : String(localized: "autumn_break")
                    ).font(.headline)
                    Text("\(shortDate(start))–\(shortDate(end))").font(.caption)
                    Text(period.cities.prefix(2).joined(separator: ", "))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                } else {
                    Text(String(localized: "not_published"))
                }
                Spacer(minLength: 0)
            }
        }
        .widgetURL(URL(string: "viikkonro://widget/koululomat-\(entry.calendar.component(.year, from: entry.date))"))
    }
}

private func basicConfiguration<Content: View>(
    kind: String,
    name: LocalizedStringKey,
    families: [WidgetFamily],
    @ViewBuilder content: @escaping (WidgetEntry) -> Content
) -> some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { content($0) }
        .configurationDisplayName(name)
        .description(name)
        .supportedFamilies(families)
}

private struct WeekMiniWidget: Widget {
    var body: some WidgetConfiguration {
        basicConfiguration(
            kind: "week-mini",
            name: "week_mini_name",
            families: [.systemSmall, .accessoryCircular, .accessoryInline]
        ) { WeekMiniView(entry: $0) }
    }
}

private struct WeekCardWidget: Widget {
    var body: some WidgetConfiguration {
        basicConfiguration(
            kind: "week-card",
            name: "week_card_name",
            families: [.systemSmall, .systemMedium]
        ) { WeekCardView(entry: $0) }
    }
}

private struct WeekStripWidget: Widget {
    var body: some WidgetConfiguration {
        basicConfiguration(
            kind: "week-strip",
            name: "week_strip_name",
            families: [.systemMedium]
        ) { WeekStripView(entry: $0) }
    }
}

private struct MonthWidget: Widget {
    var body: some WidgetConfiguration {
        basicConfiguration(
            kind: "month",
            name: "month_name",
            families: [.systemLarge]
        ) { MonthView(entry: $0) }
    }
}

private struct CountdownWidget: Widget {
    var body: some WidgetConfiguration {
        basicConfiguration(
            kind: "countdown",
            name: "countdown_name",
            families: [.systemSmall, .accessoryRectangular]
        ) { CountdownView(entry: $0) }
    }
}

private struct HolidaysWidget: Widget {
    var body: some WidgetConfiguration {
        basicConfiguration(
            kind: "holidays",
            name: "holidays_name",
            families: [.systemMedium]
        ) { HolidaysView(entry: $0) }
    }
}

private struct SchoolWidget: Widget {
    var body: some WidgetConfiguration {
        basicConfiguration(
            kind: "school",
            name: "school_name",
            families: [.systemMedium]
        ) { SchoolView(entry: $0) }
    }
}

@main struct ViikkonroWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeekMiniWidget()
        WeekCardWidget()
        WeekStripWidget()
        MonthWidget()
        CountdownWidget()
        HolidaysWidget()
        SchoolWidget()
    }
}
