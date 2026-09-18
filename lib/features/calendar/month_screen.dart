import 'package:flutter/material.dart';

import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/business_days.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';
import 'month_grid.dart';

/// FP-M01–FP-M07: the month view and its navigation.
class MonthScreen extends StatefulWidget {
  const MonthScreen({
    super.key,
    required this.repository,
    required this.today,
    required this.year,
    required this.month,
    this.embedded = false,
  });
  final CalendarRepository repository;
  final DateTime today;
  final int year, month;
  final bool embedded;
  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  late DateTime shown = DateTime(widget.year, widget.month);

  /// FP-M06: stepping through the date constructor rolls the year over for us.
  void _step(int months) {
    final next = DateTime(shown.year, shown.month + months);
    if (next.year < CalendarRepository.minYear ||
        next.year > CalendarRepository.maxYear)
      return;
    setState(() => shown = next);
  }

  Future<void> _pick() async {
    final chosen = await showDialog<DateTime>(
      context: context,
      builder: (context) => _MonthPicker(initial: shown),
    );
    if (chosen != null) setState(() => shown = chosen);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final first = DateTime(shown.year, shown.month, 1);
    final last = DateTime(shown.year, shown.month + 1, 0);
    final counts = countWorkingDays(
      first,
      last,
      isHoliday: widget.repository.isHoliday,
    );
    final events = widget.repository.events
        .where((e) => e.date.year == shown.year && e.date.month == shown.month)
        .toList();
    final title = context.monthName(shown.year, shown.month);
    final body = PageBody(
      children: [
        Row(
          children: [
            IconButton(
              tooltip: s.previous,
              onPressed: () => _step(-1),
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Center(
                child: TextButton(
                  onPressed: _pick,
                  child: Text(
                    '$title ${shown.year}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: s.next,
              onPressed: () => _step(1),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SitePanel(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
          child: MonthGrid(
            year: shown.year,
            month: shown.month,
            repository: widget.repository,
            today: widget.today,
          ),
        ),
        const SizedBox(height: 12),
        const MarkerLegend(),
        ResultActions(
          text: '$title ${shown.year}',
          url: SiteUrl.month(shown.month, shown.year),
        ),
        const AdSlot(),
        SectionTitle(s.monthWorkingDays),
        SitePanel(
          child: StatRow([
            (s.workingDays, '${counts.working}'),
            (s.weekends, '${counts.weekend}'),
            (s.weekdayHolidays, '${counts.holidays}'),
            (s.totalDays, '${counts.total}'),
          ]),
        ),
        SectionTitle(events.isEmpty ? s.noEvents : s.holidays),
        if (events.isEmpty)
          SitePanel(child: Mono(s.noEvents))
        else
          SitePanel(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                for (final event in events)
                  ListTile(
                    minTileHeight: 52,
                    leading: Icon(
                      event.flag
                          ? Icons.flag_outlined
                          : event.official
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: context.colors.secondary,
                    ),
                    title: Text(event.name),
                    subtitle: Mono(
                      '${context.weekday(event.date)} ${context.shortDate(event.date)} · ${s.weekLabel(isoWeek(event.date))}',
                      size: 12,
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/viikonpaiva?paiva=${formatDate(event.date)}',
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
    if (widget.embedded) return body;
    return Scaffold(
      appBar: AppBar(title: Text(s.calendar)),
      body: body,
    );
  }
}

/// Spelling out what the grid's shapes mean, so the markers are never a guess.
class MarkerLegend extends StatelessWidget {
  const MarkerLegend({super.key});
  @override
  Widget build(BuildContext context) {
    final s = context.s;
    // A Wrap gives its children unbounded width, so a long label would run off
    // the row rather than wrap. Capping each entry at the container width is
    // what keeps the legend readable in every language.
    return LayoutBuilder(
      builder: (context, constraints) => Wrap(
        spacing: 18,
        runSpacing: 8,
        children:
            [
                  _entry(
                    context,
                    Container(
                      width: 9,
                      height: 2.5,
                      decoration: BoxDecoration(
                        color: context.colors.secondary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    s.holidays,
                  ),
                  _entry(
                    context,
                    Container(
                      width: 3.5,
                      height: 3.5,
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    s.flagDays,
                  ),
                  _entry(
                    context,
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: context.colors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    s.today,
                  ),
                ]
                .map(
                  (entry) => ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                    child: entry,
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _entry(BuildContext context, Widget marker, String label) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(width: 14, child: Center(child: marker)),
      const SizedBox(width: 6),
      Flexible(child: Mono(label, size: 11, maxLines: 2)),
    ],
  );
}

class _MonthPicker extends StatefulWidget {
  const _MonthPicker({required this.initial});
  final DateTime initial;
  @override
  State<_MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<_MonthPicker> {
  late int year = widget.initial.year;
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(context.s.month),
    content: SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          YearStepper(
            year: year,
            onChanged: (value) => setState(() => year = value),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (var month = 1; month <= 12; month++)
                ChoiceChip(
                  selected:
                      year == widget.initial.year &&
                      month == widget.initial.month,
                  showCheckmark: false,
                  label: Text(context.monthName(year, month)),
                  onSelected: (_) =>
                      Navigator.pop(context, DateTime(year, month)),
                ),
            ],
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(context.s.cancel),
      ),
    ],
  );
}
