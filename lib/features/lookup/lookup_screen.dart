import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/business_days.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';
import '../week/week_screen.dart' show DayRow;

/// FP-L01–FP-L07: date to week, and week to dates.
class LookupScreen extends StatefulWidget {
  const LookupScreen({
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
  State<LookupScreen> createState() => _LookupScreenState();
}

class _LookupScreenState extends State<LookupScreen>
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
              Tab(text: s.dateToWeek),
              Tab(text: s.weekToDate),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _DateToWeek(repository: widget.repository, today: widget.today),
                _WeekToDate(repository: widget.repository, today: widget.today),
              ],
            ),
          ),
        ],
      ),
    );
    if (widget.embedded) return body;
    return Scaffold(
      appBar: AppBar(title: Text(s.lookupTitle)),
      body: body,
    );
  }
}

class _DateToWeek extends StatefulWidget {
  const _DateToWeek({required this.repository, required this.today});
  final CalendarRepository repository;
  final DateTime today;
  @override
  State<_DateToWeek> createState() => _DateToWeekState();
}

class _DateToWeekState extends State<_DateToWeek> {
  late DateTime selected = dateOnly(widget.today); // FP-L01: defaults to today.

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final week = isoWeek(selected), year = isoYear(selected);
    final monday = mondayOf(week, year), sunday = sundayOf(week, year);
    // FP-L02: weekday, week, ISO year and the full span, in one sentence.
    final summary =
        '${context.weekday(selected)}, ${s.weekLabel(week).toLowerCase()}/$year, ${context.range(monday, sunday)}';
    return PageBody(
      children: [
        SitePanel(
          child: DateField(
            label: s.chooseDate,
            value: selected,
            onChanged: (value) => setState(() => selected = dateOnly(value)),
          ),
        ),
        const SizedBox(height: 14),
        SitePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.weekLabel(week),
                style: Theme.of(context).textTheme.headlineLarge
                    ?.copyWith(color: context.colors.primary),
              ),
              const SizedBox(height: 6),
              Text(summary, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 10),
              Mono(isoWeekLabel(selected)),
              const SizedBox(height: 18),
              StatRow([
                (s.weekNumber, '$week'),
                (s.year, '$year'),
                (
                  s.dayOfYear,
                  '${dayOfYear(selected)} / ${daysInYear(selected.year)}',
                ),
                (s.quarter, '${(selected.month + 2) ~/ 3}'),
              ]),
            ],
          ),
        ),
        ResultActions(
          text: '${context.longDate(selected)} · $summary',
          url: SiteUrl.week(week, year),
        ),
        const AdSlot(),
        TextButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/viikko-$week-$year'),
          icon: const Icon(Icons.arrow_forward, size: 18),
          label: Text(s.openWeek),
        ),
      ],
    );
  }
}

class _WeekToDate extends StatefulWidget {
  const _WeekToDate({required this.repository, required this.today});
  final CalendarRepository repository;
  final DateTime today;
  @override
  State<_WeekToDate> createState() => _WeekToDateState();
}

class _WeekToDateState extends State<_WeekToDate> {
  // FP-L05: the week maths is valid well beyond the bundled dataset.
  static const minYear = 1900, maxYear = 2100;
  late int week = isoWeek(widget.today);
  late int year = isoYear(widget.today);
  late final TextEditingController _year = TextEditingController(text: '$year');
  String? _error;

  @override
  void dispose() {
    _year.dispose();
    super.dispose();
  }

  void _setYear(String raw) {
    final value = int.tryParse(raw);
    setState(() {
      if (value == null || value < minYear || value > maxYear) {
        _error = context.s.outOfRange;
        return;
      }
      year = value;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final total = weeksInIsoYear(year);
    // FP-L03: week 53 of a 52-week year is reported, never thrown.
    final valid = _error == null && week >= 1 && week <= total;
    final bundled =
        year >= CalendarRepository.minYear &&
        year <= CalendarRepository.maxYear;
    return PageBody(
      children: [
        SitePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Mono(s.weekNumber),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    tooltip: s.previous,
                    onPressed: week > 1 ? () => setState(() => week--) : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '$week',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: s.next,
                    onPressed: week < 53 ? () => setState(() => week++) : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Slider(
                value: week.toDouble(),
                min: 1,
                max: 53,
                divisions: 52,
                label: '$week',
                onChanged: (value) => setState(() => week = value.round()),
              ),
              const SizedBox(height: 10),
              Mono(s.year),
              const SizedBox(height: 8),
              TextField(
                controller: _year,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: _setYear,
                decoration: InputDecoration(
                  errorText: _error,
                  suffixText: '$minYear–$maxYear',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (!valid)
          SitePanel(
            child: Row(
              children: [
                Icon(Icons.info_outline, color: context.colors.secondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _error ?? s.weekOf(total, total),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          )
        else
          ..._result(context, week, year, total, bundled),
      ],
    );
  }

  List<Widget> _result(
    BuildContext context,
    int week,
    int year,
    int total,
    bool bundled,
  ) {
    final s = context.s;
    final monday = mondayOf(week, year), sunday = sundayOf(week, year);
    final summary =
        '${s.weekLabel(week)}/$year (${context.range(monday, sunday)})';
    return [
      SitePanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.range(monday, sunday),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),
            Mono(
              '$year-W${week.toString().padLeft(2, '0')} · ${s.weekOf(week, total)}',
            ),
          ],
        ),
      ),
      ResultActions(text: summary, url: SiteUrl.week(week, year)),
      const AdSlot(),
      // FP-L05: outside the bundled range the week maths still answers; only the
      // observance data is missing, and the app says so rather than showing none.
      if (!bundled)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 16,
                color: context.colors.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(child: Mono(s.dataCoverage, size: 12)),
            ],
          ),
        ),
      SectionTitle(s.weekRange),
      // FP-L04: all seven days, named, with their observances marked.
      SitePanel(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            for (var i = 0; i < 7; i++)
              DayRow(
                date: addCalendarDays(monday, i),
                repository: widget.repository,
                today: widget.today,
              ),
          ],
        ),
      ),
    ];
  }
}
