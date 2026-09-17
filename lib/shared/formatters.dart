import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/date/finnish_format.dart';
import '../l10n/app_localizations.dart';

extension AppContext on BuildContext {
  AppLocalizations get s => AppLocalizations.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  String get language => Localizations.localeOf(this).languageCode;
  // Finnish keeps the forms ported from the website, including the partitive
  // month (FP-G03); every other language uses its own intl locale data.
  String longDate(DateTime d) =>
      language == 'fi' ? finnishLong(d) : DateFormat.yMMMMd(language).format(d);
  String headingDate(DateTime d) => language == 'fi'
      ? finnishHeading(d)
      : DateFormat.yMMMMEEEEd(language).format(d);
  String range(DateTime a, DateTime b) => language == 'fi'
      ? finnishRange(a, b)
      : '${DateFormat.MMMd(language).format(a)} – ${DateFormat.yMMMd(language).format(b)}';
  String monthName(int year, int month) =>
      DateFormat.MMMM(language).format(DateTime(year, month));
  String weekday(DateTime d) => language == 'fi'
      ? finnishWeekday(d)
      : DateFormat.EEEE(language).format(d);
  String weekdayShort(DateTime d) => language == 'fi'
      ? finnishWeekdayShort(d)
      : DateFormat.E(language).format(d);
  String shortDate(DateTime d) =>
      language == 'fi' ? finnishShort(d) : DateFormat.yMd(language).format(d);
}
