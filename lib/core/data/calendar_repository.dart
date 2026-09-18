import 'dart:convert';

import 'package:flutter/services.dart';

import '../date/iso_week.dart';

class CalendarEvent {
  const CalendarEvent({
    required this.date,
    required this.name,
    required this.official,
    this.flag = false,
  });
  final DateTime date;
  final String name;
  final bool official;
  final bool flag;
}

class SchoolPeriod {
  const SchoolPeriod({
    required this.year,
    required this.kind,
    required this.cities,
    required this.confidence,
    this.start,
    this.end,
    this.sourceKey,
  });
  final int year;
  final String kind;
  final List<String> cities;
  final String confidence;
  final DateTime? start;
  final DateTime? end;
  final String? sourceKey;
}

class CalendarRepository {
  CalendarRepository.fromJson(this.data, this.information, this.sun) {
    for (final year in data['years'] as List) {
      for (final h in year['holidays'] as List) {
        events.add(
          CalendarEvent(
            date: DateTime.parse(h['date'] as String),
            name: h['name'] as String,
            official: h['official'] as bool,
          ),
        );
      }
      for (final f in year['flagDays'] as List) {
        for (final name in f['names'] as List) {
          events.add(
            CalendarEvent(
              date: DateTime.parse(f['date'] as String),
              name: name as String,
              official: false,
              flag: true,
            ),
          );
        }
      }
    }
    events.sort((a, b) => a.date.compareTo(b.date));
    for (final event in events) {
      (_byDate[formatDate(event.date)] ??= []).add(event);
      if (event.official) _official.add(formatDate(event.date));
    }
    for (final page in data['schoolHolidays'] as List) {
      for (final kind in ['winter', 'autumn']) {
        for (final row in page[kind] as List) {
          final confidence = row['confidence'] as String;
          if (!['confirmed', 'estimated', 'unknown'].contains(confidence)) {
            throw const FormatException('Invalid school holiday confidence');
          }
          schoolPeriods.add(
            SchoolPeriod(
              year: page['year'] as int,
              kind: kind,
              cities: (row['cities'] as List).cast<String>(),
              confidence: confidence,
              start: DateTime.parse(row['startDate'] as String),
              end: DateTime.parse(row['endDate'] as String),
              sourceKey: row['sourceKey'] as String,
            ),
          );
        }
      }
      final unknown =
          (page['autumnUnknownCities'] as List?)?.cast<String>() ?? [];
      if (unknown.isNotEmpty) {
        schoolPeriods.add(
          SchoolPeriod(
            year: page['year'] as int,
            kind: 'autumn',
            cities: unknown,
            confidence: 'unknown',
          ),
        );
      }
    }
  }
  static const minYear = 2020;
  static const maxYear = 2035;
  final Map<String, dynamic> data;
  final Map<String, dynamic> information;
  final Map<String, dynamic> sun;
  final List<CalendarEvent> events = [];
  final List<SchoolPeriod> schoolPeriods = [];
  final Map<String, List<CalendarEvent>> _byDate = {};
  final Set<String> _official = {};

  static Future<CalendarRepository> load({AssetBundle? bundle}) async {
    final assets = bundle ?? rootBundle;
    final json = await Future.wait(
      ['calendar', 'information', 'sun'].map(
        (name) async =>
            jsonDecode(await assets.loadString('assets/data/$name.json'))
                as Map<String, dynamic>,
      ),
    );
    return CalendarRepository.fromJson(json[0], json[1], json[2]);
  }

  List<CalendarEvent> on(DateTime date) =>
      _byDate[formatDate(date)] ?? const [];
  bool isHoliday(DateTime date) => _official.contains(formatDate(date));
  List<CalendarEvent> forYear(int year, {bool flags = false}) =>
      events.where((e) => e.date.year == year && e.flag == flags).toList();
  CalendarEvent? nextHoliday(DateTime date) {
    final today = dateOnly(date);
    for (final e in events) {
      if (e.official && !e.date.isBefore(today)) return e;
    }
    return null;
  }

  Map<String, dynamic>? definition(String name) {
    for (final d in data['holidayDefinitions'] as List) {
      if (d['sourceName'] == name) return Map<String, dynamic>.from(d as Map);
    }
    return null;
  }

  Map<String, dynamic>? solar(DateTime date) =>
      (sun['days'] as Map<String, dynamic>)[formatDate(date)]
          as Map<String, dynamic>?;
  List<String> get cities =>
      schoolPeriods.expand((p) => p.cities).toSet().toList()..sort();
}
