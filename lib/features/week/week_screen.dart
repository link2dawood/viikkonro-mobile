import 'package:flutter/material.dart';
import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/business_days.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';

/// FP-L04 / FP-Y07: one week, its seven days, and the observances on them.
class WeekScreen extends StatefulWidget {
  const WeekScreen({super.key, required this.repository, required this.today, required this.week, required this.year});
  final CalendarRepository repository;
  final DateTime today;
  final int week, year;
  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  late int week = widget.week, year = widget.year;

  /// Stepping through the week's own Monday keeps the year boundary correct:
  /// week 1 of the next ISO year follows week 52 or 53 without a special case.
  void _step(int weeks) {
    final monday = addCalendarDays(mondayOf(week, year), weeks * 7);
    if (monday.year < CalendarRepository.minYear || monday.year > CalendarRepository.maxYear) return;
    setState(() {
      week = isoWeek(monday);
      year = isoYear(monday);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final monday = mondayOf(week, year), sunday = sundayOf(week, year);
    final days = [for (var i = 0; i < 7; i++) addCalendarDays(monday, i)];
    final summary = '${s.weekLabel(week)}/$year (${context.range(monday, sunday)})';
    return Scaffold(
      appBar: AppBar(
        title: Text('${s.weekLabel(week)}/$year'),
        actions: [
          IconButton(tooltip: s.previous, onPressed: () => _step(-1), icon: const Icon(Icons.chevron_left)),
          IconButton(tooltip: s.next, onPressed: () => _step(1), icon: const Icon(Icons.chevron_right)),
        ],
      ),
      body: PageBody(
        children: [
          SitePanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mono(s.weekRange, size: 12),
                const SizedBox(height: 12),
                Semantics(
                  label: '${s.weekLabel(week)} $year',
                  // FP-A01: at a large font scale the numeral shrinks to fit
                  // instead of running off the edge of the card.
                  child: ExcludeSemantics(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$week',
                            style: TextStyle(fontFamily: 'Bricolage', fontSize: 82, height: .95, letterSpacing: -3, fontWeight: FontWeight.w800, color: context.colors.onSurface),
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Mono('/ $year', size: 20, weight: FontWeight.w600, color: context.colors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(context.range(monday, sunday), style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Mono(isoWeekLabel(monday)),
                const SizedBox(height: 18),
                WeekProgress(week: week, year: year),
              ],
            ),
          ),
          ResultActions(text: summary, url: SiteUrl.week(week, year)),
          const AdSlot(),
          SectionTitle(s.weekRange),
          SitePanel(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [for (final day in days) DayRow(date: day, repository: widget.repository, today: widget.today)],
            ),
          ),
          SectionTitle(context.monthName(sunday.year, sunday.month)),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              OutlinedButton(onPressed: () => Navigator.pushNamed(context, '/kuukausi-${monday.month}-${monday.year}'), child: Text(context.monthName(monday.year, monday.month))),
              if (sunday.month != monday.month)
                OutlinedButton(onPressed: () => Navigator.pushNamed(context, '/kuukausi-${sunday.month}-${sunday.year}'), child: Text(context.monthName(sunday.year, sunday.month))),
              OutlinedButton(onPressed: () => Navigator.pushNamed(context, '/vuosi-$year'), child: Text(s.yearLabel(year))),
            ],
          ),
        ],
      ),
    );
  }
}

/// A single day inside a week listing. Observances carry an icon as well as a
/// colour so the distinction survives greyscale and colour blindness (FP-A05).
class DayRow extends StatelessWidget {
  const DayRow({super.key, required this.date, required this.repository, required this.today});
  final DateTime date;
  final CalendarRepository repository;
  final DateTime today;
  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final events = repository.on(date);
    final holiday = repository.isHoliday(date);
    final weekend = date.weekday >= DateTime.saturday;
    final current = date == dateOnly(today);
    return ListTile(
      minTileHeight: 56,
      selected: current,
      selectedTileColor: context.colors.primary.withValues(alpha: .08),
      leading: SizedBox(
        width: 42,
        child: Mono(context.weekdayShort(date), size: 12, weight: FontWeight.w600, color: holiday || weekend ? context.colors.secondary : null),
      ),
      title: Text(context.longDate(date), style: TextStyle(fontWeight: current ? FontWeight.w700 : FontWeight.w400)),
      subtitle: events.isEmpty
          ? Mono('${s.dayOfYear} ${dayOfYear(date)}', size: 12)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final event in events)
                  Row(
                    children: [
                      Icon(
                        event.flag
                            ? Icons.flag_outlined
                            : event.official
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        size: 14,
                        color: context.colors.secondary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(child: Text(event.name, style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  ),
              ],
            ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, '/viikonpaiva?paiva=${formatDate(date)}'),
    );
  }
}
