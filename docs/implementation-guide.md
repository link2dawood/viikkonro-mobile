> Current repository rules: [AGENTS.md](../AGENTS.md). They take precedence over this earlier guide.

# Viikkonro Mobile: Implementation Guide

Flutter app for iOS and Android. Repo: `link2dawood/viikkonro-mobile` (public).
Bundle id and applicationId: `fi.viikkonro.app`.

Read this top to bottom the first time. After that it is a reference: each phase
is self contained and ends with a verifiable exit condition. Do not start a phase
until the previous phase's exit condition passes.

---

## Phase 0. Prerequisites and accounts

### 0.1 Local toolchain

```bash
flutter --version            # need 3.24 or newer, Dart 3.5+
flutter doctor -v            # must be green for android and ios
java -version                # JDK 17 for Android Gradle Plugin 8.x
xcodebuild -version          # Xcode 15.4 or newer
```

If `flutter doctor` flags the Android licences:

```bash
flutter doctor --android-licenses
```

CocoaPods is required on macOS:

```bash
sudo gem install cocoapods
```

### 0.2 Store accounts

| Account | Cost | Blocker to watch |
|---|---|---|
| Google Play Console | 25 USD once | Personal accounts need 12 testers for 14 days before production |
| Apple Developer Program | 99 USD per year | Enrolment approval can take 24 to 48 hours, longer for organisations |

Register both as an organisation if you have the business entity, because it
removes the Play testing gate and gives you a company name on the listings.
Start the Apple enrolment on day one, it is the longest lead time item in this
guide.

### 0.3 Exit condition

`flutter doctor -v` is clean, both developer accounts are approved, and you can
run `flutter run` on a physical Android device and a physical iPhone.

---

## Phase 1. Repository and identifiers

### 1.1 Create the project

```bash
flutter create --org fi.viikkonro --project-name viikkonro \
  --platforms=android,ios viikkonro_app
cd viikkonro_app
```

Always pass `--platforms=android,ios`. Running a bare `flutter create .` later
regenerates the web, macos, windows and linux folders.

### 1.2 Fix the identifiers immediately

`flutter create` produces a duplicate-name identifier; use `fi.viikkonro.app`. Fix it before the first
commit, because changing it after a store submission is impossible.

**`android/app/build.gradle.kts`**

```kotlin
android {
    namespace = "fi.viikkonro.app"
    compileSdk = 36

    defaultConfig {
        applicationId = "fi.viikkonro.app"
        minSdk = 24
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        debug {
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
        }
    }
}
```

**Move MainActivity**

```bash
mkdir -p android/app/src/main/kotlin/fi/viikkonro/app
# Move MainActivity.kt from its generated package into the directory above.
# Remove the old generated package directory once it is empty.
```

Then edit the first line of that file to `package fi.viikkonro.app`.

**iOS**: open `ios/Runner.xcworkspace`, select the Runner target, and set
`PRODUCT_BUNDLE_IDENTIFIER` to `fi.viikkonro.app` for **both** Debug and Release
and Profile configurations. Set the deployment target to **iOS 16.0** in the
same panel and in `ios/Podfile` (`platform :ios, '16.0'`).

### 1.3 Secrets hygiene before the first push

The repo is public. Put this in `.gitignore` in the very first commit, before any
other file:

```gitignore
# signing
key.properties
*.jks
*.keystore
ios/Runner/GoogleService-Info.plist
ios/fastlane/report.xml
ios/fastlane/Preview.html
**/*.mobileprovision
**/*.p12
.env
.env.*

# flutter defaults
.dart_tool/
build/
.flutter-plugins
.flutter-plugins-dependencies
ios/Pods/
ios/.symlinks/
android/.gradle/
android/local.properties
```

A secret committed once stays in the history, in forks and in the GitHub cache
forever. Force pushing does not remove it.

### 1.4 Repo metadata

- Description: `Viikkonro for iOS and Android. Finnish ISO 8601 week numbers, holidays and calendar tools. Flutter.`
- Homepage: `https://viikkonro.fi`
- Topics: `flutter`, `dart`, `ios`, `android`, `iso-8601`, `week-numbers`, `finland`, `calendar`, `widgetkit`, `glance`
- License: MIT, with an added note that the Viikkonro name, logo and data feed are not covered by it
- Branch protection on `main`, with the three parity test suites as required checks
- Enable Dependabot and secret scanning (both free on public repos)

### 1.5 Exit condition

`flutter run` installs `fi.viikkonro.app.debug` on Android and `fi.viikkonro.app`
on iOS. The repo is on GitHub, public, with nothing sensitive in the history.

---

## Phase 2. The date core and the parity harness

Build this before any UI. The ISO week algorithm will exist in four places (JS on
the site, Dart in the app, Kotlin in the Android widget, Swift in the iOS widget)
and silent drift between them is the single most likely way this project ships a
wrong answer.

### 2.1 Fixture generator, in the weekdays repo

Add `scripts/emit-mobile-fixtures.js` to `link2dawood/weekdays`:

```js
// Emits the fixtures the mobile app tests every platform against.
// Run: node scripts/emit-mobile-fixtures.js > iso_week_fixture.json
import { isoWeek, isoYear, mondayOf, weeksInIsoYear } from "../src/components/dateUtils.js";

const FROM = 2020, TO = 2035;
const pad = (n) => String(n).padStart(2, "0");
const fmt = (d) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;

const dates = [];
for (let y = FROM; y <= TO; y++) {
  for (let m = 0; m < 12; m++) {
    const last = new Date(y, m + 1, 0).getDate();
    for (let day = 1; day <= last; day++) {
      const d = new Date(y, m, day);
      dates.push({ date: fmt(d), week: isoWeek(d), isoYear: isoYear(d) });
    }
  }
}

const years = [];
for (let y = FROM; y <= TO; y++) {
  const total = weeksInIsoYear(y);
  const weeks = [];
  for (let w = 1; w <= total; w++) {
    const mon = mondayOf(w, y);
    const sun = new Date(mon);
    sun.setDate(mon.getDate() + 6);
    weeks.push({ week: w, monday: fmt(mon), sunday: fmt(sun) });
  }
  years.push({ year: y, weeksInYear: total, weeks });
}

process.stdout.write(JSON.stringify({
  generatedAt: new Date().toISOString(),
  source: "viikkonro.fi dateUtils.js",
  range: [FROM, TO],
  dates,
  years,
}, null, 0));
```

Add a second generator for the data layer, emitting holidays, flag days and
school holidays **including the confidence tier**, so the app can never render a
confirmed badge where the site says estimated.

Commit both outputs into the mobile repo at `test/fixtures/`. Regenerate and
re-commit whenever the site's date or holiday logic changes. That is the whole
sync mechanism, and it is deliberately manual so the change is visible in a diff.

### 2.2 Dart implementation

`lib/core/date/iso_week.dart`. Mirror `dateUtils.jsx` exactly.

```dart
/// Normalises any DateTime to a local date-only value.
/// Every function here MUST start with this. DST transitions otherwise
/// produce off-by-one week numbers around the March and October boundaries.
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

int isoWeek(DateTime input) {
  final t = dateOnly(input);
  final day = (t.weekday - 1) % 7;            // Mon = 0
  final thursday = t.add(Duration(days: 3 - day));
  final firstJan = DateTime(thursday.year, 1, 1);
  var firstThursday = firstJan;
  if (firstJan.weekday != DateTime.thursday) {
    firstThursday = DateTime(
      thursday.year, 1, 1 + ((4 - firstJan.weekday + 7) % 7),
    );
  }
  final diff = thursday.difference(firstThursday).inDays;
  return 1 + (diff / 7).round();
}

int isoYear(DateTime input) {
  final t = dateOnly(input);
  final day = (t.weekday - 1) % 7;
  return t.add(Duration(days: 3 - day)).year;
}

int weeksInIsoYear(int year) => isoWeek(DateTime(year, 12, 28));

DateTime mondayOf(int week, int year) {
  final jan4 = DateTime(year, 1, 4);
  final j = (jan4.weekday - 1) % 7;
  final firstMonday = DateTime(year, 1, 4 - j);
  return firstMonday.add(Duration(days: (week - 1) * 7));
}

DateTime sundayOf(int week, int year) =>
    mondayOf(week, year).add(const Duration(days: 6));
```

Use `Duration(days:)` arithmetic only on date-only values. Do not use
`DateTime.add` on a value carrying a time component, and never use UTC here:
users expect the week number of their local today.

### 2.3 Native implementations use the standard library

Do **not** hand roll the algorithm in Kotlin or Swift. Both platforms ship a
correct ISO 8601 implementation.

**Kotlin**

```kotlin
import java.time.LocalDate
import java.time.temporal.WeekFields

fun isoWeek(d: LocalDate): Int = d.get(WeekFields.ISO.weekOfWeekBasedYear())
fun isoYear(d: LocalDate): Int = d.get(WeekFields.ISO.weekBasedYear())
```

**Swift**

```swift
let isoCal: Calendar = {
    var c = Calendar(identifier: .iso8601)
    c.firstWeekday = 2            // Monday
    c.minimumDaysInFirstWeek = 4  // ISO rule
    c.timeZone = .current
    return c
}()

func isoWeek(_ d: Date) -> Int { isoCal.component(.weekOfYear, from: d) }
func isoYear(_ d: Date) -> Int { isoCal.component(.yearForWeekOfYear, from: d) }
```

### 2.4 Three parity test suites

**Dart**, `test/iso_week_parity_test.dart`:

```dart
void main() {
  final fixture = jsonDecode(
    File('test/fixtures/iso_week_fixture.json').readAsStringSync(),
  ) as Map<String, dynamic>;

  test('every date matches the site', () {
    for (final row in fixture['dates'] as List) {
      final parts = (row['date'] as String).split('-').map(int.parse).toList();
      final d = DateTime(parts[0], parts[1], parts[2]);
      expect(isoWeek(d), row['week'], reason: row['date'] as String);
      expect(isoYear(d), row['isoYear'], reason: row['date'] as String);
    }
  });

  test('every week span matches the site', () {
    for (final y in fixture['years'] as List) {
      expect(weeksInIsoYear(y['year'] as int), y['weeksInYear']);
      for (final w in y['weeks'] as List) {
        expect(_fmt(mondayOf(w['week'] as int, y['year'] as int)), w['monday']);
        expect(_fmt(sundayOf(w['week'] as int, y['year'] as int)), w['sunday']);
      }
    }
  });
}
```

**Kotlin**, a JVM unit test in `android/app/src/test/kotlin/` reading the same
fixture file (add `test/fixtures` as a test resource directory in Gradle).

**Swift**, an XCTest in the widget extension's test target reading the same file
from the bundle.

All three read one file. Any drift on any platform fails CI.

### 2.5 Exit condition

`flutter test`, the Gradle unit test task, and `xcodebuild test` all pass against
the committed fixtures. Roughly 5,800 dates and 830 weeks verified per platform.

---

## Phase 3. Theme, typography and assets

### 3.1 Brand tokens

`lib/core/theme/brand_colors.dart`:

```dart
abstract final class Brand {
  static const accent   = Color(0xFF1F7A5C);
  static const deep     = Color(0xFF16573F);
  static const amber    = Color(0xFFE0A23B);
  static const ink      = Color(0xFF15211F);
  static const paper    = Color(0xFFE7ECEB);
  static const footer   = Color(0xFF0F2A21);
}
```

Seed the `ColorScheme` from `Brand.accent`, then override the key roles
explicitly. If you let the tonal palette derive everything it will invent greens
that do not match the site, and the app and the widgets will drift visually.

```dart
final scheme = ColorScheme.fromSeed(seedColor: Brand.accent).copyWith(
  primary: Brand.accent,
  onPrimary: Colors.white,
  secondary: Brand.amber,
  surface: Brand.paper,
  onSurface: Brand.ink,
);
```

### 3.2 Fonts

Bundle Inter, Bricolage Grotesque and IBM Plex Mono as assets. Do not use
`google_fonts`, it fetches at runtime and breaks the offline promise.

```yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
    - family: Bricolage
      fonts:
        - asset: assets/fonts/BricolageGrotesque-Bold.ttf
          weight: 700
    - family: PlexMono
      fonts:
        - asset: assets/fonts/IBMPlexMono-Regular.ttf
```

Bricolage for the large week numeral, Inter for body, PlexMono for ISO format
strings like `2026-W38`.

The widget extensions cannot read Flutter assets. Copy the same font files into
the Android `res/font/` directory and into the iOS widget target's own bundle,
and register the iOS ones in the extension's Info.plist under
`UIAppFonts`.

### 3.3 Icons and splash

Before generating icons, close the three open brand issues from the site: the
font import inside the SVG files causing the Arial Black fallback, the favicon
green ramp not matching the CSS tokens, and the missing square lockup. The
adaptive icon forces the square lockup decision anyway, so make it here and
backport it to the site's social avatars.

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/branding/icon-1024.png"
  adaptive_icon_background: "#16573F"
  adaptive_icon_foreground: "assets/branding/icon-foreground.png"
  adaptive_icon_monochrome: "assets/branding/icon-mono.png"   # themed icons
  remove_alpha_ios: true
```

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

`remove_alpha_ios: true` is mandatory. App Store Connect rejects any icon with an
alpha channel, and the rejection arrives after upload, not at build time.

### 3.4 Exit condition

Both platforms launch with the brand icon and splash, and a screen rendering the
week numeral in Bricolage at 96pt looks correct on a physical device with
Impeller enabled.

---

## Phase 4. Data layer

### 4.1 Bundled first, network second

```
assets/data/holidays.json
assets/data/flag_days.json
assets/data/school_holidays.json
assets/data/sunrise_cities.json
```

First launch must be fully functional with airplane mode on. The repository reads
the bundled snapshot, then, if a cached network copy exists and is newer, it
prefers that.

```dart
class CalendarRepository {
  Future<CalendarData> load() async {
    final cached = await _readCache();
    if (cached != null && cached.version >= _bundledVersion) return cached;
    return _readBundled();
  }

  /// Called from a background task, never blocks the UI.
  Future<void> refresh() async {
    final res = await http.get(Uri.parse('https://viikkonro.fi/api/calendar.json'))
        .timeout(const Duration(seconds: 10));
    if (res.statusCode != 200) return;
    final data = CalendarData.fromJson(jsonDecode(res.body));
    if (data.version <= (await _readCache())?.version) return;
    await _writeCache(data);
    await pushWidgetPayload();   // widgets see the new data immediately
  }
}
```

Every response carries a `version` and a `generatedAt`. Never overwrite a cache
with an older version, which protects you from a stale Cloudflare edge copy
clobbering fresh data.

### 4.2 The Cloudflare caveat

You have already been burned by this on the site. Before you point the app at any
endpoint, verify the cache policy by fetching the raw `*.vercel.app` deployment
URL and comparing it against the domain. Query parameter cache busting does not
work on this stack because Cloudflare normalises the URL, so use a path based
version instead if you need a bypass: `/api/calendar.v3.json`.

### 4.3 Confidence tiers are load bearing

The school holiday data has confirmed and estimated entries. Carry the tier all
the way to the UI and to both widget platforms, and render an `arvio` badge on
anything estimated. Do not flatten it for convenience at the widget boundary,
which is exactly where it will get lost.

### 4.4 Exit condition

Fresh install, airplane mode on, every screen renders real data. Then with
network on, a forced refresh updates the cache and pushes new widget payloads.

---

## Phase 5. App screens (v1.0)

Build in this order. Each one is small.

1. **Koti**: week numeral large, today's date in Finnish, Monday to Sunday span, day of year, holiday or flag day status
2. **Päivä to viikko**: date picker returns week and ISO year, with a link out to the matching viikkonro.fi page
3. **Viikko to päivä**: week plus year returns the span
4. **Vuosi**: all 52 or 53 weeks as a grid, current week highlighted, year switcher
5. **Kuukausi**: month grid with the week number gutter, holidays marked in amber, today ringed
6. **Pyhät**: holidays and flag days for the selected year, each with a calendar export action
7. **Asetukset**: language, theme, first screen, notification toggle, widget refresh

### 5.1 Localisation

```yaml
flutter:
  generate: true
```

`l10n.yaml`:

```yaml
arb-dir: lib/l10n
template-arb-file: app_fi.arb
output-localization-file: app_localizations.dart
```

Finnish is the template, English is the translation. Two traps:

```dart
// Without this, release builds silently render English month names.
await initializeDateFormatting('fi');
```

And the genitive month forms (`tammikuun`, `helmikuun`) are **not** what the
`intl` locale data gives you. Port `M_GENITIVE` from the site verbatim into
`lib/core/date/finnish_format.dart` rather than trusting locale data.

### 5.2 Platform feel

Same widget tree on both platforms, with platform appropriate behaviour:

- iOS: `CupertinoPageTransitionsBuilder` so the swipe back gesture works, large
  title scroll behaviour, `HapticFeedback.selectionClick()` on the week stepper
- Android: Material 3 transitions, predictive back (`android:enableOnBackInvokedCallback="true"`), Material You dynamic colour as an opt in

Do not ship raw Cupertino widgets. This is a branded utility, not a system app.

### 5.3 Exit condition

All seven screens work offline in both languages and both themes, on a phone and
on a tablet or iPad in landscape.

---

## Phase 6. Tools

These are what make the app worth installing over a bookmark. Each is a screen
plus a pure function in `lib/core/date/`.

| Tool | Core function | Notes |
|---|---|---|
| Päivälaskuri | `daysBetween(a, b, {excludeWeekends, excludeHolidays})` | Three result rows: calendar days, weekdays, working days |
| Työpäivälaskuri | `workdaysRemaining(scope)` | Month, quarter, year. Feeds a widget |
| Viikkomuistiinpanot | local key value store keyed `note_{isoYear}_{week}` | No sync, no account. This is the retention feature |
| Palkkapäivä ja jaksot | `nextOccurrence(anchor, intervalDays)` | Every two weeks, monthly, custom. Feeds widget 5 |
| Raskausviikkolaskuri | `pregnancyWeek(lastPeriod)` | Own deep link and its own ASO keyword |
| Vuorotyölaskuri | `shiftOnDate(pattern, anchor, date)` | Patterns like 5 on 5 off, 12 hour rotations |
| Auringonnousu | NOAA solar position, offline | No API. Per city from the bundled list |

Each tool gets its own route so it can be deep linked and shortcut to.

### 6.1 Exit condition

Every tool has unit tests with hand verified expected values, particularly the
holiday excluding working day counter around Easter and Midsummer.

---

## Phase 7. Widget bridge

One payload, two consumers. Build this before either native widget.

### 7.1 Payload contract

`lib/core/widgets_bridge/payload.dart`:

```dart
Future<void> pushWidgetPayload() async {
  final now = dateOnly(DateTime.now());
  final data = await CalendarRepository().load();

  final payload = {
    'schema': 1,
    'computedAt': now.toIso8601String(),
    'week': isoWeek(now),
    'isoYear': isoYear(now),
    'monday': fmt(mondayOf(isoWeek(now), isoYear(now))),
    'sunday': fmt(sundayOf(isoWeek(now), isoYear(now))),
    'todayLabel': finnishLong(now),
    'holidayToday': data.holidayOn(now)?.name,
    'nextHoliday': {...},
    'nextFlagDay': {...},
    'weekStrip': [ /* 7 entries: date, dayLetter, isHoliday, isToday */ ],
    // iOS only: the raw data the timeline provider needs to compute ahead
    'holidays': data.holidaysJsonForNextYear(),
    'schoolHolidays': data.schoolHolidaysForSelectedCity(),
  };

  await HomeWidget.saveWidgetData('payload', jsonEncode(payload));
  await HomeWidget.updateWidget(
    androidName: 'WeekWidgetReceiver',
    iOSName: 'ViikkonroWidgets',
  );
}
```

Call it on app launch, on resume, after a data refresh, and after any setting
that affects a widget.

### 7.2 The hard rule

Both native sides must be able to compute the current week **themselves**, from
the raw data, without the Flutter engine ever running.

- On Android, the payload is a warm cache. If it is missing or its `computedAt`
  is not today, the Kotlin side recomputes with `WeekFields.ISO`.
- On iOS, the payload is **only** a data carrier. The widget computes the week
  for every timeline entry in Swift. Reading a precomputed week number from
  `UserDefaults` means a user who never opens the app sees a frozen number for
  weeks, which is the single most common way widgets in this category break.

### 7.3 iOS App Group

Both the app target and the widget extension need the App Groups capability with
`group.fi.viikkonro.app`. Then, in `ios/Runner/AppDelegate.swift`:

```swift
HomeWidgetPlugin.setAppGroupId("group.fi.viikkonro.app")
```

and in Dart:

```dart
await HomeWidget.setAppGroupId('group.fi.viikkonro.app');
```

Forgetting either produces a widget that silently reads an empty container with
no error anywhere.

### 7.4 Exit condition

A debug screen in the app prints the payload, and a Kotlin and a Swift unit test
each parse a committed sample payload and render correct values.

---

## Phase 8. Android widgets

Seven providers, so all seven appear separately in the picker.

### 8.1 Per widget files

```
android/app/src/main/kotlin/fi/viikkonro/app/widget/
  WeekMiniWidget.kt        + WeekMiniReceiver.kt
  WeekCardWidget.kt        + WeekCardReceiver.kt
  WeekStripWidget.kt       + WeekStripReceiver.kt
  MonthWidget.kt           + MonthReceiver.kt
  CounterWidget.kt         + CounterReceiver.kt
  HolidayWidget.kt         + HolidayReceiver.kt
  SchoolHolidayWidget.kt   + SchoolHolidayReceiver.kt
  shared/Payload.kt, shared/Theme.kt, shared/IsoWeek.kt
android/app/src/main/res/xml/
  widget_week_mini.xml ... widget_school_holiday.xml
```

### 8.2 Glance skeleton

```kotlin
class WeekMiniWidget : GlanceAppWidget() {
    override val sizeMode = SizeMode.Responsive(
        setOf(DpSize(57.dp, 57.dp), DpSize(110.dp, 57.dp))
    )

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val payload = Payload.loadOrCompute(context)   // cache, else recompute
        provideContent {
            GlanceTheme {
                Box(
                    modifier = GlanceModifier.fillMaxSize()
                        .background(Brand.deep)
                        .cornerRadius(16.dp)
                        .clickable(actionStartActivity<MainActivity>()),
                    contentAlignment = Alignment.Center,
                ) {
                    Text("vk ${payload.week}", style = TextStyle(
                        fontSize = 28.sp, fontWeight = FontWeight.Bold,
                        color = ColorProvider(Color.White),
                    ))
                }
            }
        }
    }
}

class WeekMiniReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = WeekMiniWidget()
}
```

Use `SizeMode.Responsive` with an explicit size set. `SizeMode.Single` clips the
large numerals the moment a user resizes.

### 8.3 Refresh pipeline

Three triggers, all of which must exist:

1. A `WorkManager` job at 00:05 daily that recomputes and updates every provider
2. A `BroadcastReceiver` for `ACTION_DATE_CHANGED` and `ACTION_TIMEZONE_CHANGED`
3. A push from Dart on app foreground

Never set `updatePeriodMillis` below 30 minutes in the XML. The system ignores
it, and it looks like the widget is broken when it is only being throttled.

### 8.4 Configured widgets

Widgets 5 and 7 declare `android:configure` pointing at a Flutter route launched
through `home_widget`. Store per instance keys:

```
counter_${appWidgetId}_targetDate
counter_${appWidgetId}_label
school_${appWidgetId}_city
```

Clean these up in `onDeleted(context, appWidgetIds)` or they accumulate forever.

### 8.5 Quick Settings tile

```kotlin
class WeekTileService : TileService() {
    override fun onStartListening() {
        qsTile.label = "Viikko"
        qsTile.subtitle = "vk ${IsoWeek.current()}"
        qsTile.state = Tile.STATE_ACTIVE
        qsTile.updateTile()
    }
}
```

Half a day of work, and the highest daily touchpoint per unit of effort in the
whole project.

### 8.6 Exit condition

All seven widgets install from the picker, render correctly at every declared
size, survive a device reboot with the app never opened, and roll over to the new
week at midnight with the app force stopped.

---

## Phase 9. iOS widgets

One extension target, one `WidgetBundle`, seven widgets plus accessory families.

### 9.1 Create the target

Xcode, File, New, Target, Widget Extension. Name it `ViikkonroWidgets`, bundle id
`fi.viikkonro.app.widgets`, deployment target iOS 16.0, and **uncheck** Include
Live Activity unless you plan one. Add the App Groups capability to the new
target with `group.fi.viikkonro.app`.

### 9.2 The timeline model is an advantage here

Your data is fully deterministic, so compute two weeks of entries in one pass and
let the system render them with no app process, no background work and no battery
cost.

```swift
struct WeekProvider: TimelineProvider {
    func getTimeline(in ctx: Context, completion: @escaping (Timeline<WeekEntry>) -> Void) {
        let data = SharedStore.load()          // App Group JSON
        var entries: [WeekEntry] = []
        var day = isoCal.startOfDay(for: Date())

        for _ in 0..<14 {
            entries.append(WeekEntry(
                date: day,
                week: isoWeek(day),            // computed HERE, in Swift
                isoYear: isoYear(day),
                holiday: data.holiday(on: day),
                nextHoliday: data.nextHoliday(after: day)
            ))
            day = isoCal.date(byAdding: .day, value: 1, to: day)!
        }

        completion(Timeline(entries: entries, policy: .after(day)))
    }
}
```

`.after(day)` schedules the next refresh when the precomputed window runs out.
Do not use `.atEnd` and do not use a short `.after`, WidgetKit budgets refreshes
per app and you will burn the budget for nothing.

### 9.3 Bundle and families

```swift
@main
struct ViikkonroWidgets: WidgetBundle {
    var body: some Widget {
        WeekMiniWidget()        // systemSmall, accessoryCircular, accessoryInline
        WeekCardWidget()        // systemSmall, systemMedium, accessoryRectangular
        WeekStripWidget()       // systemMedium
        MonthWidget()           // systemLarge
        CounterWidget()         // configurable, systemSmall/Medium + accessory
        HolidayWidget()         // systemMedium, accessoryRectangular
        SchoolHolidayWidget()   // configurable, systemMedium
    }
}
```

Lock Screen families must be monochrome. Use `.widgetAccentable()` and design for
a single tint, do not try to carry the brand green there.

### 9.4 Configured widgets use App Intents

Widgets 5 and 7 use `AppIntentConfiguration`, not a Flutter route. The city list
for widget 7 comes from the shared JSON through a dynamic options provider.

```swift
struct CityIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Kaupunki"
    @Parameter(title: "Kaupunki") var city: CityEntity?
}
```

### 9.5 Siri and Spotlight

The single best iOS differentiator available here, and nobody in this category
has built it:

```swift
struct CurrentWeekIntent: AppIntent {
    static var title: LocalizedStringResource = "Mikä viikko nyt"
    static var openAppWhenRun = false

    func perform() async throws -> some IntentResult & ProvidesDialog {
        let w = isoWeek(Date())
        return .result(dialog: "Nyt on viikko \(w).")
    }
}
```

Add `AppShortcutsProvider` with Finnish phrases so it works from Siri without the
user configuring anything.

### 9.6 iOS 18 Control Widget

The Control Centre equivalent of the Android tile. Cheap once the rest exists,
and gate it with `@available(iOS 18.0, *)`.

### 9.7 Exit condition

All seven render in the widget gallery, Lock Screen accessories render correctly
in both light and dark, the Siri phrase works on a physical device, and a widget
added on a device where the app has never been opened still shows the right week.

---

## Phase 10. Deep links

### 10.1 Android

`AndroidManifest.xml`, inside the `MainActivity` activity:

```xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" android:host="viikkonro.fi" />
</intent-filter>
```

Then host `https://viikkonro.fi/.well-known/assetlinks.json` with the **Play App
Signing** SHA256 fingerprint, taken from Play Console, not your upload key. Using
the upload key fingerprint is the most common reason verification silently fails.

### 10.2 iOS

Add the Associated Domains capability with `applinks:viikkonro.fi`, and host
`https://viikkonro.fi/.well-known/apple-app-site-association`:

- served as `application/json`
- no file extension
- no redirect, ever, at any hop
- reachable without authentication

```json
{
  "applinks": {
    "details": [{
      "appIDs": ["TEAMID.fi.viikkonro.app"],
      "components": [
        { "/": "/viikko-*" },
        { "/": "/vuosi-*" },
        { "/": "/" }
      ]
    }]
  }
}
```

### 10.3 Verify through Cloudflare before you trust it

iOS fetches the AASA through Apple's CDN, which caches aggressively. A stale
Cloudflare copy will break universal links for days with no error surfaced
anywhere. Verify in this order:

```bash
curl -sI https://viikkonro-xxxx.vercel.app/.well-known/apple-app-site-association
curl -sI https://viikkonro.fi/.well-known/apple-app-site-association
curl -sI https://viikkonro.fi/.well-known/assetlinks.json
```

Confirm `content-type: application/json`, a 200 with no redirect chain, and that
the body from the domain matches the body from Vercel.

### 10.4 Route mapping

| URL | Screen |
|---|---|
| `/` | Koti |
| `/viikko-{n}-{yyyy}` | Viikko detail |
| `/vuosi-{yyyy}` | Vuosi grid |
| `/{kuukausi}-{yyyy}` | Kuukausi |
| `/pyhapaivat-{yyyy}` | Pyhät |

Every in app screen gets an `avaa verkossa` action opening the matching
viikkonro.fi URL. That closes the traffic loop back to the site.

### 10.5 Exit condition

Tapping a viikkonro.fi week link in Gmail opens the app on the right screen, on
both platforms, on a physical device.

---

## Phase 11. Store preparation

### 11.1 Privacy

Ship with **no data collected**. No Firebase, no analytics SDK, no ads in v1.
Then both forms are trivially honest:

- Play Data Safety: no data collected, no data shared
- App Store Privacy: Data Not Collected

Add `/tietosuoja` to viikkonro.fi and link it from both listings. An empty
privacy card is a competitive feature in this category, and it keeps both review
paths short.

### 11.2 Listings

**Google Play**

- Title: `Viikkonro: viikkonumero` (30 chars)
- Default locale Finnish, en-US secondary
- Short description targets `mikä viikko nyt`, `viikkonumero`, `viikkolaskuri`
- Feature graphic 1024x500, six to eight phone screenshots

**App Store**

- Name 30 chars, **subtitle** 30 chars (most developers waste this, use it)
- Keywords field, 100 chars, never shown to users, pure ASO. Comma separated, no
  spaces, and do not repeat anything already in the name or subtitle because
  Apple indexes those separately:
  `viikkolaskuri,vk,kalenteri,pyhäpäivät,arkipäivät,koululoma,hiihtoloma,liputuspäivä,raskausviikko`
- Screenshots for 6.9 inch and 6.5 inch, plus 13 inch iPad
- Enable iPad. It is nearly free with Flutter and the month view suits it

### 11.3 Review notes, and guideline 4.2

Apple rejects thin utilities that read as website wrappers. Pre empt it in the
review notes: state that the app works entirely offline, that it provides seven
home screen and Lock Screen widgets, a Siri intent, and seven calculators not
present on the website. That is a factual answer to 4.2 and it usually avoids the
round trip.

### 11.4 Exit condition

Internal track build live on Play, TestFlight build live on iOS, both installable
by a tester who has never seen the project.

---

## Phase 12. CI and release

`.github/workflows/ci.yml`, running on every pull request:

```yaml
jobs:
  dart:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: {channel: stable, cache: true}
      - run: flutter pub get
      - run: flutter analyze --fatal-infos
      - run: flutter test                       # includes the parity suite

  android:
    runs-on: ubuntu-latest
    needs: dart
    steps:
      - run: ./gradlew :app:testDebugUnitTest   # Kotlin parity suite

  ios:
    runs-on: macos-latest
    if: github.ref == 'refs/heads/main' || startsWith(github.ref, 'refs/tags/')
    steps:
      - run: xcodebuild test -scheme ViikkonroWidgets   # Swift parity suite
```

Gate the iOS job to `main` and tags. macOS runner minutes cost roughly ten times
a Linux minute.

Release workflow on a version tag:

- Android: decode the base64 keystore secret into `android/keystore.jks`, write
  `key.properties` from secrets, `flutter build appbundle --release`, upload with
  `r0adkll/upload-google-play` to the internal track
- iOS: `fastlane match` against a **private** certificates repo (never the public
  app repo), `flutter build ipa --release`, upload to TestFlight with an App
  Store Connect API key

Promotion from internal to production stays manual. Do not automate a store
release on a tag push.

---

## Phase 13. Release sequence

| Version | Contents |
|---|---|
| 1.0 | Phases 1 to 6, widgets 1 to 3 on both platforms, deep links, tile, share, calendar export, shortcuts |
| 1.1 | Widgets 4 to 7, school holidays with the tier badge, Monday notification, Siri intent, iOS Control Widget |
| 1.2 | Pregnancy, shift, sunrise, week notes, recurring periods, ICS subscription once the web feed ships |
| 1.3 | Wear OS complication, Apple Watch complication |

Ten weeks is the honest estimate to a two platform 1.0 with native widget layers
on both. The single biggest schedule risk is the iOS widget extension, because it
is the only part of this project where Flutter gives you nothing.

---

## Open decisions

1. Organisation or personal store accounts, which decides the Play testing gate
2. Bundled data only, or a live fetch against the site API for holiday corrections
3. iPad and Android tablet layouts in 1.0, or phone only
4. The name day licensing question, which changes widgets 1, 2 and 6
5. Monetisation stance, since it is declared on both privacy forms at first
   submission and changing it later is a resubmission on both stores

---

## Recurring risks worth re reading

- **Four implementations of one algorithm.** The fixture harness is the only
  thing standing between you and a silently wrong week number. Never merge a
  change to date logic with a skipped parity test.
- **Hand typed content bypasses the pipeline.** The same failure mode that
  produced the `/en` artifact applies here. Every string a widget renders should
  come from the data layer, not from a Kotlin or Swift literal.
- **Cloudflare caching.** Verify every well known file and every API endpoint
  against the raw Vercel URL first. Path based versioning, not query parameters.
- **Widgets must work with the app dead.** Test by force stopping the app,
  rebooting, and waiting through a midnight rollover before calling a widget done.
- **Confidence tiers must survive the widget boundary.** An estimated school
  holiday rendered as confirmed on a home screen is worse than not shipping the
  widget.
