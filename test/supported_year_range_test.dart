import 'package:flutter_test/flutter_test.dart';
import 'package:viikkonro/core/data/calendar_repository.dart';
import 'package:viikkonro/routing/deep_links.dart';

void main() {
  final now = DateTime(2026, 9, 19);

  test('calendar routes accept the complete 2025–2040 range', () {
    expect(CalendarRepository.minYear(now), 2025);
    expect(CalendarRepository.maxYear(now), 2040);
    expect(AppRoute.parse('/vuosi-2025', now).kind, 'weeks');
    expect(AppRoute.parse('/kalenteri-2040', now).kind, 'yearCalendar');
    expect(
      AppRoute.parse('/viikonpaiva?paiva=2025-01-01', now).date,
      DateTime(2025, 1, 1),
    );
    expect(
      AppRoute.parse('/viikonpaiva?paiva=2040-12-31', now).date,
      DateTime(2040, 12, 31),
    );
  });

  test('calendar route range rolls forward with the current year', () {
    final nextYear = DateTime(2027, 1, 1);

    expect(CalendarRepository.minYear(nextYear), 2026);
    expect(CalendarRepository.maxYear(nextYear), 2041);
    expect(AppRoute.parse('/vuosi-2026', nextYear).kind, 'weeks');
    expect(AppRoute.parse('/kalenteri-2041', nextYear).kind, 'yearCalendar');
    expect(AppRoute.parse('/vuosi-2025', nextYear).kind, 'notFound');
    expect(AppRoute.parse('/kalenteri-2042', nextYear).kind, 'notFound');
  });

  test('calendar routes reject years outside the bundled range', () {
    expect(AppRoute.parse('/vuosi-2024', now).kind, 'notFound');
    expect(AppRoute.parse('/kalenteri-2041', now).kind, 'notFound');
    expect(
      AppRoute.parse('/viikonpaiva?paiva=2024-12-31', now).kind,
      'notFound',
    );
    expect(
      AppRoute.parse('/viikonpaiva?paiva=2041-01-01', now).kind,
      'notFound',
    );
  });

  test('offline data includes both boundary years', () async {
    final repository = await CalendarRepository.load();
    final range = (repository.data['range'] as List).cast<int>();

    expect(range, [2020, 2100]);
    expect(repository.forYear(2020), isNotEmpty);
    expect(repository.forYear(2100), isNotEmpty);
    expect(repository.solar(DateTime(2020, 1, 1)), isNotNull);
    expect(repository.solar(DateTime(2100, 12, 31)), isNotNull);
  });
}
