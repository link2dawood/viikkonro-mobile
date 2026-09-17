import 'package:flutter/material.dart';
import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/business_days.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';

/// FP-L02 / FP-M07: one day, the week it belongs to, and what falls on it.
class DayScreen extends StatefulWidget {
  const DayScreen({
    super.key,
    required this.repository,
    required this.today,
    required this.date,
  });
  final CalendarRepository repository;
  final DateTime today, date;
  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  late DateTime date = dateOnly(widget.date);

  void _step(int days) {
    final next = addCalendarDays(date, days);
    if (next.year < CalendarRepository.minYear ||
        next.year > CalendarRepository.maxYear)
      return;
    setState(() => date = next);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final week = isoWeek(date), year = isoYear(date);
    final monday = mondayOf(week, year), sunday = sundayOf(week, year);
    final events = widget.repository.on(date);
    final solar = widget.repository.solar(date);
    final total = daysInYear(date.year), ordinal = dayOfYear(date);
    // The full FP-L02 sentence, which is also what copy and share hand over.
    final summary =
        '${context.weekday(date)}, ${s.weekLabel(week).toLowerCase()}/$year, ${context.range(monday, sunday)}';
    return Scaffold(
      appBar: AppBar(
        title: Text(s.dayDetails),
        actions: [
          IconButton(
            tooltip: s.previous,
            onPressed: () => _step(-1),
            icon: const Icon(Icons.chevron_left),
          ),
          IconButton(
            tooltip: s.next,
            onPressed: () => _step(1),
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
      body: PageBody(
        children: [
          SitePanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mono(
                  context.weekday(date).toUpperCase(),
                  size: 12,
                  color: context.colors.primary,
                ),
                const SizedBox(height: 10),
                Text(
                  context.longDate(date),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Mono(
                  '${isoWeekLabel(date)} · ${context.range(monday, sunday)}',
                ),
                const SizedBox(height: 20),
                StatRow([
                  (s.weekNumber, '$week'),
                  (s.dayOfYear, '$ordinal / $total'),
                  (s.daysRemaining, '${total - ordinal}'),
                  (s.quarter, '${(date.month + 2) ~/ 3}'),
                ]),
              ],
            ),
          ),
          ResultActions(
            text: '${context.longDate(date)} · $summary',
            url: SiteUrl.week(week, year),
          ),
          const AdSlot(),
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
                      minTileHeight: 56,
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
                        event.flag
                            ? s.flagDays
                            : event.official
                            ? s.official
                            : s.observance,
                        size: 12,
                      ),
                    ),
                ],
              ),
            ),
          if (solar != null) ...[
            SectionTitle(s.sun),
            SitePanel(child: _solar(context, solar)),
          ],
          SectionTitle(s.week),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              OutlinedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/viikko-$week-$year'),
                child: Text('${s.weekLabel(week)}/$year'),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/kuukausi-${date.month}-${date.year}',
                ),
                child: Text(context.monthName(date.year, date.month)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// FP-T16: polar day and polar night render as words, never as an empty time.
  Widget _solar(BuildContext context, Map<String, dynamic> solar) {
    final s = context.s;
    final minutes = solar['daylightMinutes'] as int;
    if (solar['polarDay'] == true || solar['polarNight'] == true) {
      return Row(
        children: [
          Icon(
            solar['polarDay'] == true
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined,
            color: context.colors.secondary,
          ),
          const SizedBox(width: 12),
          Text(
            solar['polarDay'] == true ? s.polarDay : s.polarNight,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      );
    }
    return StatRow([
      (s.sunrise, (solar['sunrise'] as String?) ?? '–'),
      (s.sunset, (solar['sunset'] as String?) ?? '–'),
      (s.daylight, s.hoursMinutes(minutes ~/ 60, minutes % 60)),
    ]);
  }
}
