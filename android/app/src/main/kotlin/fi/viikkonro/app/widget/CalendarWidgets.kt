package fi.viikkonro.app.widget

import android.content.Context
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.LocalContext
import androidx.glance.LocalSize
import androidx.glance.appwidget.GlanceAppWidget
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
import fi.viikkonro.app.widget.shared.WidgetPrefs
import fi.viikkonro.app.widget.shared.WidgetText

/** FP-W05: Kuukausi, 4x4 and 5x5, a month grid with the ISO week gutter. */
class MonthWidget : GlanceAppWidget() {
    override val sizeMode = SizeMode.Responsive(setOf(DpSize(250.dp, 250.dp), DpSize(320.dp, 320.dp)))

    override suspend fun provideGlance(context: Context, id: GlanceId) = provideContent {
        val ctx = LocalContext.current
        val model = WidgetModel(ctx)
        val large = LocalSize.current.width >= 300.dp
        val cell = if (large) 13 else 11
        val initials = WidgetText.weekdayInitials(ctx)
        WidgetCard(ctx, "/kuukausi-${model.today.monthValue}-${model.today.year}", padding = 10) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                Text(
                    "${WidgetText.monthName(ctx, model.today.monthValue)} ${model.today.year}",
                    style = titleStyle(if (large) 15 else 13),
                )
                Spacer(GlanceModifier.height(6.dp))
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    Text(
                        WidgetText.week(ctx).take(2).lowercase(),
                        style = bodyStyle(8),
                        modifier = GlanceModifier.width(22.dp),
                    )
                    initials.forEach {
                        Text(
                            it,
                            style = bodyStyle(8).copy(textAlign = TextAlign.Center),
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
                            modifier = GlanceModifier
                                .width(22.dp)
                                .clickableRoute(
                                    ctx,
                                    "/viikko-${fi.viikkonro.app.widget.shared.IsoWeek.week(week.first())}" +
                                        "-${fi.viikkonro.app.widget.shared.IsoWeek.year(week.first())}",
                                ),
                        )
                        week.forEach { date ->
                            val inMonth = date.monthValue == model.today.monthValue
                            val isToday = date == model.today
                            Box(
                                modifier = GlanceModifier
                                    .defaultWeight()
                                    .background(if (isToday) Brand.selected else Brand.surface)
                                    .cornerRadius(8.dp)
                                    .clickableRoute(ctx, "/viikonpaiva?paiva=$date"),
                                contentAlignment = Alignment.Center,
                            ) {
                                Text(
                                    "${date.dayOfMonth}",
                                    style = bodyStyle(
                                        cell,
                                        when {
                                            !inMonth -> Brand.divider
                                            model.isPublicHoliday(date) -> Brand.secondary
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
 * FP-W06: Laskuri. Per-instance configuration is a later release; this ships
 * the one target that needs no setup, the next public holiday.
 */
class CountdownWidget : GlanceAppWidget() {
    override val sizeMode = SizeMode.Responsive(setOf(DpSize(130.dp, 57.dp), DpSize(130.dp, 130.dp)))

    override suspend fun provideGlance(context: Context, id: GlanceId) = provideContent {
        val ctx = LocalContext.current
        val model = WidgetModel(ctx)
        val holiday = model.nextHoliday
        WidgetCard(ctx, "/pyhapaivat-${model.today.year}", padding = 10) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                if (holiday == null) {
                    Text(ctx.getString(fi.viikkonro.app.R.string.widget_no_data), style = bodyStyle(12))
                } else {
                    Text("${model.daysUntil(holiday.date)}", style = titleStyle(32))
                    Text(
                        WidgetText.dayCount(ctx, model.daysUntil(holiday.date)),
                        style = bodyStyle(10, Brand.primary),
                    )
                    Spacer(GlanceModifier.height(4.dp))
                    Text(
                        holiday.name,
                        style = bodyStyle(11, Brand.onSurface).copy(textAlign = TextAlign.Center),
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
class HolidaysWidget : GlanceAppWidget() {
    override val sizeMode = SizeMode.Responsive(setOf(DpSize(130.dp, 130.dp), DpSize(250.dp, 110.dp)))

    override suspend fun provideGlance(context: Context, id: GlanceId) = provideContent {
        val ctx = LocalContext.current
        val model = WidgetModel(ctx)
        WidgetCard(ctx, "/pyhapaivat-${model.today.year}", padding = 12) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                Entry(
                    ctx,
                    ctx.getString(fi.viikkonro.app.R.string.widget_next_holiday),
                    model.nextHoliday?.name,
                    model.nextHoliday?.let { WidgetText.shortDate(it.date) },
                    model.nextHoliday?.let { WidgetText.dayCount(ctx, model.daysUntil(it.date)) },
                )
                Spacer(GlanceModifier.height(10.dp))
                Entry(
                    ctx,
                    ctx.getString(fi.viikkonro.app.R.string.widget_next_flag_day),
                    model.nextFlagDay?.name,
                    model.nextFlagDay?.let { WidgetText.shortDate(it.date) },
                    model.nextFlagDay?.let { WidgetText.dayCount(ctx, model.daysUntil(it.date)) },
                )
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
class SchoolHolidayWidget : GlanceAppWidget() {
    override val sizeMode = SizeMode.Responsive(setOf(DpSize(130.dp, 130.dp), DpSize(250.dp, 110.dp)))

    override suspend fun provideGlance(context: Context, id: GlanceId) = provideContent {
        val ctx = LocalContext.current
        val model = WidgetModel(ctx)
        val city = WidgetPrefs.city(ctx)
        val period = model.nextSchoolBreak(city)
        WidgetCard(ctx, "/koululomat-${model.today.year}", padding = 12) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                Row(modifier = GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                    Text(
                        ctx.getString(fi.viikkonro.app.R.string.widget_school_break).uppercase(),
                        style = bodyStyle(9, Brand.primary),
                    )
                    Spacer(GlanceModifier.defaultWeight())
                    // FP-D08: the tier is shown wherever the entry is shown.
                    period?.confidence?.let { WidgetText.confidence(ctx, it) }?.let { badge ->
                        Text(badge, style = bodyStyle(9, Brand.secondary))
                    }
                }
                Spacer(GlanceModifier.height(6.dp))
                if (period?.start == null || period.end == null) {
                    Text(ctx.getString(fi.viikkonro.app.R.string.widget_no_data), style = bodyStyle(12))
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

@androidx.compose.runtime.Composable
private fun Entry(context: Context, heading: String, name: String?, date: String?, countdown: String?) {
    Column {
        Text(heading.uppercase(), style = bodyStyle(8, Brand.primary))
        Text(
            name ?: context.getString(fi.viikkonro.app.R.string.widget_no_data),
            style = bodyStyle(13, Brand.onSurface),
            maxLines = 2,
        )
        if (date != null) {
            Row {
                Text(date, style = bodyStyle(11))
                Spacer(GlanceModifier.width(8.dp))
                Text(countdown ?: "", style = bodyStyle(11, Brand.secondary))
            }
        }
    }
}
