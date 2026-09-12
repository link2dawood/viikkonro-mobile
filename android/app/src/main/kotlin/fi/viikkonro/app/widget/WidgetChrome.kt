package fi.viikkonro.app.widget

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceModifier
import androidx.glance.action.Action
import androidx.glance.action.clickable
import androidx.glance.appwidget.action.actionStartActivity
import androidx.glance.appwidget.cornerRadius
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.padding
import androidx.glance.text.FontWeight
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import fi.viikkonro.app.MainActivity
import fi.viikkonro.app.R

/**
 * The brand palette, matching `lib/core/theme/brand_theme.dart`. Material You
 * is an opt-in for a later release (FP-W13); the default is brand green.
 */
object Brand {
    val surface = ColorProvider(R.color.brand_card)
    val onSurface = ColorProvider(R.color.brand_ink)
    val muted = ColorProvider(R.color.brand_soft)
    val primary = ColorProvider(R.color.brand_accent)
    val secondary = ColorProvider(R.color.brand_amber)
    val divider = ColorProvider(R.color.brand_divider)
    val selected = ColorProvider(R.color.brand_selected)
}

fun titleStyle(size: Int) = TextStyle(
    color = Brand.onSurface,
    fontSize = size.sp,
    fontWeight = FontWeight.Bold,
)

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
    content: @Composable () -> Unit,
) {
    Box(
        modifier = GlanceModifier
            .fillMaxSize()
            .background(Brand.surface)
            .cornerRadius(18.dp)
            .padding(padding.dp)
            .clickableRoute(context, route),
        contentAlignment = Alignment.Center,
    ) { content() }
}
