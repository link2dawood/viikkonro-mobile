# Store screenshots

These screenshots are rendered from the real Flutter app in Finnish, with a
fixed date so updates stay reproducible. Every image uses the same five-item
bottom navigation bar; only its selected destination changes.

| Set | Output size | Files |
| --- | --- | --- |
| Phone | 1080 x 1920 px | `phone/*.png` |
| Tablet | 1440 x 2560 px | `tablet/*.png` |

Regenerate both sets from the repository root:

```sh
flutter test --update-goldens test/store_screenshot_test.dart
```
