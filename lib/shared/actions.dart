import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'formatters.dart';

/// Canonical viikkonro.fi routes. These must stay identical to the site's own
/// slugs so shared links resolve on the web and re-enter the app as deep links.
abstract final class SiteUrl {
  static const origin = 'https://viikkonro.fi';
  static String week(int week, int year) => '$origin/viikko-$week-$year';
  static String weeks(int year) => '$origin/vuosi-$year';
  static String month(int month, int year) => '$origin/kuukausi-$month-$year';
  static String holidays(int year) => '$origin/pyhapaivat-$year';
  static String flags(int year) => '$origin/liputuspaivat-$year';
  static String school(int year) => '$origin/koululomat-$year';
  static String path(String slug) => '$origin/$slug';
}

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
}

/// FP-X03: every copy confirms, so the user never wonders whether it worked.
Future<void> copyText(BuildContext context, String text) async {
  final confirmation = context.s.copied;
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) showToast(context, confirmation);
}

/// iOS needs an anchor rectangle or the share sheet has nothing to point at.
Future<void> shareText(BuildContext context, String text) async {
  final box = context.findRenderObject() as RenderBox?;
  final origin = box == null || !box.hasSize ? null : box.localToGlobal(Offset.zero) & box.size;
  await SharePlus.instance.share(ShareParams(text: text, sharePositionOrigin: origin));
}

Future<void> openUrl(BuildContext context, String url) async {
  final failure = context.s.openFailed;
  var opened = false;
  try {
    opened = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } on PlatformException {
    opened = false;
  }
  if (!opened && context.mounted) showToast(context, failure);
}

/// Copy, share and open-on-the-website, together, because every result surface
/// in the spec offers the same three actions over the same text and URL.
class ResultActions extends StatelessWidget {
  const ResultActions({super.key, required this.text, required this.url});
  final String text, url;
  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final shareLine = '$text\n$url';
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          TextButton.icon(onPressed: () => copyText(context, shareLine), icon: const Icon(Icons.copy_rounded, size: 18), label: Text(s.copy)),
          TextButton.icon(onPressed: () => shareText(context, shareLine), icon: const Icon(Icons.ios_share_rounded, size: 18), label: Text(s.share)),
          TextButton.icon(onPressed: () => openUrl(context, url), icon: const Icon(Icons.open_in_new_rounded, size: 18), label: Text(s.openWebsite)),
        ],
      ),
    );
  }
}
