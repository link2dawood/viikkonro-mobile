import 'package:flutter/material.dart';
import '../../core/ads/ad_slot.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/date/iso_week.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';

/// The index for everything that is not one of the four main tabs.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key, required this.repository, required this.today});
  final CalendarRepository repository;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final year = isoYear(today);
    return PageBody(
      children: [
        const Padding(padding: EdgeInsets.only(bottom: 18), child: BrandLogo()),
        SitePanel(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              _tile(context, Icons.star_rounded, s.holidays, '/pyhapaivat-$year'),
              _tile(context, Icons.flag_outlined, s.flagDays, '/liputuspaivat-$year'),
              _tile(context, Icons.school_outlined, s.schoolHolidays, '/koululomat-$year'),
              _tile(context, Icons.grid_on_rounded, s.yearCalendar, '/kalenteri-$year'),
              _tile(context, Icons.search_rounded, s.dateToWeek, '/paivamaara-viikoksi'),
              _tile(context, Icons.date_range_rounded, s.weekToDate, '/viikko-paivamaaraksi'),
            ],
          ),
        ),
        SectionTitle(s.settings),
        SitePanel(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(children: [_tile(context, Icons.tune_rounded, s.settings, '/asetukset')]),
        ),
        const AdSlot(),
        SectionTitle(s.websiteResources),
        Mono(s.websiteResourcesNote, size: 12),
        const SizedBox(height: 10),
        SitePanel(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              _link(context, Icons.help_outline_rounded, s.faq, 'ukk'),
              _link(context, Icons.calculate_outlined, s.methodology, 'menetelma'),
              _link(context, Icons.source_outlined, s.sources, 'tietolahteet'),
              _link(context, Icons.public_rounded, s.usComparison, 'suomi-vs-usa-viikkonumerot'),
              _link(context, Icons.mail_outline_rounded, s.contact, 'ota-yhteytta'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Mono(s.privacyNote, size: 12),
      ],
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title, String route) =>
      ListTile(minTileHeight: 54, leading: Icon(icon), title: Text(title), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.pushNamed(context, route));

  Widget _link(BuildContext context, IconData icon, String title, String slug) =>
      ListTile(minTileHeight: 54, leading: Icon(icon), title: Text(title), trailing: const Icon(Icons.open_in_new_rounded, size: 18), onTap: () => openUrl(context, SiteUrl.path(slug)));
}

/// Site-only content. Rather than a dead end inside the app, the route says
/// where the material lives and opens it in the browser (FP-R07).
class WebsiteScreen extends StatelessWidget {
  const WebsiteScreen({super.key, required this.title, required this.slug, this.note});
  final String title, slug;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PageBody(
        children: [
          SitePanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text(note ?? s.websiteResourcesNote, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 8),
                Mono(s.fiContent, size: 12),
                const SizedBox(height: 18),
                FilledButton.icon(onPressed: () => openUrl(context, SiteUrl.path(slug)), icon: const Icon(Icons.open_in_new_rounded, size: 18), label: Text(s.openWebsite)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          TextButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: Text(s.backHome)),
        ],
      ),
    );
  }
}
