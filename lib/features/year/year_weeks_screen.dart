import 'package:flutter/material.dart';
import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';

/// FP-Y01–FP-Y08: every week of a year, one tappable row each.
class YearWeeksScreen extends StatefulWidget {
  const YearWeeksScreen({super.key, required this.repository, required this.today, required this.year, this.embedded = false});
  final CalendarRepository repository;
  final DateTime today;
  final int year;
  final bool embedded;
  @override
  State<YearWeeksScreen> createState() => _YearWeeksScreenState();
}

class _YearWeeksScreenState extends State<YearWeeksScreen> {
  static const _baseRowExtent = 78.0;
  late int year = widget.year;
  ScrollController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  /// FP-Y06: the current week must already be on screen, not below the fold.
  double _initialOffset() {
    if (year != isoYear(widget.today)) return 0;
    return ((isoWeek(widget.today) - 3) * _rowExtent(context)).clamp(0, double.infinity);
  }

  /// A fixed extent keeps the jump to the current week cheap, so it has to
  /// grow with the user's font scale or the row's two lines would clip.
  double _rowExtent(BuildContext context) => _baseRowExtent * MediaQuery.textScalerOf(context).scale(14) / 14;

  void _setYear(int value) {
    setState(() {
      year = value;
      _controller?.dispose();
      _controller = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final total = weeksInIsoYear(year);
    final currentYear = year == isoYear(widget.today);
    final currentWeek = isoWeek(widget.today);
    _controller ??= ScrollController(initialScrollOffset: _initialOffset());
    final body = Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: Column(
            children: [
              YearStepper(year: year, onChanged: _setYear),
              // Wraps instead of clipping when the font scale is turned up.
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12,
                runSpacing: 2,
                children: [
                  Mono(s.weeksTotal),
                  Mono(s.weekOf(currentYear ? currentWeek : total, total), weight: FontWeight.w600),
                ],
              ),
              const AdSlot(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Scrollbar(
            controller: _controller,
            child: ListView.builder(
              controller: _controller,
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 28),
              itemExtent: _rowExtent(context),
              itemCount: total,
              itemBuilder: (context, index) => _WeekRow(week: index + 1, year: year, repository: widget.repository, current: currentYear && index + 1 == currentWeek),
            ),
          ),
        ),
      ],
    );
    if (widget.embedded) return body;
    return Scaffold(
      appBar: AppBar(
        title: Text(s.yearWeeks),
        actions: [
          IconButton(tooltip: s.share, onPressed: () => shareText(context, '${s.yearWeeks} $year\n${SiteUrl.weeks(year)}'), icon: const Icon(Icons.ios_share_rounded)),
          IconButton(tooltip: s.openWebsite, onPressed: () => openUrl(context, SiteUrl.weeks(year)), icon: const Icon(Icons.open_in_new_rounded)),
        ],
      ),
      body: body,
    );
  }
}

/// The ISO week belongs to the quarter containing its Thursday, so week 1 of a
/// year whose Monday still falls in December is Q1, not Q4.
int _quarterOfWeek(int week, int year) => (addCalendarDays(mondayOf(week, year), 3).month + 2) ~/ 3;

class _WeekRow extends StatelessWidget {
  const _WeekRow({required this.week, required this.year, required this.repository, required this.current});
  final int week, year;
  final CalendarRepository repository;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final monday = mondayOf(week, year), sunday = sundayOf(week, year);
    final days = [for (var i = 0; i < 7; i++) addCalendarDays(monday, i)];
    final holidays = days.where(repository.isHoliday).length;
    final quarter = _quarterOfWeek(week, year);
    final quarterStart = week == 1 || quarter != _quarterOfWeek(week - 1, year);
    // FP-Y02: month context is the month the week ends in when it straddles two.
    final months = monday.month == sunday.month ? context.monthName(sunday.year, sunday.month) : '${context.monthName(monday.year, monday.month)} – ${context.monthName(sunday.year, sunday.month)}';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // FP-Y08: quarter boundaries, labelled rather than a bare rule.
        if (quarterStart)
          SizedBox(
            height: 18,
            child: Row(
              children: [
                Mono(s.quarterLabel(quarter), size: 10, weight: FontWeight.w600, color: context.colors.primary),
                const SizedBox(width: 10),
                const Expanded(child: Divider(height: 1)),
              ],
            ),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Material(
              color: current ? context.colors.primary.withValues(alpha: .12) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.pushNamed(context, '/viikko-$week-$year'),
                child: Semantics(
                  button: true,
                  selected: current,
                  label: '${s.weekLabel(week)} $year, ${context.range(monday, sunday)}${holidays > 0 ? ', ${s.holidays}' : ''}',
                  child: ExcludeSemantics(
                    child: Container(
                      // FP-A06: 48dp minimum, before the row's own vertical padding.
                      constraints: const BoxConstraints(minHeight: 48),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: current ? context.colors.primary : context.colors.outlineVariant, width: current ? 2 : 1),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 44,
                            child: Mono('$week', size: 20, weight: FontWeight.w700, color: current ? context.colors.primary : context.colors.onSurface),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // The row has a fixed height, so each line must
                                // stay one line; the month context is the part
                                // that can afford to be cut.
                                Text(context.range(monday, sunday), maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
                                Mono(months, size: 11, maxLines: 1),
                              ],
                            ),
                          ),
                          // FP-Y04 / FP-A05: amber plus a star, never colour on its own.
                          if (holidays > 0)
                            Row(
                              children: [
                                Icon(Icons.star_rounded, size: 16, color: context.colors.secondary),
                                if (holidays > 1) Mono('$holidays', size: 11, weight: FontWeight.w600, color: context.colors.secondary),
                              ],
                            ),
                          const Icon(Icons.chevron_right, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
