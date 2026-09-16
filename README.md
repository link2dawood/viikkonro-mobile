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

- Flutter 3.47.4 / Dart 3.13.3 (the version pinned in CI).
- Android SDK 36, minimum API 24; JDK 17.
- Xcode with an installed iOS simulator, CocoaPods; minimum deployment iOS 16.
- Android release: `fi.viikkonro.app`; debug: `fi.viikkonro.app.debug`.
- iOS: `fi.viikkonro.app` in Debug, Release, and Profile.
- iOS widget extension: `fi.viikkonro.app.widgets`.
- Android widget package: `fi.viikkonro.app.widget`.
- App Group: `group.fi.viikkonro.app` (enable it on both provisioning profiles).

Production signing is not configured. Release builds no longer use the debug
certificate. Never commit signing keys, credentials, or provisioning profiles.

## Run locally

Create the ignored Android signing and AdMob configuration once. If you already
have `android/key.properties`, merge the AdMob entries instead of overwriting
your signing credentials. Debug builds always use Google's sample banner ID
even when production values are present.

```sh
cp android/key.properties.example android/key.properties
```

Set the signing values, `ADMOB_ANDROID_APP_ID`, and
`ADMOB_ANDROID_BANNER_AD_UNIT_ID` in that local file for release builds. The
public publisher ID mirrors the seller record hosted at
`https://viikkonro.fi/app-ads.txt`. Never commit `android/key.properties`.

The app requests an updated Google UMP consent status on every launch, shows
the consent form when Google requires it, and does not initialize Mobile Ads
until UMP allows ad requests. To make the form available in production, create
and publish the applicable message for this Android app under **AdMob > Privacy
& messaging**. When Google requires a privacy-options entry point, it appears
automatically in the app's Settings screen so users can revisit their choice.

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

## Publish to Google Play internal testing

The manually triggered **Publish Android to Play internal testing** workflow
builds a signed release AAB and uploads it to the `internal` track. Production
promotion remains a manual Play Console operation.

Enable the Google Play Android Developer API, create a Google Cloud service
account, and invite its email under **Play Console > Users and permissions**.
Grant access only to `fi.viikkonro.app` and permission to manage testing-track
releases. The app must have been created in Play Console before the API can
upload to it.

Configure these GitHub Actions repository secrets:

| Secret | Contents |
| --- | --- |
| `PLAY_SERVICE_ACCOUNT_JSON` | Complete service-account JSON key |
| `ANDROID_UPLOAD_KEYSTORE_BASE64` | Upload keystore encoded as one-line base64 |
| `ANDROID_STORE_PASSWORD` | Upload-keystore password |
| `ANDROID_KEY_PASSWORD` | Upload-key password |
| `ANDROID_KEY_ALIAS` | Upload-key alias |
| `ADMOB_ANDROID_APP_ID` | Production Android AdMob app ID |
| `ADMOB_ANDROID_BANNER_AD_UNIT_ID` | Production Android banner unit ID |
| `FIREBASE_ANDROID_CONFIG_BASE64` | Production `google-services.json` encoded as one-line base64 |

Create either base64 value without committing the source file:

```sh
openssl base64 -A -in /path/to/file
```

Run the workflow from GitHub's Actions page and supply a semantic version plus
a positive, previously unused build number. GitHub retains the generated AAB
artifact for 14 days, and the workflow also uploads the R8 mapping file to Play.

The Swift source at `ios/Shared/IsoWeek.swift` is compiled into RunnerTests and
the WidgetKit extension. All three platforms read
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
