# Development status

## First milestone: platform setup and date correctness

Implemented:

- Android/iOS identifiers and platform minimums from the product spec.
- Separate Android debug package, production debug signing removed.
- Signing-file ignores, reproducible dependency locks, committed Gradle wrapper.
- Local Dart civil-date arithmetic, ISO week/year/span functions, Finnish
  date formatting from the website's month and weekday forms.
- Standard-library Kotlin and Swift equivalents for the native widgets.
- Shared date fixture: 2020–2035, 5,844 dates, 835 week spans.
- Calendar fixture generator preserving holiday flags, multiple flag-day names
  on a date, school-holiday confidence tiers, coverage and unknown cities.
- CI parity jobs for all three platforms; Dependabot configuration.

The upstream fixture revision is
`d9cb579ec8b945c55705acf86150d7db65ec50a2` in `link2dawood/Viikkonro`.

## Verified locally (12 September 2026)

- `flutter doctor -v`: no toolchain issues.
- `flutter analyze --fatal-infos`: no issues.
- Dart parity: all dates/spans and Finnish formats pass in Europe/Helsinki,
  UTC, America/New_York and Pacific/Auckland.
- Android `:app:testDebugUnitTest`: 3 tests passed.
- iOS `xcodebuild test`, Runner scheme, iPhone 17 Pro Max simulator (iOS 26.5):
  3 XCTest tests passed, including parity in all four time zones.
- Both fixture generators: byte-identical results in Helsinki and UTC.
- Xcode project/plists and CI YAML syntax validated.

These are local results. GitHub-hosted CI has not run yet. Physical devices,
production signing, iOS 16 hardware and API 24 hardware remain unverified.

## Corrections to the supplied guide

- The latest identity table in `AGENTS.md` is authoritative: Android native
  widgets use `fi.viikkonro.app.widget` (singular), while the iOS extension keeps
  `fi.viikkonro.app.widgets`. Use JDK 17 for Android development and CI.
- The site repository is now specified as private `link2dawood/weekdays`.
  Existing fixture provenance records the URL used during generation and has
  not been rewritten. Future generator output uses the current repository URL.
- The original no-ads policy was revised on 13 September 2026. Android now uses
  Google Mobile Ads for one Home banner, gated by Google's UMP consent flow.
  Debug builds use Google's sample banner; release identifiers come from the
  gitignored `.admob.properties` file.
- The telemetry policy was revised on 13 September 2026. Firebase Crashlytics
  captures uncaught Flutter and asynchronous production failures; Google
  Analytics records navigation and primary-tab screen views. Both initialize
  before UMP so Google consent mode can be propagated. Debug collection is
  opt-in, and Firebase platform configuration remains gitignored.

- JavaScript `setDate` is calendar arithmetic. Dart `add(Duration(days: ...))`
  adds 24-hour intervals, even at local midnight, so it is not equivalent around
  DST. The port uses `DateTime(year, month, day + offset)` and retains fractional
  elapsed weeks until rounding, matching the site's algorithm. See the
  [Dart API](https://api.dart.dev/dart-core/DateTime/add.html).
- The current website date module is `dateUtils.js` in the renamed repository.
- The school-holiday page model has explicit confidence and unknown-city data;
  the legacy regional model has some uncertainty only in comments. The generator
  uses the page model and does not promote regional dates into city confirmations.
- CI runs Swift parity on pull requests too. A check that only runs after merging
  cannot prevent a parity regression from merging.
- App Group entitlements and widget targets will be added together with the
  bridge, so their identifiers are reserved but capabilities are not yet enabled.

## Second milestone: the app shell and the 1.0 screens

Implemented:

- `lib/main.dart` boots the real app: Finnish date symbols initialised before
  the first frame, bundled snapshot loaded, and an explicit failure screen if
  that snapshot will not parse.
- `lib/app.dart` holds the shell (home, weeks, calendar, calculators, more),
  the theme and locale wiring, and an `onGenerateRoute` that runs every path
  through `AppRoute.parse`. Unrecognised paths land on home, never a 404.
- `TodayScope` owns "today" for the whole tree: a timer to the next local
  midnight plus an `AppLifecycleListener`, so a foregrounded app rolls over on
  its own and a backgrounded one catches up on resume.
- Screens: home, week detail, day detail, year week grid, year calendar, month,
  holidays/flag days/school holidays, date-to-week and week-to-dates lookups,
  the day and working-day calculators, settings, and the index.
- Copy, share and open-on-the-website on every result surface.

## Verified on 12 September 2026

- `flutter analyze`: no issues.
- `flutter test`: 15 tests pass, including the three parity suites.
- `test/screen_smoke_test.dart` renders every route and every tab at 360x740 in
  Finnish and English, at a 200% font scale, and in landscape, asserting that
  nothing overflows. It found seven real layout defects, all since fixed.
- Installed and driven on a physical Pixel 6 (Android 17). Week 37, the
  Finnish long form `Lauantai 12. syyskuuta 2026`, `2026-W37 · Vuoden päivä
  255 / 365`, the year grid opening on the current week with its quarter
  dividers, the Monday-first month grid, and a language switch applying
  without a restart were all confirmed on the device.

iPhone install remains unverified; the device was not reachable.

## Third milestone: Android widgets and the language expansion

Android home screen widgets (FP-W):

- Seven Glance providers, each its own entry in the picker with its own preview
  layout: Viikko mini, Viikkokortti, Viikkonauha, Kuukausi, Laskuri, Pyhät ja
  liputus, Koululomat.
- Every widget computes its week in Kotlin from the device clock and reads the
  calendar from the bundled asset inside the APK. Nothing is read back from a
  Flutter-written payload, so a widget is correct with the engine dead, after
  the app's data is cleared, and after thirty days without the app being
  opened (FP-W09).
- `WidgetUpdateWorker` books itself one run at a time for the next 00:05 rather
  than using a periodic request, so the job stays pinned to a wall-clock time
  across a daylight-saving change (FP-W10).
- `DateChangeReceiver` follows `DATE_CHANGED`, `TIMEZONE_CHANGED`, `TIME_SET`
  and `LOCALE_CHANGED`, and re-books the midnight job on `BOOT_COMPLETED` and
  `MY_PACKAGE_REPLACED`, neither of which a pending WorkManager request
  survives (FP-W11).
- A widget tap carries its route in the intent, `MainActivity` hands it to Dart
  over a method channel, and the Dart router opens the matching screen on a
  cold start as well as a warm one (FP-W12).
- Widget palette comes from Android colour resources with a `values-night`
  variant, so dark mode is the platform's concern rather than the widget's.
  Material You (FP-W13) is still opt-in work for a later release.

Languages:

- English is now the ARB template and the declared fallback, replacing Finnish
  in that role. Twenty-two languages ship: Catalan, Czech, Danish, Dutch,
  English, Estonian, Finnish, French, German, Icelandic, Italian, Latvian,
  Lithuanian, Norwegian Bokmål, Polish, Portuguese, Romanian, Slovene, Spanish,
  Swedish, Turkish and Ukrainian.
- Finnish keeps the month and weekday forms ported from the website, including
  the partitive month (FP-G03). Every other language uses its own `intl` locale
  data, and `initializeDateFormatting()` now loads them all before first render.
- The generated `supportedLocales` list is alphabetical, so a
  `localeListResolutionCallback` names English as the fallback rather than
  letting Flutter land on the first entry.
- Widget month and weekday names come from `java.time` display names in the
  device locale, not from translated string arrays, so they are right even for
  a locale the app has no interface strings for (FP-G07).

## Verified on 12 September 2026, second pass

- `flutter analyze`: no issues. `flutter test`: 26 tests pass.
- The layout sweep now renders every route and tab in all twenty-two languages
  at 360x740, plus the 200% font scale and landscape passes. It found nine real
  layout defects across the two milestones, all since fixed.
- Kotlin: 9 unit tests pass, covering ISO parity against the shared fixture and
  the widget snapshot parser (holiday versus flag day, the next-observance
  lookups, school-holiday confidence tiers, and the month grid across the
  year boundary where January 2027 opens in week 53 of ISO year 2026).
- On the Pixel 6: all seven providers register, the midnight
  `WidgetUpdateWorker` job is scheduled, and a cold-start widget tap on
  `viikkonro://widget/viikko-37-2026` opens the week screen rather than home.

## Known gaps in the shipped screens

- The bundled flag-day records carry only `date` and `names`. FP-D03 and FP-P02
  ask for the official versus established distinction, which the generator does
  not yet emit, so the UI cannot show it. Fixing this starts upstream.
- No network refresh yet (FP-D05 to FP-D07), so Settings has no manual refresh
  (FP-S07) and no last-refresh timestamp. The data version, source revision and
  coverage range are shown, which covers FP-D09.
- Calendar export (FP-P06, FP-X04, FP-X05) and the holiday explanation detail
  (FP-P04) are not built.
- Routes resolve inside the app, but no platform deep-link wiring exists yet:
  FP-R01, FP-R02, FP-R08 and FP-R09 are untouched.
- `package_info_plus` was added for FP-S11. `pdf` and `printing` are declared
  but not yet used by any screen.
- The twenty new translations were produced in-house and have not been reviewed
  by native speakers. They are a starting point for review, not finished copy.
- FP-W06's per-instance widget configuration is not built: the Laskuri widget
  counts down to the next public holiday, which needs no setup. FP-W08's city
  comes from a `schoolCity` preference the app does not write yet, so the
  widget falls back to the next published break for any city.
- The widgets were verified by unit test, by provider registration and by the
  deep-link path on the device. Placing one on the home screen cannot be
  driven over adb, so the on-device visual check is still a manual step.
- Screen-reader labels are in place on the week number, the grids and the day
  cells, but FP-A02 and FP-A03 have not been walked through with TalkBack or
  VoiceOver, and FP-A11 cold start has not been measured.

## Remaining work, in order

1. Physical iPhone install. Confirm developer-account availability.
2. Flag-day type in the generator, then surface it (FP-D03, FP-P02).
3. Versioned network refresh, atomic cache write, background schedule, and the
   Settings refresh control (FP-D05 to FP-D07, FP-S07, FP-S08).
4. Calendar export and the remaining sharing points (FP-P06, FP-X04, FP-X05).
5. iOS: App Group wiring and the WidgetKit bundle (FP-I).
6. Deep-link platform wiring and website association files, quick access.
7. A TalkBack and VoiceOver pass, and a measured cold start on a mid-range
   device.
8. Store metadata, production signing, internal-track/TestFlight builds.

The v1.0/v1.2 tool lists in the guide overlap. Keep later-release tools separate
until the core screens and first three widgets are working.

## External setup still pending

- Physical-device acceptance checks and developer-account approval.
- Store signing certificates / Apple team ID; the local debug fingerprint is
  not the Play App Signing certificate used by the production association file.
- Website hosting changes, raw Vercel versus Cloudflare association verification.
- GitHub branch protection and enabling secret scanning (workflow files alone
  do not enable repository settings).
- Name-day licensing. No name-day data has been added.

No store builds have been distributed and no changes have been published to the
website or GitHub repository settings.
