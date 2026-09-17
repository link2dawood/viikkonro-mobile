import 'iso_week.dart';

// Finnish forms from the pinned website revision in the parity fixture.
const monthGenitive = <String>[
  'tammikuun',
  'helmikuun',
  'maaliskuun',
  'huhtikuun',
  'toukokuun',
  'kesäkuun',
  'heinäkuun',
  'elokuun',
  'syyskuun',
  'lokakuun',
  'marraskuun',
  'joulukuun',
];

const monthPartitive = <String>[
  'tammikuuta',
  'helmikuuta',
  'maaliskuuta',
  'huhtikuuta',
  'toukokuuta',
  'kesäkuuta',
  'heinäkuuta',
  'elokuuta',
  'syyskuuta',
  'lokakuuta',
  'marraskuuta',
  'joulukuuta',
];

const weekdayNames = <String>[
  'Sunnuntai',
  'Maanantai',
  'Tiistai',
  'Keskiviikko',
  'Torstai',
  'Perjantai',
  'Lauantai',
];

String finnishLong(DateTime input) {
  final date = dateOnly(input);
  return '${date.day}. ${monthPartitive[date.month - 1]} ${date.year}';
}

String finnishHeading(DateTime input) {
  final date = dateOnly(input);
  return '${weekdayNames[date.weekday % 7]} ${finnishLong(date)}';
}

String finnishShort(DateTime input) {
  final date = dateOnly(input);
  return '${date.day}.${date.month}.${date.year}';
}

String finnishRange(DateTime start, DateTime end) {
  final monday = dateOnly(start);
  final sunday = dateOnly(end);
  if (monday.year == sunday.year && monday.month == sunday.month) {
    return '${monday.day}.–${sunday.day}. '
        '${monthPartitive[sunday.month - 1]} ${sunday.year}';
  }
  if (monday.year == sunday.year) {
    return '${monday.day}.${monday.month}.–'
        '${sunday.day}.${sunday.month}.${sunday.year}';
  }
  return '${finnishShort(monday)}–${finnishShort(sunday)}';
}

// Abbreviations as the website writes them: two lower-case letters, ma–su.
const weekdayAbbreviations = <String>['su', 'ma', 'ti', 'ke', 'to', 'pe', 'la'];

String finnishWeekday(DateTime input) =>
    weekdayNames[dateOnly(input).weekday % 7];

String finnishWeekdayShort(DateTime input) =>
    weekdayAbbreviations[dateOnly(input).weekday % 7];
