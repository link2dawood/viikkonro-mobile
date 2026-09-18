import 'package:flutter/material.dart';

import '../../core/data/calendar_repository.dart';
import '../../core/date/iso_week.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';

/// FP-M01–FP-M05: a Monday-first month grid with an ISO week gutter.
class MonthGrid extends StatelessWidget {
  const MonthGrid({
    super.key,
    required this.year,
    required this.month,
    required this.repository,
    required this.today,
    this.compact = false,
  });
  final int year, month;
  final CalendarRepository repository;
  final DateTime today;
  final bool compact;

  /// Cells are a fixed height so the grid stays regular, which means the height
  /// has to follow the user's font scale or the numerals clip at 200% (FP-A01).
  double _cellHeight(BuildContext context) =>
      (compact ? 36.0 : 46.0) * MediaQuery.textScalerOf(context).scale(14) / 14;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(year, month, 1);
    // FP-M01: always Monday first, whatever the locale's own first weekday is.
    final start = addCalendarDays(first, 1 - first.weekday);
    final last = DateTime(year, month + 1, 0);
    final rows = ((first.weekday - 1 + last.day) / 7).ceil();
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 32,
              child: Mono(context.s.week, size: compact ? 9 : 10),
            ),
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Center(
                  child: Mono(
                    context.weekdayShort(DateTime(2026, 9, 14 + i)),
                    size: compact ? 10 : 11,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        for (var row = 0; row < rows; row++)
          _row(context, addCalendarDays(start, row * 7)),
      ],
    );
  }

  Widget _row(BuildContext context, DateTime monday) {
    final week = isoWeek(monday), weekYear = isoYear(monday);
    return Row(
      children: [
        // FP-M02: the gutter carries the ISO week year, so a January row that
        // still belongs to week 52 of the previous year links to the right week.
        SizedBox(
          width: 32,
          child: Semantics(
            button: true,
            label: context.s.weekLabel(week),
            child: ExcludeSemantics(
              child: InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, '/viikko-$week-$weekYear'),
                child: SizedBox(
                  height: _cellHeight(context),
                  child: Center(
                    child: Mono('$week', size: 12, weight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ),
        for (var day = 0; day < 7; day++)
          Expanded(child: _day(context, addCalendarDays(monday, day))),
      ],
    );
  }

  Widget _day(BuildContext context, DateTime date) {
    final inMonth = date.month == month && date.year == year;
    final current =
        date == dateOnly(today) && inMonth; // FP-M03: current month only.
    final events = repository.on(date);
    final holiday = events.any((e) => !e.flag);
    final flag = events.any((e) => e.flag);
    final label = [
      context.headingDate(date),
      if (holiday || flag) ...events.map((e) => e.name),
    ].join(', ');
    return Semantics(
      label: label,
      button: true,
      selected: current,
      child: ExcludeSemantics(
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          // FP-M05: days from the neighbouring month move the grid, not the day.
          onTap: () => inMonth
              ? Navigator.pushNamed(
                  context,
                  '/viikonpaiva?paiva=${formatDate(date)}',
                )
              : Navigator.pushNamed(
                  context,
                  '/kuukausi-${date.month}-${date.year}',
                ),
          child: Container(
            height: _cellHeight(context),
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: holiday && inMonth
                  ? context.colors.secondary.withValues(alpha: .13)
                  : null,
              // FP-M03: today is ringed, not filled, so its date stays readable.
              border: current
                  ? Border.all(color: context.colors.primary, width: 2)
                  : null,
            ),
            // A seven-column grid cannot grow sideways, so at a large font
            // scale the cell scales its contents down rather than clip them.
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontFamily: 'PlexMono',
                      fontSize: compact ? 12 : 14,
                      fontWeight: current || holiday
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: inMonth
                          ? context.colors.onSurface
                          : context.colors.onSurfaceVariant.withValues(
                              alpha: .42,
                            ),
                    ),
                  ),
                  // FP-M04 / FP-A05: a holiday is a bar, a flag day is a dot. Two
                  // distinct shapes, so neither depends on colour to be read.
                  if ((holiday || flag) && inMonth)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (holiday)
                            Container(
                              width: 9,
                              height: 2.5,
                              decoration: BoxDecoration(
                                color: context.colors.secondary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          if (holiday && flag) const SizedBox(width: 3),
                          if (flag)
                            Container(
                              width: 3.5,
                              height: 3.5,
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
