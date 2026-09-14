import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_service.dart';

/// A single standard 320x50 banner. Slots remain opt-in so the five tab bodies
/// in AppShell do not all request hidden ads from their IndexedStack.
class AdSlot extends StatefulWidget {
  const AdSlot({super.key, this.enabled = false});

  final bool enabled;

  @override
  State<AdSlot> createState() => _AdSlotState();
}

class _AdSlotState extends State<AdSlot> {
  final _service = AdService.instance;
  BannerAd? _banner;
  bool _loading = false;
  bool _hasSpace = false;

  @override
  void initState() {
    super.initState();
    _service.addListener(_loadIfReady);
    _loadIfReady();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // PageBody reserves 20 logical pixels on each side. A standard banner is
    // 320 wide, so smaller windows do not request an ad they cannot display.
    _hasSpace = MediaQuery.sizeOf(context).width >= 360;
    _loadIfReady();
  }

  @override
  void dispose() {
    _service.removeListener(_loadIfReady);
    _banner?.dispose();
    super.dispose();
  }

  void _loadIfReady() {
    if (!widget.enabled ||
        !_hasSpace ||
        !_service.canRequestAds ||
        _loading ||
        _banner != null) {
      return;
    }
    final id = _service.bannerAdUnitId;
    if (id == null || id.isEmpty) return;
    _loading = true;
    BannerAd(
      adUnitId: id,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() => _banner = ad as BannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _loading = false;
          debugPrint('AdMob banner failed: ${error.message}');
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    final banner = _banner;
    if (!widget.enabled ||
        !_hasSpace ||
        banner == null ||
        defaultTargetPlatform != TargetPlatform.android) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: SizedBox(
          width: banner.size.width.toDouble(),
          height: banner.size.height.toDouble(),
          child: AdWidget(ad: banner),
        ),
      ),
    );
  }
}
