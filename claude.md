# Viikkonro Mobile — codebase guide

This file is a working map for contributors and coding assistants. It describes
the repository at commit `6b4859f` (13 September 2026). Read `AGENTS.md` first:
it contains the authoritative project rules and overrides older documentation
and this overview if they disagree.

## Product in one paragraph

Viikkonro is an offline-first Flutter companion to
[viikkonro.fi](https://viikkonro.fi) for Finnish ISO 8601 week numbers and
calendar information. It runs on Android and iOS only. The app shows the current
week, resolves dates and week numbers in both directions, presents month/year
calendars, Finnish holidays, flag days, school holidays (with confidence), and
day/working-day calculators. It shares canonical website links but does not need
the network to render any app screen on first launch.

The implementation has three date consumers:

- Dart owns the Flutter application, UI, settings, offline data, and primary
  date/business-day logic.
- Kotlin owns Android home-screen widgets, which must work with Flutter dead.
- Swift currently owns the iOS parity-tested ISO date core. The WidgetKit target
  and App Group bridge are not implemented yet.

## Immutable identity and targets

Never change these values:

| Item | Value |
| --- | --- |
| Dart package | `viikkonro` |
| Android application ID / namespace | `fi.viikkonro.app` |
| Android debug suffix | `.debug` |
| Android widget package | `fi.viikkonro.app.widget` |
| iOS app bundle ID | `fi.viikkonro.app` |
| Reserved iOS widget bundle ID | `fi.viikkonro.app.widgets` |
| Reserved iOS App Group | `group.fi.viikkonro.app` |
| Mobile repository | `link2dawood/viikkonro-mobile` (public) |
| Website/data repository | `link2dawood/weekdays` (private) |

Supported platforms are Android and iOS only. Android uses minSdk 24,
compileSdk/targetSdk 36, and JDK 17. iOS has a 16.0 deployment target. Never run
bare `flutter create .`; if regeneration is genuinely required, constrain it to
`--platforms=android,ios` and preserve all identifiers/native work.

## Runtime architecture

### Startup and app shell

`lib/main.dart` initializes Flutter and Finnish date symbols, opens
`SharedPreferences`, loads all three bundled JSON files through
`CalendarRepository.load()`, and only then mounts `ViikkonroApp`. Invalid bundled
data is considered a build defect and produces a localized startup-failure
screen; there is no network retry dependency.

`lib/app.dart` contains the application-level state and navigation:

- `ViikkonroApp` listens to `AppSettings`, applies locale/theme changes live,
  owns the navigator key, and routes every path through `AppRoute.parse`.
- `TodayScope` exposes one normalized local civil “today” to the tree, schedules
  a refresh just after local midnight, and also refreshes on app resume.
- `AppShell` preserves five tabs in an `IndexedStack`: Home, Weeks, Calendar,
  Tools, and More. The configurable first screen can be one of the first four.
- A method channel named `fi.viikkonro.app/routes` accepts routes from Android
  widget taps on warm or cold starts.
- Unknown or invalid app paths deliberately return to the app shell/home instead
  of rendering a dead-end 404.

This project intentionally uses small Flutter primitives (`StatefulWidget`,
`ChangeNotifier`, `InheritedWidget`) rather than a third-party state-management
framework. Do not introduce one without a concrete need.

### Core Dart modules

| Path | Responsibility |
| --- | --- |
| `lib/core/date/iso_week.dart` | Local civil-date normalization, DST-safe day shifts, ISO week/year, week spans, ISO labels |
| `lib/core/date/business_days.dart` | Day distance, day-of-year, US week number, inclusive working-day counts, month/quarter/year bounds |
| `lib/core/date/finnish_format.dart` | Pinned Finnish grammatical month/weekday forms that match the website |
| `lib/core/data/calendar_repository.dart` | Parses/indexes bundled holidays, flag days, school periods, definitions, and Helsinki solar data |
| `lib/core/settings/app_settings.dart` | Local language, theme, first-screen, and per-week note preferences |
| `lib/core/theme/brand_theme.dart` | Shared Material 3 color/typography definitions and platform page transitions |
| `lib/core/ads/ad_service.dart` | Android AdMob configuration, UMP consent, SDK initialization, and privacy-options state |
| `lib/core/ads/ad_slot.dart` | Opt-in Google Mobile Ads banner view; only Home enables a placement |
| `lib/routing/deep_links.dart` | Pure parser for canonical `viikkonro.fi` route shapes and app-relative paths |
| `lib/shared/components.dart` | Reusable responsive panels, headings, date/year controls, stats, logo, and week progress |
| `lib/shared/actions.dart` | Canonical site URLs plus copy/share/external-browser actions |
| `lib/shared/formatters.dart` | `BuildContext` localization/date-format helpers; Finnish uses the pinned custom forms |

### User-facing feature modules

| Feature | Main behavior |
| --- | --- |
| `features/home` | Current ISO week hero, week/year progress, adjacent weeks, date lookup, current month, today’s events, next holiday |
| `features/week` | Week detail with all seven days; day detail with ISO facts, events, and Helsinki daylight data |
| `features/lookup` | Date-to-week and week/year-to-Monday/Sunday lookup |
| `features/year` | Scrollable 52/53-week year list and a 12-month year calendar |
| `features/calendar` | Monday-first month grid with ISO week gutter, event markers, navigation, and month picker |
| `features/holidays` | Year tabs for holidays, flag days, and school breaks; past-event dimming and confidence/source display |
| `features/tools` | Inclusive/exclusive date distance and working-day calculations for ranges/month/quarter/year |
| `features/settings` | Live language/theme/first-screen settings, bundled data provenance, version, legal/resource links |
| `features/more` | Index of secondary screens and website-only resources |

All result surfaces reuse `ResultActions` for copy/share/website links. Content
which exists only on the website is represented by `WebsiteScreen` and opened in
the system browser; it should not be silently duplicated as hard-coded app copy.

## Date rules — high-risk code

Treat changes under `lib/core/date`, native `IsoWeek` files, and calendar loops
as correctness-sensitive.

1. Dart accepts the displayed local date, not a UTC day. Normalize with
   `DateTime(d.year, d.month, d.day)` (`dateOnly`) before doing date math.
2. Shift civil dates with `DateTime(year, month, day + offset)`
   (`addCalendarDays`), never by adding 24-hour durations. Local DST days may be
   23 or 25 hours.
3. The Dart ISO algorithm mirrors the website’s Thursday-based algorithm and
   preserves fractional elapsed weeks until rounding.
4. Kotlin must use `java.time.temporal.WeekFields.ISO`; do not hand-roll the
   native algorithm.
5. Swift must use `Calendar(identifier: .iso8601)` with `firstWeekday = 2` and
   `minimumDaysInFirstWeek = 4`; do not hand-roll it.
6. ISO year can differ from calendar year around New Year. Carry `(week,
   isoYear)` together and derive adjacent weeks through their Monday.
7. Working-day ranges include both boundaries unless the UI explicitly opts out.
   Weekends take precedence over public holidays so one date is not excluded
   twice; eves are working days unless independently a weekday public holiday.

Any date-logic change requires parity tests against
`test/fixtures/iso_week_fixture.json`. Never edit a fixture merely to make a test
pass.

## Offline data pipeline

The app packages these immutable first-launch snapshots through `pubspec.yaml`:

- `assets/data/calendar.json`: 2020–2035 holidays, flag days, school holidays,
  confidence/source metadata, and holiday definitions.
- `assets/data/information.json`: Finnish website FAQ/article content and
  provenance. Most of this remains website-facing rather than rendered in-app.
- `assets/data/sun.json`: Helsinki sunrise/sunset/daylight data for every day in
  2020–2035.

`CalendarRepository` eagerly indexes calendar events by `yyyy-MM-dd`, keeps a
separate official-holiday set for workday math, and validates school confidence
as one of `confirmed`, `estimated`, or `unknown`. Do not flatten this confidence:
estimated entries must keep an `arvio`/localized estimated badge everywhere,
including native widgets.

Data is generated only from an authorized checkout of the private website repo:

```sh
TZ=Europe/Helsinki node scripts/bundle-website-data.mjs /path/to/weekdays
TZ=Europe/Helsinki node scripts/emit-mobile-fixtures.mjs /path/to/weekdays \
  > test/fixtures/iso_week_fixture.json
TZ=Europe/Helsinki node scripts/emit-calendar-fixtures.mjs /path/to/weekdays \
  > test/fixtures/holidays_fixture.json
```

The generators import the website’s real modules. Do not replace them with a
parallel implementation. Keep existing fixture provenance intact even though
historical fixtures name the website repository’s former URL. Regeneration must
be deterministic; inspect the diff and run Dart, Kotlin, and Swift parity suites.

There is currently no network refresh/cache layer. Bundled JSON is the runtime
source of truth for both Flutter and Android widgets.

## Localization and design

English (`lib/l10n/app_en.arb`) is the ARB template and explicit unsupported-
locale fallback. The app currently ships 22 locales: `ca`, `cs`, `da`, `de`,
`en`, `es`, `et`, `fi`, `fr`, `is`, `it`, `lt`, `lv`, `nb`, `nl`, `pl`, `pt`,
`ro`, `sl`, `sv`, `tr`, and `uk`.

- Put every user-facing Flutter string in ARB/data; never hard-code UI copy.
- Edit ARB files, then regenerate localization output with `flutter gen-l10n`.
  Files named `app_localizations*.dart` are generated output.
- Finnish date prose uses `finnish_format.dart`; other locales use `intl`.
- Native Android widgets use localized Android string resources because Flutter
  and ARB access are unavailable when the engine is dead. Month/weekday names
  come from `java.time` in the device locale.
- New/changed strings must be represented in every shipped ARB and relevant
  Android `values-*/strings.xml` resource set.

The brand is Material 3 on both platforms: green `#1F7A5C`, deep green
`#16573F`, amber `#E0A23B`, ink `#15211F`, and paper `#E7ECEB`. Fonts are bundled
as Inter (body), Bricolage (large display numbers/headings), and Plex Mono (ISO
labels and compact metadata). Existing UI deliberately supports narrow screens,
landscape, 200% text scale, and color-independent icons; preserve that behavior.

## Android native widgets

Android implements seven separately registered Glance providers under
`android/app/src/main/kotlin/fi/viikkonro/app/widget/`:

1. Viikko mini
2. Viikkokortti
3. Viikkonauha
4. Kuukausi
5. Laskuri
6. Pyhät ja liputus
7. Koululomat

`WidgetModel` recomputes all time-sensitive values with `LocalDate` and the
native ISO helper. `CalendarSnapshot` reads the packaged Flutter calendar asset
directly from the APK. A widget must never depend on a running Flutter engine or
on a cached/precomputed week number. `WidgetChrome` contains shared Glance
surface/navigation helpers. `WidgetUpdateWorker` schedules the next one-off run
for 00:05 local time, while `DateChangeReceiver` updates/rebooks after clock,
timezone, locale, boot, or package changes. `MainActivity` transfers widget URI
routes to Dart through the route channel.

Current limitations: Material You colors are not implemented; countdown and
school widgets do not yet have true per-instance configuration; the app does not
write the `schoolCity` preference, so school holidays fall back to any city.

## iOS native state

The Runner app and iOS 16 deployment configuration exist. `ios/Shared/IsoWeek.swift`
is compiled into `RunnerTests` and parity-tested across Helsinki, UTC, New York,
and Auckland. There is no WidgetKit extension, App Group entitlement, shared
payload bridge, universal-link entitlement, App Intent, or iOS widget UI yet.
The bundle/App Group identifiers above are reserved for that work.

## Routing

`AppRoute.parse` accepts relative paths and canonical HTTPS URLs only for
`viikkonro.fi`. It maps current website slugs for week, month, year, quarter,
calendar, holiday, flag-day, school-holiday, lookup, calculator, information,
and data pages. Supported data years are bounded to 2020–2035. Widget deep links
currently use `viikkonro://widget/...` on Android.

Routing inside Flutter is implemented, but verified Android App Links, iOS
Universal Links, and website association files are still pending. Do not confuse
the pure route parser with platform-level deep-link registration.

## Persistence, privacy, and dependencies

App-owned preferences use `SharedPreferences`. Keys currently include
`language`, `theme`, `firstScreen`, `note_<isoYear>_<week>`, and the Android
widget reader’s planned `schoolCity`. Nothing is synced off-device.

The v1 privacy posture permits no accounts. Google Mobile Ads, Firebase
Crashlytics, and Google Analytics are the approved data SDKs. AdMob is
Android-only at this snapshot,
requests ads only after the Google UMP consent flow permits it, uses Google's test
banner in debug builds, and exposes required privacy options in Settings. The
repository is public: never add keystores, signing properties, provisioning
profiles, credentials, API keys, or `.env` files. AdMob identifiers live in the
gitignored `android/key.properties`; `android/key.properties.example` documents
the required fields without real secrets. The public publisher ID also appears
in the website's app-ads.txt record. Firebase platform configuration is also
gitignored. Crashlytics records
uncaught production failures, Analytics records navigation/screen views, and
debug telemetry requires an explicit build define.

Main Dart dependencies are deliberately small: `intl`, `shared_preferences`,
`package_info_plus`, `url_launcher`, `share_plus`, `google_mobile_ads`,
`firebase_core`, `firebase_crashlytics`, and `firebase_analytics`. `pdf` and
`printing` are declared but not yet used. Android adds Glance/Compose and
WorkManager for native widgets.

## Tests and verification

Run from the repository root:

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos
TZ=Europe/Helsinki flutter test
```

Run the Flutter suite in all parity time zones when changing date logic:

```sh
for zone in Europe/Helsinki UTC America/New_York Pacific/Auckland; do
  TZ="$zone" flutter test
done
```

Android native tests:

```sh
cd android
./gradlew :app:testDebugUnitTest --console=plain
```

iOS native tests require macOS, a prepared Flutter workspace, CocoaPods, and an
available simulator:

```sh
flutter build ios --simulator --config-only
cd ios && pod install && cd ..
xcodebuild test -workspace ios/Runner.xcworkspace -scheme Runner \
  -configuration Debug -destination 'platform=iOS Simulator,id=SIMULATOR_ID' \
  -parallel-testing-enabled NO CODE_SIGNING_ALLOWED=NO
```

Test responsibilities:

- `test/iso_week_parity_test.dart`: 5,844 civil dates, 835 week spans, Finnish
  forms, ISO boundaries, invalid input, and DST-safe shifts.
- `test/widget_test.dart`: main journeys, 53-week year, unknown routing, and
  automatic midnight rollover with an injected clock.
- `test/screen_smoke_test.dart`: every important route/tab at phone width, all
  22 languages, landscape, and 200% text scale with overflow detection.
- Android `IsoWeekParityTest` and `WidgetDataTest`: shared fixture parity,
  packaged data parsing, holiday/flag separation, confidence, and month grids.
- `RunnerTests.swift`: Swift parity and boundaries in four time zones.
- `.github/workflows/ci.yml`: pinned Flutter 3.47.4/Dart 3.13.3 matrix plus
  Android/JDK 17 and macOS/iOS jobs.

When changing only documentation, inspect the diff; code test reruns are not
usually necessary. For logic/UI/native changes, run the smallest relevant suite
and then the full platform suite before handoff.

## Current implementation gaps

Keep `docs/development-status.md` as the detailed backlog. The important gaps at
this snapshot are:

- no versioned network data refresh, atomic cache, background refresh, or manual
  refresh UI;
- no upstream flag-day official/established type in the bundled schema;
- no calendar export, holiday explanation detail, or wired PDF/printing flow;
- no platform web-link association (Android App Links / iOS Universal Links);
- no iOS WidgetKit bundle, App Group bridge, quick actions, or App Intents;
- no iOS AdMob integration; separate iOS app/ad-unit identifiers are required;
- no complete Android per-widget configuration;
- no name-day data because licensing is unresolved;
- no production signing/store distribution, physical iPhone acceptance pass,
  or full TalkBack/VoiceOver audit;
- translations beyond Finnish/English still need native-speaker review.

Also note that `README.md` still describes the UI as a future milestone. That
statement is stale; the actual Flutter screens and Android widgets listed above
are implemented. Prefer code, tests, `AGENTS.md`, and the latest sections of
`docs/development-status.md` over that README status paragraph.

## Safe change checklist

Before editing:

1. Read `AGENTS.md` and the relevant feature/core/native files.
2. Check `git status`; preserve unrelated user changes.
3. Decide whether the change touches date parity, offline data, localization,
   school confidence, routing, or engine-dead widget behavior.

While editing:

1. Keep local civil dates local and use the shared date helpers.
2. Keep all UI copy in ARB/data/native resources.
3. Keep screens fully offline and within the 2020–2035 data boundary.
4. Keep estimated/unknown school-holiday confidence visible.
5. Do not make native widgets depend on Dart execution.
6. Do not add unsupported platforms, another analytics/tracking SDK, another ad
   SDK, or secrets. Keep AdMob consent-gated, debug ads on Google's test unit,
   and debug Firebase collection opt-in.

Before handoff:

1. Format changed Dart.
2. Run analysis and relevant Flutter/native/parity tests.
3. Check narrow layout, large text, dark mode, and affected locales for UI work.
4. Report remaining platform/device checks honestly; do not claim simulator or
   physical-device verification that was not performed.
