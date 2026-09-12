# Viikkonro Mobile

Flutter companion to viikkonro.fi, a Finnish ISO 8601 week-number and calendar
utility. Follow these project rules when changing this repository.

## Identity (never change)

| Thing | Value |
| --- | --- |
| Android applicationId / iOS bundle ID | `fi.viikkonro.app` |
| Android debug suffix | `.debug` |
| Dart package | `viikkonro` |
| iOS widget extension | `fi.viikkonro.app.widgets` |
| iOS App Group | `group.fi.viikkonro.app` |
| Android widget package | `fi.viikkonro.app.widget` |
| Mobile repository (public) | `link2dawood/viikkonro-mobile` |
| Site repository (private) | `link2dawood/weekdays` |

Flutter's generated duplicate-name identifier is a bug. Correct the identifier,
package declaration and source path; do not work around it.

## Platform targets

Android and iOS only. Never run bare `flutter create .`; always specify
`--platforms=android,ios`. Do not add web, macOS, Windows or Linux targets.

- Android: minSdk 24, targetSdk 36, compileSdk 36, JDK 17.
- iOS: deployment target 16.0 for Lock Screen accessory widgets.

## Non-negotiable rules

1. Verify the ISO algorithm against `test/fixtures/iso_week_fixture.json`,
   generated from the site's `dateUtils.js`. Dart, Kotlin and Swift read this
   same file. Run parity tests whenever date logic changes. Never alter a
   fixture to make a test pass.
2. Dart implements the algorithm. Kotlin uses `WeekFields.ISO`. Swift uses
   `Calendar(identifier: .iso8601)`, `firstWeekday = 2` and
   `minimumDaysInFirstWeek = 4`. Do not hand-roll native week algorithms.
3. Normalize Dart dates with `DateTime(d.year, d.month, d.day)` before week math.
   Users want their local date, not UTC. Shift civil days through the date
   constructor, not 24-hour durations, to preserve correctness across DST.
4. Offline first. Bundled JSON in `assets/data/` must support every screen on
   first launch in airplane mode. Network refresh is optional.
5. Every user-facing screen/widget string comes from the data layer or ARB
   files. Never bypass the content pipeline with handwritten UI strings.
6. Preserve school-holiday confidence through the UI and both widget platforms.
   Estimated entries display an `arvio` badge everywhere; never flatten tiers.
7. Widgets operate with the Flutter engine dead. Android recomputes stale
   payloads in Kotlin. iOS computes each timeline entry in Swift and treats
   shared payloads as raw data, not cached week numbers.
8. No data collection, Firebase, analytics SDK or ads in v1.0. No runtime
   permissions beyond INTERNET. Keep an SDK-free `AdSlot` abstraction for a
   later release; do not integrate an advertising SDK now.
9. This repository is public. Never commit keystores, `key.properties`,
   provisioning profiles, API keys or `.env` files. Check `.gitignore` before
   introducing any new file type.

## Structure

The supplied rules did not include a new directory tree. Follow the existing
layout and `docs/product-spec.md`, using the identity table above wherever
older documents differ. These rules take precedence over the earlier guides.
Keep pinned fixture provenance intact; repository references are not a reason
to rewrite historical fixture outputs.
