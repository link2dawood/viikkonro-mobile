> Current repository rules: [AGENTS.md](../AGENTS.md). They take precedence over this earlier guide.

1. Identifiers

Lock these on day one, none of them can be changed after the first store submission.

Thing	Value
Android applicationId and namespace	fi.viikkonro.app
iOS bundle id	fi.viikkonro.app
Android widget provider package	fi.viikkonro.app.widget
iOS widget extension bundle id	fi.viikkonro.app.widgets
iOS App Group	group.fi.viikkonro.app
watchOS target (later)	fi.viikkonro.app.watchkitapp
Dart package name	viikkonro
Android debug suffix	.debug

flutter create produces a duplicate-name identifier that must be replaced with fi.viikkonro.app. Fix it before the first commit in android/app/build.gradle.kts, in the MainActivity.kt path and package line, and in the Xcode PRODUCT_BUNDLE_IDENTIFIER for both Debug and Release configurations.

Accounts you need: Apple Developer Program at 99 USD per year (mandatory, no TestFlight without it) and Google Play Console at 25 USD once. Register both as an organisation if you can, because a personal Play account triggers the 12 testers for 14 days requirement before you may publish.

2. Platform minimums
Android: minSdk 24, targetSdk 36, compileSdk 36
iOS: 16.0 minimum. This is deliberate. iOS 16 is where Lock Screen accessory widgets exist, and it lets you write one widget bundle instead of branching on availability for every family. Coverage is well above 95 percent of active devices and the audience skews Finnish, not emerging market
3. What Flutter gives you and what it does not

Dart carries the app. Widgets cannot be written in Dart on either platform.

Layer	Android	iOS
App UI, logic, data	Dart	Dart
Home screen widgets	Kotlin, Glance	Swift, WidgetKit and SwiftUI
Lock Screen widgets	n/a	Swift, accessory families
Shade or Control Centre	Kotlin TileService	Swift Control Widget, iOS 18
Voice	Android App Actions (skip)	Swift App Intents, Siri
Watch	later, Wear OS module	later, watchOS target
Bridge	home_widget writing SharedPreferences	home_widget writing App Group UserDefaults

Realistic split is about 75 percent Dart. The native surface is now two languages instead of one, so budget five to seven days for it, not two. This is the real cost of the Flutter decision and it is worth paying only because you get iOS for free on the app itself.

4. Stack
yaml
dependencies:
  flutter_localizations: {sdk: flutter}
  intl: ^0.19.0
  home_widget: ^0.7.0
  shared_preferences: ^2.3.0
  workmanager: ^0.5.2        # Android refresh only
  app_links: ^6.3.0
  http: ^1.2.0
  share_plus: ^10.0.0
  url_launcher: ^6.3.0
  add_2_calendar: ^3.0.1
  flutter_local_notifications: ^17.2.0
  package_info_plus: ^8.0.0
dev_dependencies:
  flutter_test: {sdk: flutter}
  flutter_lints: ^5.0.0
  flutter_launcher_icons: ^0.14.0
  flutter_native_splash: ^2.4.0

State: ValueNotifier plus InheritedWidget, or Riverpod if you want structure. Not bloc.

Design: Material 3 on Android, and on iOS do not ship raw Cupertino. Use your own brand surface on both platforms with platform appropriate navigation patterns (bottom bar both, but iOS gets swipe back, large titles and haptics). A week number app is a branded utility, not a system app clone.

Colours seeded from 
#1f7a5c with 
#16573f, 
#e0a23b, ink 
#15211f, paper 
#e7eceb as explicit overrides so the tonal palette does not invent its own greens. Fonts bundled: Inter, Bricolage Grotesque for the large numerals, IBM Plex Mono for ISO strings. Bundle them in pubspec.yaml and again in each native widget target, since widget extensions cannot read Flutter assets.

5. Repository structure
lib/
  core/date/          iso_week.dart, business_days.dart, finnish_format.dart
  core/data/          holidays.dart, flag_days.dart, school_holidays.dart,
                      name_days.dart, repository.dart
  core/widgets_bridge/ payload.dart, push.dart
  core/theme/         brand_colors.dart, typography.dart
  features/home/      features/lookup/   features/year/
  features/month/     features/holidays/ features/counters/
  features/tools/     day_calculator.dart, workdays.dart, pregnancy.dart, shifts.dart
  features/notes/     week_notes.dart
  features/settings/
  l10n/               app_fi.arb, app_en.arb
  routing/            deep_links.dart
assets/data/          holidays.json, flag_days.json, school_holidays.json
android/app/src/main/kotlin/fi/viikkonro/app/
  MainActivity.kt, WeekTileService.kt, widget/*.kt
ios/ViikkonroWidgets/   Swift widget extension target
ios/Runner/             AppDelegate.swift, App Intents
test/fixtures/          iso_week_fixture.json, holidays_fixture.json
6. Date core and the parity guard

The ISO week algorithm will now exist in four places: JS on the site, Dart in the app, Kotlin in the Android widget, Swift in the iOS widget. That is exactly the duplication that produced the /en artifact, so guard it mechanically.

Dart: hand rolled, mirroring dateUtils.jsx line for line. Normalise to a date only DateTime(y, m, d) before any math or DST will hand you off by one weeks
Kotlin: java.time.temporal.WeekFields.ISO, standard library, no hand rolling
Swift: Calendar(identifier: .iso8601) with firstWeekday = 2 and minimumDaysInFirstWeek = 4, then component(.weekOfYear:) and component(.yearForWeekOfYear:). Standard library, no hand rolling

Then prove they agree:

A script in the weekdays repo emits iso_week_fixture.json: every date from 2020 through 2035 with its ISO week, ISO year, the week's Monday and Sunday, plus weeksInIsoYear per year. A second fixture covers holidays, flag days and school holidays including the confidence tier.
Both fixtures are committed to test/fixtures/ and symlinked or copied into the Android and iOS test targets.
Three test suites read the same files: flutter test, a Kotlin JVM unit test, and an XCTest. Any drift fails CI.

Ship this harness before any UI exists. It is the single highest leverage thing in the plan.

7. Widget set, both platforms

Seven concepts. Android gets seven providers, iOS gets one widget extension containing a WidgetBundle of seven widgets plus the accessory families.

#	Name	Android	iOS home	iOS Lock Screen	Config
1	Viikko mini	1x1, 2x1	systemSmall	circular, inline	none
2	Viikkokortti	2x2	systemSmall, systemMedium	rectangular	theme
3	Viikkonauha	4x1, 4x2	systemMedium	no	theme
4	Kuukausi	4x4, 5x5	systemLarge	no	rolling vs calendar month
5	Laskuri	2x2, 4x2	systemSmall, systemMedium	circular, rectangular	required, target picker
6	Pyhät ja liputus	4x1, 2x2	systemMedium	rectangular	flag days on or off
7	Koululomat	4x2	systemMedium	no	required, city picker

Content:

Week number alone. vk 38. Nothing else. This will be the most installed one
Week number large, today's date, Monday to Sunday span, next holiday countdown line
Seven days of the current week, today circled, holidays dotted amber, week number at left, each day tappable
Month grid with the week number gutter, holidays marked, today highlighted
Days until a chosen target: a holiday, a custom date, a week number, or a recurring period. Multiple instances
Next Finnish holiday and next flag day, with dates and days remaining
Next loma for the chosen city, with an honest "arvio" badge when the underlying data is tiered as estimated
Android implementation

One GlanceAppWidget plus GlanceAppWidgetReceiver and appwidget_info.xml per entry, so all seven appear separately in the picker. SizeMode.Responsive with an explicit size set, never SizeMode.Single, or the big numerals clip on resize. Configuration activities for 5 and 7 are Flutter routes launched through home_widget, writing per instance keys like counter_${appWidgetId}_target. Support themed icons and Material You dynamic colour, default to brand green.

Refresh: a WorkManager job at 00:05 daily, plus ACTION_DATE_CHANGED and ACTION_TIMEZONE_CHANGED receivers, plus a push on app foreground. Never set updatePeriodMillis under 30 minutes, the system ignores it.

iOS implementation

WidgetKit is a timeline system, not a push system, and this is an advantage here. Your data is fully deterministic, so the TimelineProvider returns entries computed for the next 14 midnights in one pass, and the system renders them with no app process, no background work and no battery cost. Use .after(nextMidnight) as the reload policy.

Consequence: the Swift side must be able to compute everything itself. Push the holiday and school holiday JSON into the App Group container from Dart on every app launch, and have the widget read from there. Compute week math natively in Swift, never read a precomputed week number from UserDefaults, because a stale cached value will render for days if the app is never opened.

Configuration for 5 and 7 uses AppIntentConfiguration with an AppIntent and a dynamic options provider (the city list for widget 7 comes from the shared JSON). This is native iOS, not a Flutter route.

Also ship: the widget extension needs its own copy of the fonts and colours, its own asset catalog, and the com.apple.security.application-groups entitlement on both the app and the extension targets.

Quick access surfaces
Android: TileService showing the current week number in the notification shade. Half a day of work, highest daily touchpoint per effort in the whole plan
iOS 18: a Control Widget for Control Centre and the Lock Screen buttons, same purpose
iOS App Intents: MikaViikkoNytIntent so "Hei Siri, mikä viikko nyt" answers spoken. Also surfaces in Spotlight and Shortcuts. This is a genuine iOS differentiator that nobody in this category has built
8. App functionality
Core, v1.0
Current week home screen: week number large, date, Monday to Sunday span, day of year, holiday or flag day status for today
Date to week lookup with a picker
Week to date lookup (week plus year returns the span)
Year grid: all 52 or 53 weeks, current highlighted, jump to any year
Month view with the week number gutter and holidays marked
Finnish holidays list per year
Full offline operation, first launch included, from bundled JSON
Finnish default and English, light and dark
Tools that make it more than the website
Päivälaskuri: days between two dates, with and without weekends, and with Finnish public holidays excluded
Työpäivälaskuri: working days remaining in the current month, quarter and year
Viikkomuistiinpanot: a short note attached to a week number, stored locally. This is what converts a lookup tool into something people reopen
Palkkapäivä ja laskutusjaksot: recurring period tracker (every two weeks, monthly, custom) showing the next date and its week number. Feeds widget 5 directly
Raskausviikkolaskuri: pregnancy week from the last period date. Enormous Finnish search volume, it is literally week number math, and it earns its own App Store keyword and deep link
Vuorotyölaskuri: shift rotation patterns projected onto the week grid. Finnish shift workers are a large, calendar obsessed, badly served audience
Auringonnousu ja lasku per city, computed offline with no API. The kaamos swing is a permanent Finnish talking point
Platform integrations
Calendar export of a week or a holiday through the system intent on Android and EKEventEditViewController on iOS. No permission needed for the editor flow on either
ICS subscription once the per city school holiday feed ships on the site. The app becomes its distribution channel
App shortcuts (Android long press) and Home Screen quick actions (iOS 3D Touch menu): "tämä viikko", "hae päivä", "pyhät"
Share sheet emitting Viikko 38/2026 (14.9. to 20.9.) plus a viikkonro.fi link. Free referral traffic and backlinks
Optional Monday 08:00 notification with the new week number, off by default. On iOS use a repeating local notification, no server, no push certificate
Wear OS complication and Apple Watch complication, both via the same accessory widget concepts. Later, but high novelty in a category where nobody bothered
Data still gated

Nimipäivät remains blocked on the licensing verification you flagged. It is one of the highest frequency daily lookups in Finland and would strengthen widgets 1, 2 and 6 considerably. Worth resolving before v1.1 rather than after.

Explicitly out

No accounts or cloud sync in v1. The approved Google Mobile Ads, Firebase Crashlytics and Google Analytics SDKs add no runtime permission beyond INTERNET. Store privacy disclosures must accurately declare advertising, diagnostics and analytics collection.

9. Deep links

Android: app_links plus intent filters for viikkonro.fi, mapping /viikko-{n}-{yyyy}, year and month routes onto the matching screens. Host /.well-known/assetlinks.json with the Play App Signing SHA256 fingerprint, not your upload key.

iOS: Associated Domains entitlement with applinks:viikkonro.fi, and an apple-app-site-association file at /.well-known/ served as application/json with no file extension and no redirect.

Given the Cloudflare behaviour you hit before, verify both files from the raw *.vercel.app deployment URL first, then through the domain. iOS fetches the AASA through Apple's CDN, so a stale Cloudflare copy will silently break universal links for days with no error message anywhere.

Once live, add MobileApplication nodes to the site's JSON LD graph and link both store listings from the footer and /ukk.
