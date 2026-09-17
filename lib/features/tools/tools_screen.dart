import 'package:flutter/material.dart';
import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/business_days.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';

/// FP-T01–FP-T05 and FP-T17: the two day calculators that ship in 1.0.
class ToolsScreen extends StatefulWidget {
  const ToolsScreen({
    super.key,
    required this.repository,
    required this.today,
    this.tab = 0,
    this.embedded = false,
  });
  final CalendarRepository repository;
  final DateTime today;
  final int tab;
  final bool embedded;
  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(
    length: 2,
    vsync: this,
    initialIndex: widget.tab,
  );

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final body = SafeArea(
      top: false,
      child: Column(
        children: [
          TabBar(
            controller: _tabs,
            tabs: [
              Tab(text: s.daysBetween),
              Tab(text: s.workingDaysBetween),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _DaysBetween(
                  repository: widget.repository,
                  today: widget.today,
                ),
                _WorkdaysRemaining(
                  repository: widget.repository,
                  today: widget.today,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    if (widget.embedded) return body;
    return Scaffold(
      appBar: AppBar(title: Text(s.tools)),
      body: body,
    );
  }
}

class _DaysBetween extends StatefulWidget {
  const _DaysBetween({required this.repository, required this.today});
  final CalendarRepository repository;
  final DateTime today;
  @override
  State<_DaysBetween> createState() => _DaysBetweenState();
}

class _DaysBetweenState extends State<_DaysBetween> {
  late DateTime from = dateOnly(widget.today);
  late DateTime to = addCalendarDays(widget.today, 30);
  bool inclusive = true;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    // FP-T01: order never matters; the result is a distance.
    final start = from.isAfter(to) ? to : from;
    final end = from.isAfter(to) ? from : to;
    // FP-T02: dropping the last day is exactly one day of difference.
    final last = inclusive ? end : addCalendarDays(end, -1);
    final empty = last.isBefore(start);
    final counts = empty
        ? const WorkingDayCount(0, 0, 0, 0)
        : countWorkingDays(start, last, isHoliday: widget.repository.isHoliday);
    final excluded = empty
        ? <DateTime>[]
        : workdayHolidaysBetween(
            start,
            last,
            isHoliday: widget.repository.isHoliday,
          );
    final weeks = counts.total ~/ 7, spare = counts.total % 7;
    final summary =
        '${context.shortDate(start)} – ${context.shortDate(end)}: '
        '${s.dayCount(counts.total)}, ${counts.total - counts.weekend} ${s.weekdayHolidays.toLowerCase()}, ${counts.working} ${s.workingDays.toLowerCase()}';
    return PageBody(
      children: [
        SitePanel(
          child: Column(
            children: [
              DateField(
                label: s.firstDate,
                value: from,
                onChanged: (value) => setState(() => from = dateOnly(value)),
              ),
              const SizedBox(height: 16),
              DateField(
                label: s.lastDate,
                value: to,
                onChanged: (value) => setState(() => to = dateOnly(value)),
              ),
              const Divider(height: 30),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: inclusive,
                onChanged: (value) => setState(() => inclusive = value),
                title: Text(s.lastDate),
                subtitle: Mono(
                  inclusive ? s.totalDays : s.distanceNote,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // FP-T01: three results, always all three.
        SitePanel(
          child: StatRow([
            (s.totalDays, '${counts.total}'),
            (s.workingDays, '${counts.working}'),
            (s.weekends, '${counts.weekend}'),
            (s.weekdayHolidays, '${counts.holidays}'),
          ]),
        ),
        const SizedBox(height: 12),
        Mono(s.weekDaysResult(weeks, spare)),
        ResultActions(text: summary, url: SiteUrl.path('paivien-erotus')),
        const AdSlot(),
        // FP-T03: name the days that were taken out of the working-day figure.
        SectionTitle(s.weekdayHolidays),
        if (excluded.isEmpty)
          SitePanel(child: Mono(s.noEvents))
        else
          SitePanel(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                for (final date in excluded)
                  ListTile(
                    minTileHeight: 48,
                    dense: true,
                    leading: Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: context.colors.secondary,
                    ),
                    title: Text(
                      widget.repository
                          .on(date)
                          .where((e) => !e.flag)
                          .map((e) => e.name)
                          .join(', '),
                    ),
                    subtitle: Mono(
                      '${context.weekday(date)} ${context.shortDate(date)}',
                      size: 11,
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 14),
        Mono(s.workingNote, size: 12),
      ],
    );
  }
}

class _WorkdaysRemaining extends StatelessWidget {
  const _WorkdaysRemaining({required this.repository, required this.today});
  final CalendarRepository repository;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final now = dateOnly(today);
    final periods = <(String, (DateTime, DateTime))>[
      (s.thisMonth, monthBounds(now)),
      (s.quarterLabel((now.month + 2) ~/ 3), quarterBounds(now)),
      (s.thisYear, yearBounds(now)),
    ];
    return PageBody(
      children: [
        SitePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Mono(
                s.today.toUpperCase(),
                size: 11,
                color: context.colors.primary,
              ),
              const SizedBox(height: 8),
              Text(
                context.headingDate(now),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Mono(
                '${isoWeekLabel(now)} · ${s.dayOfYear} ${dayOfYear(now)} / ${daysInYear(now.year)}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        for (final (label, bounds) in periods)
          _period(context, label, bounds.$1, bounds.$2, now),
        const AdSlot(),
        const SizedBox(height: 14),
        Mono(s.workingNote, size: 12),
      ],
    );
  }

  /// FP-T04/FP-T05: total, elapsed and remaining for each period, with the
  /// `14 / 21 työpäivää` reading the spec asks for.
  Widget _period(
    BuildContext context,
    String label,
    DateTime start,
    DateTime end,
    DateTime now,
  ) {
    final s = context.s;
    final total = countWorkingDays(
      start,
      end,
      isHoliday: repository.isHoliday,
    ).working;
    final elapsed = now.isBefore(start)
        ? 0
        : countWorkingDays(
            start,
            now.isAfter(end) ? end : now,
            isHoliday: repository.isHoliday,
          ).working;
    final remaining = total - elapsed;
    final summary = '$elapsed / $total ${s.workingDays.toLowerCase()}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SitePanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(label, style: Theme.of(context).textTheme.titleLarge),
                Mono(context.range(start, end), size: 11),
              ],
            ),
            const SizedBox(height: 12),
            Semantics(
              label: '$label, $summary',
              child: ExcludeSemantics(
                child: Column(
                  children: [
                    // The `14 / 21 työpäivää` reading stays on one baseline and
                    // shrinks to fit rather than spilling out of the card.
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$elapsed',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: context.colors.primary),
                          ),
                          Mono(
                            ' / $total ${s.workingDays.toLowerCase()}',
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: total == 0 ? 0 : elapsed / total,
                        minHeight: 6,
                        backgroundColor: context.colors.outlineVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Mono('${s.daysRemaining}: $remaining'),
            ResultActions(
              text: '$label — $summary',
              url: SiteUrl.path('tyopaivalaskuri'),
            ),
          ],
        ),
      ),
    );
  }
}
