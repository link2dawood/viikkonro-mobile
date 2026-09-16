# Widget visual test matrix

Run this matrix before every store release. The static preview asset dimensions
and non-blank content are enforced by `WidgetPreviewAssetTest`; the remaining
checks require launcher rendering because Glance is translated to OEM-specific
`RemoteViews`.

| Axis | Required coverage |
| --- | --- |
| Android | API 24, 31, 35 and 36 |
| Launcher | Pixel and Samsung One UI |
| Theme | Light, dark, brand and system wallpaper colors |
| Font scale | 100%, 130% and 150% |
| Locale | Finnish, English and German |
| Size | Every provider's minimum, normal and maximum bounds |
| State | Today, ISO year rollover, no future data, estimated school break |

For each case verify that content is not cropped, the widget reaches every grid
edge, visible controls have a 48dp target, confidence badges remain present and
the picker preview matches the placed widget.
