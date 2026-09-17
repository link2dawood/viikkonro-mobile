import 'iso_week.dart';

int daysBetween(DateTime a, DateTime b) =>
    (dateOnly(b).difference(dateOnly(a)).inMilliseconds /
            Duration.millisecondsPerDay)
        .round()
        .abs();
int dayOfYear(DateTime d) => daysBetween(DateTime(d.year, 1, 1), d) + 1;
int daysInYear(int year) =>
    daysBetween(DateTime(year, 1, 1), DateTime(year + 1, 1, 1));
int usWeekNumber(DateTime input) {
  final date = dateOnly(input);
  final jan1 = DateTime(date.year, 1, 1);
  final firstSunday = addCalendarDays(jan1, -(jan1.weekday % 7));
  return daysBetween(firstSunday, date) ~/ 7 + 1;
}

class WorkingDayCount {
  const WorkingDayCount(this.working, this.weekend, this.holidays, this.total);
  final int working;
  final int weekend;
  final int holidays;
  final int total;
}

/// Website semantics: both boundaries included; weekends take precedence so
/// a public holiday on a weekend is never subtracted twice. Eves are working days.
WorkingDayCount countWorkingDays(
  DateTime from,
  DateTime to, {
  required bool Function(DateTime) isHoliday,
}) {
  final start = dateOnly(from);
  final end = dateOnly(to);
  if (end.isBefore(start)) throw ArgumentError('End date precedes start date');
  var working = 0, weekend = 0, holidays = 0, total = 0;
  for (var d = start; !d.isAfter(end); d = addCalendarDays(d, 1)) {
    total++;
    if (d.weekday >= DateTime.saturday) {
      weekend++;
    } else if (isHoliday(d)) {
      holidays++;
    } else {
      working++;
    }
  }
  return WorkingDayCount(working, weekend, holidays, total);
}

bool isWeekend(DateTime date) => dateOnly(date).weekday >= DateTime.saturday;

/// Monday to Friday inside the span, both ends included, holidays ignored.
int weekdaysBetween(DateTime from, DateTime to, {bool inclusive = true}) {
  final counts = countWorkingDays(
    from,
    inclusive ? to : addCalendarDays(to, -1),
    isHoliday: (_) => false,
  );
  return counts.total - counts.weekend;
}

/// The public holidays a working-day count drops, so the app can name them
/// rather than leave the user to work out where the missing days went (FP-T03).
List<DateTime> workdayHolidaysBetween(
  DateTime from,
  DateTime to, {
  required bool Function(DateTime) isHoliday,
}) {
  final start = dateOnly(from);
  final end = dateOnly(to);
  final found = <DateTime>[];
  for (var d = start; !d.isAfter(end); d = addCalendarDays(d, 1)) {
    if (!isWeekend(d) && isHoliday(d)) found.add(d);
  }
  return found;
}

/// Inclusive first and last day of the month, quarter or year around [date].
(DateTime, DateTime) monthBounds(DateTime date) {
  final d = dateOnly(date);
  return (DateTime(d.year, d.month, 1), DateTime(d.year, d.month + 1, 0));
}

(DateTime, DateTime) quarterBounds(DateTime date) {
  final d = dateOnly(date);
  final quarter = (d.month + 2) ~/ 3;
  return (
    DateTime(d.year, quarter * 3 - 2, 1),
    DateTime(d.year, quarter * 3 + 1, 0),
  );
}

(DateTime, DateTime) yearBounds(DateTime date) {
  final d = dateOnly(date);
  return (DateTime(d.year, 1, 1), DateTime(d.year, 12, 31));
}
