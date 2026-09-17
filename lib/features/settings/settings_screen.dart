import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/ads/ad_service.dart';
import '../../core/data/calendar_repository.dart';
import '../../core/settings/app_settings.dart';
import '../../shared/actions.dart';
import '../../shared/components.dart';
import '../../shared/formatters.dart';

/// FP-S01, FP-S02, FP-S03, FP-S08, FP-S09, FP-S11, FP-S13 and FP-D09.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.settings,
    required this.repository,
  });
  final AppSettings settings;
  final CalendarRepository repository;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final source = repository.data['source'] as Map<String, dynamic>;
    final range = (repository.data['range'] as List).cast<int>();
    return Scaffold(
      appBar: AppBar(title: Text(s.settings)),
      body: PageBody(
        children: [
          SectionTitle(s.language),
          // FP-S01, widened to every shipped translation: applies to the live
          // widget tree with no restart. A list rather than chips, because
          // twenty-two options do not belong in a row.
          _LanguagePicker(settings: settings),
          SectionTitle(s.theme),
          _Choices(
            values: ThemeMode.values,
            selected: settings.theme,
            label: (value) => switch (value) {
              ThemeMode.light => s.light,
              ThemeMode.dark => s.dark,
              ThemeMode.system => s.system,
            },
            onSelected: settings.setTheme,
          ),
          SectionTitle(s.firstScreen),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              for (final screen in AppSettings.firstScreens)
                ChoiceChip(
                  selected: settings.firstScreen == screen,
                  showCheckmark: false,
                  label: Text(switch (screen) {
                    'weeks' => s.weeks,
                    'calendar' => s.calendar,
                    'tools' => s.tools,
                    _ => s.home,
                  }),
                  onSelected: (_) => settings.setFirstScreen(screen),
                ),
            ],
          ),
          // FP-D09 / FP-S08: which snapshot is in use, for support diagnosis.
          SectionTitle(s.bundledData),
          SitePanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row(context, s.source, '${source['repository']}'),
                _row(
                  context,
                  'revision',
                  '${source['revision']}'.substring(0, 12),
                ),
                _row(context, s.year, '${range.first}–${range.last}'),
                _row(context, 'version', '${repository.data['version']}'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Mono(s.dataCoverage, size: 12),
          SectionTitle(s.about),
          SitePanel(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                ListenableBuilder(
                  listenable: AdService.instance,
                  builder: (context, _) =>
                      AdService.instance.privacyOptionsRequired
                      ? ListTile(
                          minTileHeight: 52,
                          leading: const Icon(Icons.ads_click_rounded),
                          title: Text(s.privacy),
                          subtitle: Text(
                            s.privacyNote,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: AdService.instance.showPrivacyOptions,
                        )
                      : const SizedBox.shrink(),
                ),
                ListTile(
                  minTileHeight: 52,
                  leading: const Icon(Icons.language_rounded),
                  title: Text(s.openWebsite),
                  subtitle: const Mono('viikkonro.fi', size: 12),
                  onTap: () => openUrl(context, SiteUrl.origin),
                ),
                ListTile(
                  minTileHeight: 52,
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text(s.privacy),
                  onTap: () => openUrl(context, SiteUrl.path('tietosuoja')),
                ),
                ListTile(
                  minTileHeight: 52,
                  leading: const Icon(Icons.gavel_rounded),
                  title: Text(s.terms),
                  onTap: () => openUrl(context, SiteUrl.path('kayttoehdot')),
                ),
                _Version(),
                ListTile(
                  minTileHeight: 52,
                  leading: const Icon(Icons.article_outlined),
                  title: Text(s.licenses),
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: s.appName,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Mono(s.privacyNote, size: 12),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Wrap(
      spacing: 10,
      runSpacing: 2,
      children: [
        Mono(label, size: 12),
        Mono(
          value,
          size: 12,
          weight: FontWeight.w600,
          color: context.colors.onSurface,
        ),
      ],
    ),
  );
}

/// The language list. Each option is written in its own language, so someone
/// who cannot read the current interface language can still find theirs.
class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker({required this.settings});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    return SitePanel(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          for (final code in AppSettings.languages)
            ListTile(
              minTileHeight: 52,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: Icon(
                settings.language == code
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: settings.language == code
                    ? context.colors.primary
                    : context.colors.onSurfaceVariant,
              ),
              title: Text(
                code == 'system' ? s.system : AppSettings.languageNames[code]!,
              ),
              subtitle: Mono(code == 'system' ? s.language : code, size: 11),
              onTap: () => settings.setLanguage(code),
            ),
        ],
      ),
    );
  }
}

/// A wrapping single-choice row, used where a segmented button would clip.
class _Choices<T> extends StatelessWidget {
  const _Choices({
    required this.values,
    required this.selected,
    required this.label,
    required this.onSelected,
  });
  final List<T> values;
  final T selected;
  final String Function(T) label;
  final void Function(T) onSelected;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 6,
    children: [
      for (final value in values)
        ChoiceChip(
          selected: selected == value,
          showCheckmark: false,
          label: Text(label(value)),
          onSelected: (_) => onSelected(value),
        ),
    ],
  );
}

/// FP-S11: version and build number, readable without a debug build.
class _Version extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<PackageInfo>(
    future: PackageInfo.fromPlatform(),
    builder: (context, snapshot) {
      final info = snapshot.data;
      return ListTile(
        minTileHeight: 52,
        leading: const Icon(Icons.info_outline_rounded),
        title: Text(context.s.appName),
        subtitle: Mono(
          info == null ? '—' : '${info.version} (${info.buildNumber})',
          size: 12,
        ),
        onTap: info == null
            ? null
            : () => copyText(
                context,
                '${info.packageName} ${info.version}+${info.buildNumber}',
              ),
      );
    },
  );
}
