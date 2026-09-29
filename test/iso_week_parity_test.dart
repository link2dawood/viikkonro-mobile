import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:viikkonro/core/date/finnish_format.dart';
import 'package:viikkonro/core/date/iso_week.dart';

void main() {
  final fixture =
      jsonDecode(File('test/fixtures/iso_week_fixture.json').readAsStringSync())
          as Map<String, dynamic>;

  test('test process uses the requested time zone', () {
    const januaryOffsets = {
      'Europe/Helsinki': 120,
      'UTC': 0,
      'America/New_York': -300,
      'Pacific/Auckland': 780,
    };
    final expected = januaryOffsets[Platform.environment['TZ']];
    if (expected != null) {
      expect(DateTime(2026, 1, 15).timeZoneOffset.inMinutes, expected);
    }
  });

  test('all 5,844 civil dates match the pinned website revision', () {
    final rows = fixture['dates'] as List<dynamic>;
    expect(rows, hasLength(5844));
    for (final row in rows) {
      final date = DateTime.parse(row['date'] as String);
      for (final hour in [0, 12, 23]) {
        final input = DateTime(date.year, date.month, date.day, hour, 30);
        expect(isoWeek(input), row['week'], reason: '$input');
        expect(isoYear(input), row['isoYear'], reason: '$input');
        expect(finnishLong(input), row['finnishLong'], reason: '$input');
      }
    }
  });

  test(
    'every ISO year and week span matches the website at local midnight',
    () {
      var count = 0;
      for (final year in fixture['years'] as List<dynamic>) {
        final number = year['year'] as int;
        expect(weeksInIsoYear(number), year['weeksInYear']);
        for (final row in year['weeks'] as List<dynamic>) {
          final monday = mondayOf(row['week'] as int, number);
          final sunday = sundayOf(row['week'] as int, number);
          expect(formatDate(monday), row['monday']);
          expect(formatDate(sunday), row['sunday']);
          expect(monday.weekday, DateTime.monday);
          expect(sunday.weekday, DateTime.sunday);
          expect(monday.hour, 0);
          expect(sunday.hour, 0);
          expect(finnishRange(monday, sunday), row['finnishRange']);
          count++;
        }
      }
      expect(count, 835);
    },
  );

  test('ISO year boundaries, leap day and invalid week input', () {
    expect(isoWeekLabel(DateTime(2021, 1, 1)), '2020-W53');
    expect(isoWeekLabel(DateTime(2024, 12, 30)), '2025-W01');
    expect(formatDate(addCalendarDays(DateTime(2024, 2, 28), 1)), '2024-02-29');
    expect(() => mondayOf(0, 2026), throwsRangeError);
    expect(() => mondayOf(53, 2025), throwsRangeError);
  });

  test('Finnish month cases and weekdays match the website', () {
    final finnish = fixture['finnish'] as Map<String, dynamic>;
    expect(monthGenitive, finnish['monthGenitive']);
    expect(monthPartitive, finnish['monthPartitive']);
    expect(weekdayNames, finnish['weekdays']);
    expect(
      finnishHeading(DateTime(2026, 9, 14)),
      'Maanantai 14. syyskuuta 2026',
    );
  });

  test('calendar shifts survive both daylight-saving transitions', () {
    expect(addCalendarDays(DateTime(2026, 3, 30), -1), DateTime(2026, 3, 29));
    expect(addCalendarDays(DateTime(2026, 10, 25), 1), DateTime(2026, 10, 26));
    expect(addCalendarDays(DateTime(2026, 1, 1), 180), DateTime(2026, 6, 30));
  });
}
