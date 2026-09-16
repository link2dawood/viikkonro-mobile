package fi.viikkonro.app.widget

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.LocalContext
import androidx.glance.LocalSize
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import androidx.glance.appwidget.SizeMode
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.semantics.contentDescription
import androidx.glance.semantics.semantics
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import fi.viikkonro.app.widget.shared.WidgetModel
import fi.viikkonro.app.widget.shared.WidgetOptions
import fi.viikkonro.app.widget.shared.WidgetText

/** FP-W02: Viikko mini, 1x1 and 2x1, the week number and nothing else. */
class WeekMiniWidget : ConfiguredWidget() {
    private val previewSizes = setOf(DpSize(57.dp, 57.dp), DpSize(130.dp, 57.dp))
    override val sizeMode = SizeMode.Exact
    override val previewSizeMode = SizeMode.Responsive(previewSizes)

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val options = options(context, id)
        provideContent { Content(LocalContext.current, WidgetModel(LocalContext.current), options) }
    }

    override suspend fun providePreview(context: Context, widgetCategory: Int) = provideContent {
        Content(LocalContext.current, WidgetModel(LocalContext.current), WidgetOptions())
    }

    @Composable
    private fun Content(ctx: Context, model: WidgetModel, options: WidgetOptions) {
        val wide = LocalSize.current.width >= 100.dp
        // FP-A03: a screen reader says "week 37", never a bare numeral.
        val spoken = WidgetText.weekOf(ctx, model.week, model.weeksInYear)
        WidgetCard(ctx, "/vuosi-${model.isoYear}", padding = 6, dynamicColors = options.dynamicColors) {
            Box(
                modifier = GlanceModifier.semantics { contentDescription = spoken },
                contentAlignment = Alignment.Center,
            ) {
                if (wide) {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Text(WidgetText.week(ctx), style = bodyStyle(13, Brand.primary))
                        Spacer(GlanceModifier.size(6.dp))
                        Text("${model.week}", style = titleStyle(36))
                    }
                } else {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(WidgetText.week(ctx).uppercase(), style = bodyStyle(9, Brand.primary))
                        Text("${model.week}", style = titleStyle(30))
                    }
                }
            }
        }
    }
}

class WeekMiniReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = WeekMiniWidget()
}

/** FP-W03: Viikkokortti, 2x2, week plus date plus span plus the next holiday. */
class WeekCardWidget : ConfiguredWidget() {
    private val previewSizes = setOf(DpSize(130.dp, 130.dp), DpSize(250.dp, 130.dp))
    override val sizeMode = SizeMode.Exact
    override val previewSizeMode = SizeMode.Responsive(previewSizes)

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val options = options(context, id)
        provideContent { Content(LocalContext.current, WidgetModel(LocalContext.current), options) }
    }

    override suspend fun providePreview(context: Context, widgetCategory: Int) = provideContent {
        Content(LocalContext.current, WidgetModel(LocalContext.current), WidgetOptions())
    }

    @Composable
    private fun Content(ctx: Context, model: WidgetModel, options: WidgetOptions) {
        val expanded = LocalSize.current.width >= 190.dp
        WidgetCard(
            ctx,
            "/viikko-${model.week}-${model.isoYear}",
            padding = if (expanded) 12 else 10,
            dynamicColors = options.dynamicColors,
        ) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                WidgetHeader(WidgetText.week(ctx).uppercase())
                Row(verticalAlignment = Alignment.Bottom) {
                    Text("${model.week}", style = titleStyle(if (expanded) 38 else 34))
                    Spacer(GlanceModifier.size(6.dp))
                    Text("/ ${model.isoYear}", style = bodyStyle(12))
                }
                Spacer(GlanceModifier.height(if (expanded) 5.dp else 3.dp))
                Text(
                    WidgetText.span(model.monday, model.days.last()),
                    style = bodyStyle(12, Brand.onSurface),
                    maxLines = 1,
                )
                if (expanded && options.showEvents) {
                    model.nextHoliday?.let { holiday ->
                        Spacer(GlanceModifier.height(7.dp))
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            EventMarker(isHoliday = true)
                            Spacer(GlanceModifier.size(6.dp))
                            Text(holiday.name, style = bodyStyle(12, Brand.onSurface), maxLines = 1)
                        }
                        Text(
                            WidgetText.dayCount(ctx, model.daysUntil(holiday.date)),
                            style = bodyStyle(11, Brand.secondaryText),
                            maxLines = 1,
                        )
                    }
                }
            }
        }
    }
}

class WeekCardReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = WeekCardWidget()
}

/** FP-W04: Viikkonauha, 4x1 and 4x2, the seven days, each one tappable. */
class WeekStripWidget : ConfiguredWidget() {
    private val previewSizes = setOf(DpSize(250.dp, 57.dp), DpSize(250.dp, 110.dp))
    override val sizeMode = SizeMode.Exact
    override val previewSizeMode = SizeMode.Responsive(previewSizes)

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val options = options(context, id)
        provideContent { Content(LocalContext.current, WidgetModel(LocalContext.current), options) }
    }

    override suspend fun providePreview(context: Context, widgetCategory: Int) = provideContent {
        Content(LocalContext.current, WidgetModel(LocalContext.current), WidgetOptions())
    }

    @Composable
    private fun Content(ctx: Context, model: WidgetModel, options: WidgetOptions) {
        val tall = LocalSize.current.height >= 90.dp
        val individualDayTargets = LocalSize.current.width >= 350.dp && LocalSize.current.height >= 100.dp
        val initials = WidgetText.weekdayInitials(ctx)
        WidgetCard(
            ctx,
            "/viikko-${model.week}-${model.isoYear}",
            padding = 8,
            dynamicColors = options.dynamicColors,
        ) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                if (tall) {
                    WidgetHeader(WidgetText.weekOf(ctx, model.week, model.weeksInYear)) {
                        Text(WidgetText.span(model.monday, model.days.last()), style = bodyStyle(11))
                    }
                    Spacer(GlanceModifier.height(6.dp))
                }
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    model.days.forEachIndexed { index, date ->
                        DayCell(
                            context = ctx,
                            label = initials[index],
                            date = date,
                            isToday = date == model.today,
                            isHoliday = options.showEvents && model.isPublicHoliday(date),
                            hasFlagDay = options.showEvents && model.observances(date).any { it.flag },
                            route = if (individualDayTargets) "/viikonpaiva?paiva=$date" else null,
                            modifier = GlanceModifier.defaultWeight(),
                        )
                    }
                }
            }
        }
    }
}

class WeekStripReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = WeekStripWidget()
}

/**
 * One day in the strip. Today is a filled chip and a holiday carries a dot, so
 * the two states never rely on colour alone.
 */
@Composable
internal fun DayCell(
    context: Context,
    label: String,
    date: java.time.LocalDate,
    isToday: Boolean,
    isHoliday: Boolean,
    hasFlagDay: Boolean,
    route: String?,
    modifier: GlanceModifier = GlanceModifier,
) {
    val state = buildList {
        if (isToday) add(context.getString(fi.viikkonro.app.R.string.widget_today))
        if (isHoliday) add(context.getString(fi.viikkonro.app.R.string.widget_next_holiday))
        if (hasFlagDay) add(context.getString(fi.viikkonro.app.R.string.widget_next_flag_day))
    }
    val spoken = buildString {
        append(
            date.dayOfWeek.getDisplayName(
                java.time.format.TextStyle.FULL,
                context.resources.configuration.locales[0],
            ),
        )
        append(", ")
        append(WidgetText.shortDate(date))
        if (state.isNotEmpty()) append(", ${state.joinToString(", ")}")
    }
    val dayModifier = modifier
        .padding(1.dp)
        .semantics { contentDescription = spoken }
    Column(
        modifier = if (route == null) dayModifier else dayModifier.clickableRoute(context, route),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Text(label, style = bodyStyle(9, if (isHoliday) Brand.secondaryText else Brand.muted))
        Box(
            modifier = GlanceModifier
                .background(if (isToday) Brand.primary else Brand.surface)
                .cornerRadius(10.dp)
                .padding(horizontal = 6.dp, vertical = 2.dp),
            contentAlignment = Alignment.Center,
        ) {
            Text(
                "${date.dayOfMonth}",
                style = bodyStyle(13, if (isToday) Brand.surface else Brand.onSurface)
                    .copy(textAlign = TextAlign.Center),
            )
        }
        if (isHoliday || hasFlagDay) {
            EventMarker(isHoliday = isHoliday)
        }
    }
}
