# Viikkonro

Finnish ISO week numbers and offline calendar tools for iOS and Android.
Product site: https://viikkonro.fi.

## Development status

The first milestone establishes the identifiers, date core, fixture generators,
and Dart/Kotlin/Swift parity suites. The Flutter screen is still the starter
screen; product UI, offline repositories, and native widgets are subsequent
milestones. See [development status](docs/development-status.md), the supplied
[implementation guide](docs/implementation-guide.md), and [product spec](docs/product-spec.md).

## Toolchain and identifiers

- Flutter 3.38.9 / Dart 3.10.8 (the version pinned in CI).
- Android SDK 36, minimum API 24; JDK 17.
- Xcode with an installed iOS simulator, CocoaPods; minimum deployment iOS 16.
- Android release: `fi.viikkonro.app`; debug: `fi.viikkonro.app.debug`.
- iOS: `fi.viikkonro.app` in Debug, Release, and Profile.
- Reserved iOS widget ID: `fi.viikkonro.app.widgets`.
- Android widget package: `fi.viikkonro.app.widget`.
- Reserved App Group: `group.fi.viikkonro.app` (capability wiring comes with widgets).

Production signing is not configured. Release builds no longer use the debug
certificate. Never commit signing keys, credentials, or provisioning profiles.

## Run locally

Create the ignored Android AdMob configuration once. Debug builds always use
Google's sample banner ID even when production values are present.

```sh
cp admob.properties.example .admob.properties
```

Set `ADMOB_ANDROID_APP_ID` and `ADMOB_ANDROID_BANNER_AD_UNIT_ID` in that local
file for release builds. Never commit `.admob.properties`.

Firebase project files are also local-only. Register Android production
`fi.viikkonro.app`, Android debug `fi.viikkonro.app.debug`, and iOS
`fi.viikkonro.app` in the Firebase Console, enable Analytics and Crashlytics,
then place the downloaded files here:

```text
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
ios/firebase_app_id_file.json
```

These paths are gitignored. Generate the iOS app-ID file with
`flutterfire configure`, then run `pod install` on macOS so Crashlytics adds its
symbol-upload phase. Release telemetry is enabled automatically. Debug
telemetry stays disabled unless Flutter is run with
`--dart-define=ENABLE_FIREBASE_TELEMETRY=true`.

```sh
flutter pub get
flutter run
```

On macOS, prepare generated iOS settings before invoking Xcode directly:

```sh
flutter build ios --simulator --config-only
cd ios
pod install
```

## Verify

From the repository root:

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos
TZ=Europe/Helsinki flutter test
```

Native Android tests (set `JAVA_HOME` if Java is not on your PATH):

```sh
cd android
./gradlew :app:testDebugUnitTest
```

Native iOS tests, after preparing the workspace above:

```sh
xcrun simctl list devices available
xcodebuild test -workspace ios/Runner.xcworkspace -scheme Runner \
  -configuration Debug -destination 'platform=iOS Simulator,id=YOUR_SIMULATOR_ID' \
  -parallel-testing-enabled NO CODE_SIGNING_ALLOWED=NO
```

The Swift source at `ios/Shared/IsoWeek.swift` is compiled into RunnerTests now
and will also be used by the WidgetKit extension. All three platforms read
`test/fixtures/iso_week_fixture.json`, covering 5,844 dates and 835 week spans.
Dart and Swift cover Helsinki, UTC, New York, and Auckland time zones.
CI runs every parity suite on pull requests and pushes to `main`.

## Regenerate website fixtures

Use Node 22+ and an authorized local checkout of the private site repository,
`link2dawood/weekdays`. The existing fixtures retain the repository URL and
revision used when they were generated; do not rewrite their provenance.
The generators import its real modules, never a replacement implementation.

```sh
TZ=Europe/Helsinki node scripts/emit-mobile-fixtures.mjs /path/to/Viikkonro \
  > test/fixtures/iso_week_fixture.json
TZ=Europe/Helsinki node scripts/emit-calendar-fixtures.mjs /path/to/Viikkonro \
  > test/fixtures/holidays_fixture.json
```

Fixtures record the upstream commit and source SHA-256 hashes. Outputs are
deterministic; a wall-clock timestamp is intentionally omitted to avoid noisy
regeneration diffs. Inspect the diff and run all three parity suites before
committing an update. The scripts can also be copied into the website repo.

School holidays come from `schoolHolidayPages.js`, preserving confidence,
coverage, sources, and unknown-city lists. The older `schoolHolidays.js` does not
encode all of its confidence claims as data and must not be substituted. The
calendar fixture is reference data for the upcoming repository implementation;
it is not yet loaded by the app.
