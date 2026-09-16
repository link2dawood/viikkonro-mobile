import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/date/iso_week.dart';
import '../core/theme/brand_theme.dart';
import 'formatters.dart';

class PageBody extends StatelessWidget {
  const PageBody({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => SafeArea(
    // AppBar owns the status-bar inset. SafeArea still protects the sides from
    // landscape cutouts and the bottom from gesture/three-button navigation.
    top: false,
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
        ),
      ),
    ),
  );
}

class PageHeading extends StatelessWidget {
  const PageHeading(this.title, {super.key, this.subtitle});
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(subtitle!, style: Theme.of(context).textTheme.bodyLarge),
          ),
      ],
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 14),
    child: Text(title, style: Theme.of(context).textTheme.titleLarge),
  );
}

class SitePanel extends StatelessWidget {
  const SitePanel({super.key, required this.child, this.padding = const EdgeInsets.all(22)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: context.colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: context.colors.outlineVariant),
    ),
    child: child,
  );
}

class Mono extends StatelessWidget {
  const Mono(this.text, {super.key, this.size = 13, this.color, this.weight = FontWeight.w400, this.maxLines});
  final String text;
  final double size;
  final Color? color;
  final FontWeight weight;
  final int? maxLines;
  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: maxLines,
    overflow: maxLines == null ? null : TextOverflow.ellipsis,
    style: TextStyle(fontFamily: 'PlexMono', fontSize: size, height: 1.5, fontWeight: weight, color: color ?? context.colors.onSurfaceVariant, fontFeatures: const [FontFeature.tabularFigures()]),
  );
}

class DateField extends StatelessWidget {
  const DateField({super.key, required this.label, required this.value, required this.onChanged});
  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Mono(label),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          alignment: Alignment.centerLeft,
          backgroundColor: context.colors.surfaceContainerLow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        ),
        onPressed: () async {
          final d = await showDatePicker(context: context, initialDate: value, firstDate: DateTime(2020), lastDate: DateTime(2035, 12, 31));
          if (d != null) onChanged(d);
        },
        icon: const Icon(Icons.calendar_today_outlined, size: 19),
        label: Text(context.longDate(value), maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    ],
  );
}

class YearStepper extends StatelessWidget {
  const YearStepper({super.key, required this.year, required this.onChanged});
  final int year;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Row(
      children: [
        IconButton(
          tooltip: context.s.previous,
          onPressed: year > 2020
              ? () {
                  HapticFeedback.selectionClick();
                  onChanged(year - 1);
                }
              : null,
          icon: const Icon(Icons.chevron_left),
        ),
        Expanded(
          child: Center(
            child: DropdownButton<int>(
              value: year,
              underline: const SizedBox.shrink(),
              style: TextStyle(fontFamily: 'PlexMono', fontSize: 20, color: context.colors.onSurface),
              items: [for (var y = 2020; y <= 2035; y++) DropdownMenuItem(value: y, child: Text('$y'))],
              onChanged: (y) {
                if (y != null) onChanged(y);
              },
            ),
          ),
        ),
        IconButton(
          tooltip: context.s.next,
          onPressed: year < 2035
              ? () {
                  HapticFeedback.selectionClick();
                  onChanged(year + 1);
                }
              : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    ),
  );
}

class StatRow extends StatelessWidget {
  const StatRow(this.entries, {super.key});
  final List<(String, String)> entries;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 28,
    runSpacing: 18,
    children: [
      for (final e in entries)
        SizedBox(
          width: 135,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.$2, style: Theme.of(context).textTheme.headlineMedium),
              Mono(e.$1),
            ],
          ),
        ),
    ],
  );
}

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});
  @override
  Widget build(BuildContext context) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 28,
          width: 33,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final bar in [(16.0, Brand.accent), (22.0, Brand.deep), (28.0, Brand.amber), (14.0, const Color(0xFF9DBFB1)), (11.0, const Color(0xFFC4D8CE))])
                Container(
                  width: 4,
                  height: bar.$1,
                  margin: const EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(color: bar.$2, borderRadius: BorderRadius.circular(2)),
                ),
            ],
          ),
        ),
        const SizedBox(width: 9),
        Text(
          context.s.wordmark,
          style: const TextStyle(fontFamily: 'Bricolage', fontWeight: FontWeight.w800, fontSize: 24, letterSpacing: -.7),
        ),
      ],
    ),
  );
}

class WeekProgress extends StatelessWidget {
  const WeekProgress({super.key, required this.week, required this.year});
  final int week, year;
  @override
  Widget build(BuildContext context) {
    final total = weeksInIsoYear(year);
    return Column(
      children: [
        // Wraps to a second line rather than clipping, which is what a long
        // translation or a large font scale needs it to do (FP-A01).
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 12,
          runSpacing: 2,
          children: [
            Mono(context.s.yearLabel(year)),
            Mono(context.s.weekOf(week, total), weight: FontWeight.w600),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 52,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var w = 1; w <= total; w++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.2),
                    child: AnimatedContainer(
                      duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 350),
                      height: w == week
                          ? 52
                          : w < week
                          ? 32
                          : 20,
                      decoration: BoxDecoration(
                        color: w == week
                            ? Brand.amber
                            : w < week
                            ? Brand.accent
                            : context.colors.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12), Align(alignment: Alignment.centerLeft, child: Mono(context.s.yearProgress((week / total * 100).round()))),
      ],
    );
  }
}
