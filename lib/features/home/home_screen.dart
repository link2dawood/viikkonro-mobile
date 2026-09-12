import 'package:flutter/material.dart';
import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/business_days.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';
import '../calendar/month_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.repository, required this.today});
  final CalendarRepository repository;
  final DateTime today;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime selected = dateOnly(widget.today);
  @override
  Widget build(BuildContext context) {
    final now = dateOnly(widget.today), week = isoWeek(now), year = isoYear(now), s = context.s;
    final monday = mondayOf(week, year), sunday = sundayOf(week, year);
    final next = widget.repository.nextHoliday(now);
    final todayEvents = widget.repository.on(now);
    return PageBody(
      children: [
        Row(
          children: [
            Container(width: 24, height: 2, color: context.colors.primary),
            const SizedBox(width: 10),
            Flexible(child: Mono(s.eyebrow, size: 11, color: context.colors.primary)),
          ],
        ),
        const SizedBox(height: 14), PageHeading(s.homeTitle, subtitle: s.homeLead),
        SitePanel(
          child: LayoutBuilder(
            builder: (context, c) {
              final headline = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Mono(s.rightNow, size: 12), const SizedBox(height: 16),
                  // FP-H01/FP-A01: the week number stays the dominant element, but a
                  // long locale string or a 200% font scale shrinks it rather than
                  // pushing it off the edge of the card.
                  Semantics(
                    label: s.weekLabel(week),
                    button: true,
                    child: ExcludeSemantics(
                      child: InkWell(
                        // FP-H09: the dominant element is also the way into the year grid.
                        onTap: () => Navigator.pushNamed(context, '/vuosi-$year'),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                s.week,
                                style: TextStyle(fontFamily: 'Bricolage', fontSize: 28, fontWeight: FontWeight.w700, color: context.colors.primary),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '$week',
                                style: TextStyle(fontFamily: 'Bricolage', fontSize: 112, height: .95, letterSpacing: -5, fontWeight: FontWeight.w800, color: context.colors.onSurface),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Mono(context.headingDate(now), size: 14, weight: FontWeight.w500, color: context.colors.onSurface),
                  const SizedBox(height: 4), Mono(context.range(monday, sunday)),
                  // FP-H04 and FP-H05, in the monospace face the site uses for them.
                  const SizedBox(height: 4), Mono('${isoWeekLabel(now)} · ${s.dayOfYear} ${dayOfYear(now)} / ${daysInYear(now.year)}', size: 12),
                  // FP-H06: named when today is an observance, absent when it is not.
                  // No empty placeholder on the ordinary days, which are most of them.
                  if (todayEvents.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    for (final event in todayEvents)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Icon(
                              event.flag
                                  ? Icons.flag_outlined
                                  : event.official
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              size: 16,
                              color: context.colors.secondary,
                            ),
                            const SizedBox(width: 8),
                            Flexible(child: Text(event.name, style: Theme.of(context).textTheme.bodyLarge)),
                          ],
                        ),
                      ),
                  ],
                ],
              );
              final progress = WeekProgress(week: week, year: year);
              if (c.maxWidth > 650) {
                return Row(
                  children: [
                    Expanded(child: headline),
                    const SizedBox(width: 34),
                    Expanded(child: progress),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headline,
                  const Padding(padding: EdgeInsets.symmetric(vertical: 22), child: Divider(height: 1)),
                  progress,
                ],
              );
            },
          ),
        ),
        // FP-H08: a week either side, and the chips cross the year boundary
        // because each one resolves its own ISO week and year.
        const SizedBox(height: 14), Wrap(spacing: 7, runSpacing: 3, children: [for (var delta = -3; delta <= 3; delta++) _weekChip(context, addCalendarDays(now, delta * 7), delta == 0)]),
        // FP-H11 and FP-X01: the week, its span, and the matching site page.
        ResultActions(text: '${s.weekLabel(week)}/$year (${context.range(monday, sunday)})', url: SiteUrl.week(week, year)),
        const AdSlot(), SectionTitle(s.lookupTitle),
        SitePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateField(label: s.chooseDate, value: selected, onChanged: (d) => setState(() => selected = d)),
              const Divider(height: 32),
              Text(s.weekLabel(isoWeek(selected)), style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: context.colors.primary)),
              const SizedBox(height: 4),
              Mono('${isoWeekLabel(selected)} · ${context.weekday(selected)}'),
              const SizedBox(height: 8),
              Text(context.range(mondayOf(isoWeek(selected), isoYear(selected)), sundayOf(isoWeek(selected), isoYear(selected)))),
              TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/viikko-${isoWeek(selected)}-${isoYear(selected)}'),
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: Text(s.openWeek),
              ),
            ],
          ),
        ),
        SectionTitle(context.monthName(now.year, now.month)),
        SitePanel(
          child: MonthGrid(year: now.year, month: now.month, repository: widget.repository, today: now),
        ),
        TextButton(onPressed: () => Navigator.pushNamed(context, '/kuukausi-${now.month}-${now.year}'), child: Text(s.thisMonth)),
        if (next != null) ...[
          SectionTitle(s.nextHoliday),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.wb_sunny_outlined, color: context.colors.primary),
            title: Text(next.name),
            // FP-H07: the countdown is the reason people open this line at all.
            subtitle: Wrap(
              spacing: 8,
              children: [
                Mono(context.longDate(next.date), size: 12),
                Mono(daysBetween(now, next.date) == 0 ? s.today : s.dayCount(daysBetween(now, next.date)), size: 12, weight: FontWeight.w600, color: context.colors.primary),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/pyhapaivat-${next.date.year}'),
          ),
        ],
        SectionTitle(s.yearWeeks),
        Wrap(
          spacing: 8,
          children: [
            for (var y = now.year - 1; y <= now.year + 1; y++)
              if (y >= 2020 && y <= 2035) OutlinedButton(onPressed: () => Navigator.pushNamed(context, '/vuosi-$y'), child: Text('$y')),
          ],
        ),
        SectionTitle(s.info), Text(s.isoExplanation), TextButton(onPressed: () => Navigator.pushNamed(context, '/ukk'), child: Text(s.faq)),
      ],
    );
  }

  Widget _weekChip(BuildContext context, DateTime date, bool current) => ChoiceChip(
    selected: current,
    label: Text(context.s.weekShort(isoWeek(date)), style: const TextStyle(fontFamily: 'PlexMono', fontSize: 12)),
    onSelected: (_) => Navigator.pushNamed(context, '/viikko-${isoWeek(date)}-${isoYear(date)}'),
    showCheckmark: false,
  );
}
