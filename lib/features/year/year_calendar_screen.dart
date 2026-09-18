import 'package:flutter/material.dart';

import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/business_days.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';
import '../calendar/month_grid.dart';
import '../calendar/month_screen.dart' show MarkerLegend;

/// The whole year as twelve compact month grids, week gutters included.
class YearCalendarScreen extends StatefulWidget {
  const YearCalendarScreen({
    super.key,
    required this.repository,
    required this.today,
    required this.year,
  });
  final CalendarRepository repository;
  final DateTime today;
  final int year;
  @override
  State<YearCalendarScreen> createState() => _YearCalendarScreenState();
}

class _YearCalendarScreenState extends State<YearCalendarScreen> {
  late int year = widget.year;
  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final counts = countWorkingDays(
      DateTime(year, 1, 1),
      DateTime(year, 12, 31),
      isHoliday: widget.repository.isHoliday,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(s.yearCalendar),
        actions: [
          IconButton(
            tooltip: s.openWebsite,
            onPressed: () => openUrl(context, SiteUrl.path('kalenteri-$year')),
            icon: const Icon(Icons.open_in_new_rounded),
          ),
        ],
      ),
      body: PageBody(
        children: [
          YearStepper(
            year: year,
            onChanged: (value) => setState(() => year = value),
          ),
          SitePanel(
            child: StatRow([
              (s.workingDays, '${counts.working}'),
              (s.weekends, '${counts.weekend}'),
              (s.weekdayHolidays, '${counts.holidays}'),
              (s.totalDays, '${counts.total}'),
            ]),
          ),
          const SizedBox(height: 12),
          const MarkerLegend(),
          const AdSlot(),
          const SizedBox(height: 10),
          // Two columns once the width allows it, one on a phone (FP-A09/A10).
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 620 ? 2 : 1;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (var month = 1; month <= 12; month++)
                    SizedBox(
                      width:
                          (constraints.maxWidth - (columns - 1) * 16) / columns,
                      child: SitePanel(
                        padding: const EdgeInsets.fromLTRB(8, 12, 8, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 6,
                                bottom: 8,
                              ),
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/kuukausi-$month-$year',
                                ),
                                child: Text(
                                  context.monthName(year, month),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                            MonthGrid(
                              year: year,
                              month: month,
                              repository: widget.repository,
                              today: widget.today,
                              compact: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
