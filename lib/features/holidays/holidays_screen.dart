import 'package:flutter/material.dart';
import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/business_days.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';

/// FP-P01–FP-P05 plus the school holiday listing and its confidence tiers.
class HolidaysScreen extends StatefulWidget {
  const HolidaysScreen({super.key, required this.repository, required this.today, required this.year, this.tab = 0});
  final CalendarRepository repository;
  final DateTime today;
  final int year, tab;
  @override
  State<HolidaysScreen> createState() => _HolidaysScreenState();
}

class _HolidaysScreenState extends State<HolidaysScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 3, vsync: this, initialIndex: widget.tab);
  late int year = widget.year;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  String _url() => switch (_tabs.index) {
    1 => SiteUrl.flags(year),
    2 => SiteUrl.school(year),
    _ => SiteUrl.holidays(year),
  };

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    return Scaffold(
      appBar: AppBar(
        title: Text(s.holidays),
        actions: [IconButton(tooltip: s.openWebsite, onPressed: () => openUrl(context, _url()), icon: const Icon(Icons.open_in_new_rounded))],
        bottom: TabBar(
          controller: _tabs,
          onTap: (_) => setState(() {}),
          tabs: [
            Tab(text: s.holidays),
            Tab(text: s.flagDays),
            Tab(text: s.schoolHolidays),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: YearStepper(year: year, onChanged: (value) => setState(() => year = value)),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: [
                  _EventList(repository: widget.repository, today: widget.today, year: year, flags: false),
                  _EventList(repository: widget.repository, today: widget.today, year: year, flags: true),
                  _SchoolList(repository: widget.repository, year: year),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  const _EventList({required this.repository, required this.today, required this.year, required this.flags});
  final CalendarRepository repository;
  final DateTime today;
  final int year;
  final bool flags;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final now = dateOnly(today);
    final entries = repository.forYear(year, flags: flags);
    if (entries.isEmpty) return Center(child: Mono(s.noEvents));
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
      itemCount: entries.length + 1,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        if (index == entries.length) return const Padding(padding: EdgeInsets.only(top: 18), child: AdSlot());
        final event = entries[index];
        final date = dateOnly(event.date);
        final past = date.isBefore(now);
        final weekend = date.weekday >= DateTime.saturday;
        final countdown = daysBetween(now, date);
        return Opacity(
          // FP-P03: entries already gone this year stay visible, just dimmed.
          opacity: past ? .5 : 1,
          child: ListTile(
            minTileHeight: 64,
            leading: SizedBox(
              width: 48,
              child: Center(
                child: Mono('${date.day}.${date.month}.', size: 14, weight: FontWeight.w700, color: weekend ? context.colors.secondary : context.colors.onSurface),
              ),
            ),
            title: Text(event.name),
            // Wrapping rather than a Row, so a longer translation or a large
            // font scale pushes the line down instead of off the tile.
            subtitle: Wrap(
              spacing: 6,
              runSpacing: 2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Mono(
                  '${context.weekdayShort(date)} · ${s.weekLabel(isoWeek(date))} · ${flags
                      ? s.flagDays
                      : event.official
                      ? s.official
                      : s.observance}',
                  size: 12,
                ),
                // FP-P05: a holiday landing on a weekend is the thing people check.
                if (weekend && !flags) Icon(Icons.weekend_outlined, size: 14, color: context.colors.secondary),
              ],
            ),
            trailing: past ? null : Mono(countdown == 0 ? s.today : s.dayCount(countdown), size: 12, weight: FontWeight.w600, color: context.colors.primary),
            onTap: () => Navigator.pushNamed(context, '/viikonpaiva?paiva=${formatDate(date)}'),
          ),
        );
      },
    );
  }
}

class _SchoolList extends StatelessWidget {
  const _SchoolList({required this.repository, required this.year});
  final CalendarRepository repository;
  final int year;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final periods = repository.schoolPeriods.where((p) => p.year == year).toList()..sort((a, b) => (a.start ?? DateTime(year)).compareTo(b.start ?? DateTime(year)));
    if (periods.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.noSchoolData, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            Mono(s.dataCoverage),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
      children: [
        Mono(s.schoolCoverage),
        const SizedBox(height: 14),
        for (final period in periods)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SitePanel(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The badge must never be pushed off the card: FP-D08 says the
                  // confidence tier is always visible, at any font scale.
                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(period.kind == 'winter' ? s.winterBreak : s.autumnBreak, style: Theme.of(context).textTheme.titleLarge),
                      ConfidenceBadge(period.confidence),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (period.start != null && period.end != null) Text(context.range(period.start!, period.end!), style: Theme.of(context).textTheme.bodyLarge) else Mono(s.unknown),
                  const SizedBox(height: 8),
                  Mono('${s.city}: ${period.cities.join(', ')}', size: 12),
                  if (period.sourceKey != null) ...[const SizedBox(height: 6), _source(context, period.sourceKey!)],
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _source(BuildContext context, String key) {
    final source = (repository.data['schoolHolidaySources'] as Map<String, dynamic>)[key] as Map<String, dynamic>?;
    if (source == null) return const SizedBox.shrink();
    final verified = source['verifiedAt'] as String?;
    return Wrap(
      spacing: 10,
      runSpacing: 2,
      children: [Mono('${context.s.source}: ${source['label'] ?? source['source']}', size: 11), if (verified != null) Mono(context.s.verifiedAt(verified), size: 11)],
    );
  }
}

/// FP-D08: the confidence tier travels with the entry and is always rendered.
class ConfidenceBadge extends StatelessWidget {
  const ConfidenceBadge(this.confidence, {super.key});
  final String confidence;
  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final (label, color, icon) = switch (confidence) {
      'confirmed' => (s.confirmed, context.colors.primary, Icons.check_circle_outline_rounded),
      'estimated' => (s.estimated, context.colors.secondary, Icons.help_outline_rounded),
      _ => (s.unknown, context.colors.onSurfaceVariant, Icons.remove_circle_outline_rounded),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Mono(label, size: 11, weight: FontWeight.w600, color: color),
        ],
      ),
    );
  }
}
