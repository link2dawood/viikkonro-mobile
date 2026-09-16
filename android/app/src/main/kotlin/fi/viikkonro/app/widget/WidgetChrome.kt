package fi.viikkonro.app.widget

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceModifier
import androidx.glance.GlanceId
import androidx.glance.action.Action
import androidx.glance.action.clickable
import androidx.glance.appwidget.action.actionStartActivity
import androidx.glance.appwidget.AppWidgetId
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.cornerRadius
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import fi.viikkonro.app.MainActivity
import fi.viikkonro.app.R
import fi.viikkonro.app.widget.shared.WidgetOptions
import fi.viikkonro.app.widget.shared.WidgetPrefs

/** Common per-instance lifecycle for every configurable widget. */
@Suppress("RestrictedApi")
abstract class ConfiguredWidget : GlanceAppWidget() {
    protected fun options(context: Context, id: GlanceId): WidgetOptions =
        WidgetPrefs.options(context, (id as AppWidgetId).appWidgetId)

    override suspend fun onDelete(context: Context, glanceId: GlanceId) {
        WidgetPrefs.clear(context, (glanceId as AppWidgetId).appWidgetId)
    }
}

/**
 * The default palette matches `lib/core/theme/brand_theme.dart`; each widget
 * can opt into Android 12+ wallpaper colors from its configuration screen.
 */
private data class WidgetPalette(
    val surface: ColorProvider,
    val onSurface: ColorProvider,
    val muted: ColorProvider,
    val primary: ColorProvider,
    val secondary: ColorProvider,
    val secondaryText: ColorProvider,
    val divider: ColorProvider,
    val selected: ColorProvider,
)

private val fixedPalette = WidgetPalette(
    surface = ColorProvider(R.color.brand_card),
    onSurface = ColorProvider(R.color.brand_ink),
    muted = ColorProvider(R.color.brand_soft),
    primary = ColorProvider(R.color.brand_accent),
    secondary = ColorProvider(R.color.brand_amber),
    secondaryText = ColorProvider(R.color.brand_amber_text),
    divider = ColorProvider(R.color.brand_divider),
    selected = ColorProvider(R.color.brand_selected),
)

private val dynamicPalette = WidgetPalette(
    surface = ColorProvider(R.color.widget_dynamic_surface),
    onSurface = ColorProvider(R.color.widget_dynamic_on_surface),
    muted = ColorProvider(R.color.widget_dynamic_muted),
    primary = ColorProvider(R.color.widget_dynamic_primary),
    secondary = ColorProvider(R.color.widget_dynamic_secondary),
    secondaryText = ColorProvider(R.color.widget_dynamic_secondary_text),
    divider = ColorProvider(R.color.widget_dynamic_divider),
    selected = ColorProvider(R.color.widget_dynamic_selected),
)

private val LocalWidgetPalette = staticCompositionLocalOf { fixedPalette }

object Brand {
    val surface: ColorProvider @Composable get() = LocalWidgetPalette.current.surface
    val onSurface: ColorProvider @Composable get() = LocalWidgetPalette.current.onSurface
    val muted: ColorProvider @Composable get() = LocalWidgetPalette.current.muted
    val primary: ColorProvider @Composable get() = LocalWidgetPalette.current.primary
    val secondary: ColorProvider @Composable get() = LocalWidgetPalette.current.secondary
    val secondaryText: ColorProvider @Composable get() = LocalWidgetPalette.current.secondaryText
    val divider: ColorProvider @Composable get() = LocalWidgetPalette.current.divider
    val selected: ColorProvider @Composable get() = LocalWidgetPalette.current.selected
}

/** A shape as well as a colour, so holiday and flag markers remain distinct. */
@Composable
fun EventMarker(isHoliday: Boolean) {
    Box(
        modifier = GlanceModifier
            .size(width = if (isHoliday) 7.dp else 10.dp, height = if (isHoliday) 7.dp else 4.dp)
            .background(if (isHoliday) Brand.secondary else Brand.primary)
            .cornerRadius(if (isHoliday) 4.dp else 2.dp),
    ) {}
}

/** Confidence is intentionally rendered as a badge everywhere it appears. */
@Composable
fun ConfidenceBadge(text: String) {
    Text(
        text,
        modifier = GlanceModifier
            .background(Brand.selected)
            .cornerRadius(8.dp)
            .padding(horizontal = 6.dp, vertical = 2.dp),
        style = bodyStyle(9, Brand.secondaryText),
        maxLines = 1,
    )
}

/** Compact brand mark and title used by detailed widgets when space permits. */
@Composable
fun WidgetHeader(title: String, titleSize: Int = 9, trailing: (@Composable () -> Unit)? = null) {
    Row(
        modifier = GlanceModifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(
            modifier = GlanceModifier
                .size(16.dp)
                .background(Brand.primary)
                .cornerRadius(5.dp),
            contentAlignment = Alignment.Center,
        ) {
            Text("V", style = bodyStyle(9, Brand.surface))
        }
        Spacer(GlanceModifier.size(6.dp))
        Text(title, style = bodyStyle(titleSize, Brand.primary), maxLines = 1)
        if (trailing != null) {
            Spacer(GlanceModifier.defaultWeight())
            trailing()
        }
    }
}

@Composable
fun titleStyle(size: Int) = TextStyle(
    color = Brand.onSurface,
    fontSize = size.sp,
    fontWeight = FontWeight.Bold,
)

@Composable
fun bodyStyle(size: Int, color: ColorProvider = Brand.muted) = TextStyle(
    color = color,
    fontSize = size.sp,
)

const val ROUTE_EXTRA = "fi.viikkonro.app.route"

/**
 * FP-W12: a widget tap opens the screen it is showing, not the home screen.
 * The route travels as the intent data so a cold start can read it before the
 * Dart side has built anything.
 */
fun openRoute(context: Context, route: String): Action = actionStartActivity(
    Intent(context, MainActivity::class.java)
        .setAction(Intent.ACTION_VIEW)
        .setData(Uri.parse("viikkonro://widget$route"))
        .putExtra(ROUTE_EXTRA, route)
        .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
)

internal fun GlanceModifier.clickableRoute(context: Context, route: String): GlanceModifier =
    this.clickable(openRoute(context, route))

/** The common card: brand surface, rounded, padded, and tappable as a whole. */
@Composable
fun WidgetCard(
    context: Context,
    route: String,
    padding: Int = 10,
    dynamicColors: Boolean = false,
    content: @Composable () -> Unit,
) {
    CompositionLocalProvider(LocalWidgetPalette provides if (dynamicColors) dynamicPalette else fixedPalette) {
        Box(
            modifier = GlanceModifier
                .fillMaxSize()
                .background(Brand.surface)
                .cornerRadius(R.dimen.widget_corner_radius)
                .padding(padding.dp)
                .clickableRoute(context, route),
            contentAlignment = Alignment.Center,
        ) { content() }
    }
}
