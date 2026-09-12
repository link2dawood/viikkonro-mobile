import 'package:flutter/widgets.dart';

/// Reserved integration point for a future release. In v1 this renders nothing,
/// reserves no space, performs no network requests and loads no advertising SDK.
class AdSlot extends StatelessWidget {
  const AdSlot({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
