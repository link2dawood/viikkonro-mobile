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
import androidx.glance.layout.width
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import fi.viikkonro.app.widget.shared.WidgetModel
import fi.viikkonro.app.widget.shared.WidgetOptions
import fi.viikkonro.app.widget.shared.WidgetText

/** FP-W05: Kuukausi, 4x4 and 5x5, a month grid with the ISO week gutter. */
class MonthWidget : ConfiguredWidget() {
    private val previewSizes = setOf(DpSize(250.dp, 250.dp), DpSize(320.dp, 320.dp))
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
        val large = LocalSize.current.width >= 300.dp
        val cell = if (large) 14 else 12
        val initials = WidgetText.weekdayInitials(ctx)
        WidgetCard(
            ctx,
            "/kuukausi-${model.today.monthValue}-${model.today.year}",
            padding = 10,
            dynamicColors = options.dynamicColors,
        ) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                WidgetHeader(
                    "${WidgetText.monthName(ctx, model.today.monthValue)} ${model.today.year}",
                    titleSize = if (large) 15 else 13,
                )
                Spacer(GlanceModifier.height(6.dp))
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    Text(
                        WidgetText.week(ctx).take(2).lowercase(),
                        style = bodyStyle(9),
                        modifier = GlanceModifier.width(22.dp),
                    )
                    initials.forEach {
                        Text(
                            it,
                            style = bodyStyle(9).copy(textAlign = TextAlign.Center),
                            modifier = GlanceModifier.defaultWeight(),
                        )
                    }
                }
                model.monthGrid().forEach { week ->
                    Row(
                        modifier = GlanceModifier.fillMaxWidth().padding(vertical = 1.dp),
                        verticalAlignment = Alignment.CenterVertically,
                    ) {
                        Text(
                            "${fi.viikkonro.app.widget.shared.IsoWeek.week(week.first())}",
                            style = bodyStyle(cell - 2, Brand.primary),
                            modifier = GlanceModifier.width(22.dp),
                        )
                        week.forEach { date ->
                            val inMonth = date.monthValue == model.today.monthValue
                            val isToday = date == model.today
                            Box(
                                modifier = GlanceModifier
                                    .defaultWeight()
                                    .background(if (isToday) Brand.selected else Brand.surface)
                                    .cornerRadius(8.dp),
                                contentAlignment = Alignment.Center,
                            ) {
                                Text(
                                    "${date.dayOfMonth}",
                                    style = bodyStyle(
                                        cell,
                                        when {
                                            !inMonth -> Brand.muted
                                            options.showEvents && model.isPublicHoliday(date) -> Brand.secondaryText
                                            else -> Brand.onSurface
                                        },
                                    ).copy(textAlign = TextAlign.Center),
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

class MonthReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MonthWidget()
}

/**
 * FP-W06: Laskuri. The default target is the next public holiday; each widget
 * instance can instead select the next flag day in the native configuration.
 */
class CountdownWidget : ConfiguredWidget() {
    private val previewSizes = setOf(DpSize(130.dp, 57.dp), DpSize(130.dp, 130.dp))
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
        val holiday = if (options.countdownTarget == WidgetOptions.TARGET_FLAG_DAY) {
            model.nextFlagDay
        } else {
            model.nextHoliday
        }
        val compact = LocalSize.current.height < 90.dp
        WidgetCard(
            ctx,
            "/pyhapaivat-${model.today.year}",
            padding = if (compact) 8 else 10,
            dynamicColors = options.dynamicColors,
        ) {
            if (holiday == null) {
                Text(
                    ctx.getString(
                        if (options.countdownTarget == WidgetOptions.TARGET_FLAG_DAY) {
                            fi.viikkonro.app.R.string.widget_no_upcoming_flag_day
                        } else {
                            fi.viikkonro.app.R.string.widget_no_upcoming_holiday
                        },
                    ),
                    style = bodyStyle(12),
                    maxLines = 3,
                )
            } else if (compact) {
                Row(modifier = GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                    Text("${model.daysUntil(holiday.date)}", style = titleStyle(28))
                    Spacer(GlanceModifier.width(8.dp))
                    Column {
                        Text(
                            WidgetText.dayCount(ctx, model.daysUntil(holiday.date)),
                            style = bodyStyle(10, Brand.primary),
                        )
                        Text(holiday.name, style = bodyStyle(12, Brand.onSurface), maxLines = 1)
                    }
                }
            } else {
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    Text("${model.daysUntil(holiday.date)}", style = titleStyle(36))
                    Text(WidgetText.dayCount(ctx, model.daysUntil(holiday.date)), style = bodyStyle(11, Brand.primary))
                    Spacer(GlanceModifier.height(5.dp))
                    Text(
                        holiday.name,
                        style = bodyStyle(12, Brand.onSurface).copy(textAlign = TextAlign.Center),
                        maxLines = 2,
                    )
                }
            }
        }
    }
}

class CountdownReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = CountdownWidget()
}

/** FP-W07: Pyhät ja liputus, the next public holiday and the next flag day. */
class HolidaysWidget : ConfiguredWidget() {
    private val previewSizes = setOf(DpSize(130.dp, 130.dp), DpSize(250.dp, 110.dp))
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
        val wide = LocalSize.current.width >= 210.dp
        WidgetCard(ctx, "/pyhapaivat-${model.today.year}", padding = 10, dynamicColors = options.dynamicColors) {
            if (wide) {
                Row(modifier = GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                    Entry(
                        isHoliday = true,
                        heading = ctx.getString(fi.viikkonro.app.R.string.widget_next_holiday),
                        name = model.nextHoliday?.name,
                        date = model.nextHoliday?.let { WidgetText.shortDate(it.date) },
                        countdown = model.nextHoliday?.let { WidgetText.dayCount(ctx, model.daysUntil(it.date)) },
                        emptyText = ctx.getString(fi.viikkonro.app.R.string.widget_no_upcoming_holiday),
                        modifier = GlanceModifier.defaultWeight(),
                    )
                    Spacer(GlanceModifier.width(12.dp))
                    Entry(
                        isHoliday = false,
                        heading = ctx.getString(fi.viikkonro.app.R.string.widget_next_flag_day),
                        name = model.nextFlagDay?.name,
                        date = model.nextFlagDay?.let { WidgetText.shortDate(it.date) },
                        countdown = model.nextFlagDay?.let { WidgetText.dayCount(ctx, model.daysUntil(it.date)) },
                        emptyText = ctx.getString(fi.viikkonro.app.R.string.widget_no_upcoming_flag_day),
                        modifier = GlanceModifier.defaultWeight(),
                    )
                }
            } else {
                Column(modifier = GlanceModifier.fillMaxWidth()) {
                    Entry(
                        isHoliday = true,
                        heading = ctx.getString(fi.viikkonro.app.R.string.widget_next_holiday),
                        name = model.nextHoliday?.name,
                        date = model.nextHoliday?.let { WidgetText.shortDate(it.date) },
                        countdown = model.nextHoliday?.let { WidgetText.dayCount(ctx, model.daysUntil(it.date)) },
                        emptyText = ctx.getString(fi.viikkonro.app.R.string.widget_no_upcoming_holiday),
                    )
                    Spacer(GlanceModifier.height(8.dp))
                    Entry(
                        isHoliday = false,
                        heading = ctx.getString(fi.viikkonro.app.R.string.widget_next_flag_day),
                        name = model.nextFlagDay?.name,
                        date = model.nextFlagDay?.let { WidgetText.shortDate(it.date) },
                        countdown = null,
                        emptyText = ctx.getString(fi.viikkonro.app.R.string.widget_no_upcoming_flag_day),
                    )
                }
            }
        }
    }
}

class HolidaysReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = HolidaysWidget()
}

/**
 * FP-W08: Koululomat for the selected city, with the estimate badge whenever
 * the published tier is anything short of confirmed.
 */
class SchoolHolidayWidget : ConfiguredWidget() {
    private val previewSizes = setOf(DpSize(130.dp, 130.dp), DpSize(250.dp, 110.dp))
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
        val city = options.city
        val period = model.nextSchoolBreak(city)
        WidgetCard(ctx, "/koululomat-${model.today.year}", padding = 12, dynamicColors = options.dynamicColors) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                WidgetHeader(ctx.getString(fi.viikkonro.app.R.string.widget_school_break).uppercase()) {
                    // FP-D08: the tier is shown wherever the entry is shown.
                    period?.confidence?.let { WidgetText.confidence(ctx, it) }?.let { badge ->
                        ConfidenceBadge(badge)
                    }
                }
                Spacer(GlanceModifier.height(6.dp))
                if (period?.start == null || period.end == null) {
                    Text(
                        ctx.getString(fi.viikkonro.app.R.string.widget_school_not_published),
                        style = bodyStyle(12),
                        maxLines = 3,
                    )
                } else {
                    Text(
                        ctx.getString(
                            if (period.kind == "winter") fi.viikkonro.app.R.string.widget_winter_break
                            else fi.viikkonro.app.R.string.widget_autumn_break,
                        ),
                        style = titleStyle(15),
                    )
                    Text(WidgetText.span(period.start, period.end), style = bodyStyle(12), maxLines = 1)
                    Spacer(GlanceModifier.height(4.dp))
                    Text(city ?: period.cities.take(2).joinToString(", "), style = bodyStyle(10), maxLines = 1)
                }
            }
        }
    }
}

class SchoolHolidayReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = SchoolHolidayWidget()
}

@Composable
private fun Entry(
    isHoliday: Boolean,
    heading: String,
    name: String?,
    date: String?,
    countdown: String?,
    emptyText: String,
    modifier: GlanceModifier = GlanceModifier,
) {
    Column(modifier = modifier) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            EventMarker(isHoliday)
            Spacer(GlanceModifier.width(5.dp))
            Text(heading.uppercase(), style = bodyStyle(8, Brand.primary), maxLines = 1)
        }
        Text(
            name ?: emptyText,
            style = bodyStyle(13, Brand.onSurface), maxLines = 2,
        )
        if (date != null) {
            Row {
                Text(date, style = bodyStyle(11))
                Spacer(GlanceModifier.width(8.dp))
                Text(countdown ?: "", style = bodyStyle(11, Brand.secondaryText))
            }
        }
    }
}
