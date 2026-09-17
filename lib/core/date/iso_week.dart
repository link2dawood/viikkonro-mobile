/// A local civil date. Inputs are interpreted by their displayed year/month/day;
/// callers with a UTC instant should call toLocal() before passing it here.
DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

/// Calendar arithmetic, matching JavaScript Date.setDate. Adding 24-hour
/// durations to local midnights can land on the wrong date across DST.
DateTime addCalendarDays(DateTime input, int days) {
  final date = dateOnly(input);
  return DateTime(date.year, date.month, date.day + days);
}

int isoYear(DateTime input) {
  final date = dateOnly(input);
  return addCalendarDays(date, DateTime.thursday - date.weekday).year;
}

/// Mirrors the website's Thursday-based algorithm using calendar-day shifts.
int isoWeek(DateTime input) {
  final date = dateOnly(input);
  final thursday = addCalendarDays(date, DateTime.thursday - date.weekday);
  final january = DateTime(thursday.year, 1, 1);
  final firstThursday = addCalendarDays(
    january,
    (DateTime.thursday - january.weekday + 7) % 7,
  );
  // Preserve the fraction until rounding, as dateUtils.js does. Truncating
  // elapsed days here would throw away the daylight-saving offset.
  return 1 +
      (thursday.difference(firstThursday).inMilliseconds /
              (Duration.millisecondsPerDay * 7))
          .round();
}

int weeksInIsoYear(int year) => isoWeek(DateTime(year, 12, 28));

DateTime mondayOf(int week, int year) {
  RangeError.checkValueInInterval(week, 1, weeksInIsoYear(year), 'week');
  final january4 = DateTime(year, 1, 4);
  return addCalendarDays(january4, 1 - january4.weekday + (week - 1) * 7);
}

DateTime sundayOf(int week, int year) =>
    addCalendarDays(mondayOf(week, year), 6);

String formatDate(DateTime input) {
  final date = dateOnly(input);
  return '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}

String isoWeekLabel(DateTime date) =>
    '${isoYear(date)}-W${isoWeek(date).toString().padLeft(2, '0')}';
