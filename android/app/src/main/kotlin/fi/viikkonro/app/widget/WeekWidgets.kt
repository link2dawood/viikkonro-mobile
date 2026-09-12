package fi.viikkonro.app.widget

import android.content.Context
import androidx.compose.runtime.Composable
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
import androidx.glance.layout.size
import androidx.glance.semantics.contentDescription
import androidx.glance.semantics.semantics
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import fi.viikkonro.app.widget.shared.WidgetModel
import fi.viikkonro.app.widget.shared.WidgetText

/** FP-W02: Viikko mini, 1x1 and 2x1, the week number and nothing else. */
class WeekMiniWidget : GlanceAppWidget() {
    override val sizeMode = SizeMode.Responsive(setOf(DpSize(57.dp, 57.dp), DpSize(130.dp, 57.dp)))

    override suspend fun provideGlance(context: Context, id: GlanceId) = provideContent {
        val ctx = LocalContext.current
        val model = WidgetModel(ctx)
        val wide = LocalSize.current.width >= 110.dp
        // FP-A03: a screen reader says "week 37", never a bare numeral.
        val spoken = WidgetText.weekOf(ctx, model.week, model.weeksInYear)
        WidgetCard(ctx, "/vuosi-${model.isoYear}", padding = 6) {
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
class WeekCardWidget : GlanceAppWidget() {
    override val sizeMode = SizeMode.Responsive(setOf(DpSize(130.dp, 130.dp), DpSize(250.dp, 130.dp)))

    override suspend fun provideGlance(context: Context, id: GlanceId) = provideContent {
        val ctx = LocalContext.current
        val model = WidgetModel(ctx)
        WidgetCard(ctx, "/viikko-${model.week}-${model.isoYear}", padding = 12) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                Text(WidgetText.week(ctx).uppercase(), style = bodyStyle(9, Brand.primary))
                Row(verticalAlignment = Alignment.Bottom) {
                    Text("${model.week}", style = titleStyle(34))
                    Spacer(GlanceModifier.size(6.dp))
                    Text("/ ${model.isoYear}", style = bodyStyle(12))
                }
                Spacer(GlanceModifier.height(6.dp))
                Text(WidgetText.shortDate(model.today), style = titleStyle(14))
                Text(
                    WidgetText.span(model.monday, model.days.last()),
                    style = bodyStyle(11),
                    maxLines = 1,
                )
                model.nextHoliday?.let { holiday ->
                    Spacer(GlanceModifier.height(8.dp))
                    Text(holiday.name, style = bodyStyle(11, Brand.onSurface), maxLines = 2)
                    Text(
                        WidgetText.dayCount(ctx, model.daysUntil(holiday.date)),
                        style = bodyStyle(11, Brand.secondary),
                        maxLines = 1,
                    )
                }
            }
        }
    }
}

class WeekCardReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = WeekCardWidget()
}

/** FP-W04: Viikkonauha, 4x1 and 4x2, the seven days, each one tappable. */
class WeekStripWidget : GlanceAppWidget() {
    override val sizeMode = SizeMode.Responsive(setOf(DpSize(250.dp, 57.dp), DpSize(250.dp, 110.dp)))

    override suspend fun provideGlance(context: Context, id: GlanceId) = provideContent {
        val ctx = LocalContext.current
        val model = WidgetModel(ctx)
        val tall = LocalSize.current.height >= 90.dp
        val initials = WidgetText.weekdayInitials(ctx)
        WidgetCard(ctx, "/viikko-${model.week}-${model.isoYear}", padding = 8) {
            Column(modifier = GlanceModifier.fillMaxWidth()) {
                if (tall) {
                    Row(modifier = GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                        Text(
                            WidgetText.weekOf(ctx, model.week, model.weeksInYear),
                            style = bodyStyle(11, Brand.primary),
                        )
                        Spacer(GlanceModifier.defaultWeight())
                        Text(WidgetText.span(model.monday, model.days.last()), style = bodyStyle(11))
                    }
                    Spacer(GlanceModifier.height(6.dp))
                }
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    model.days.forEachIndexed { index, date ->
                        DayCell(
                            context = ctx,
                            label = initials[index],
                            day = date.dayOfMonth,
                            isToday = date == model.today,
                            isHoliday = model.isPublicHoliday(date),
                            hasFlagDay = model.observances(date).any { it.flag },
                            route = "/viikonpaiva?paiva=$date",
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
    day: Int,
    isToday: Boolean,
    isHoliday: Boolean,
    hasFlagDay: Boolean,
    route: String,
    modifier: GlanceModifier = GlanceModifier,
) {
    Column(
        modifier = modifier
            .padding(1.dp)
            .clickableRoute(context, route),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Text(label, style = bodyStyle(9, if (isHoliday) Brand.secondary else Brand.muted))
        Box(
            modifier = GlanceModifier
                .background(if (isToday) Brand.primary else Brand.surface)
                .cornerRadius(10.dp)
                .padding(horizontal = 6.dp, vertical = 2.dp),
            contentAlignment = Alignment.Center,
        ) {
            Text(
                "$day",
                style = bodyStyle(13, if (isToday) Brand.surface else Brand.onSurface)
                    .copy(textAlign = TextAlign.Center),
            )
        }
        if (isHoliday || hasFlagDay) {
            Box(
                modifier = GlanceModifier
                    .size(if (isHoliday) 4.dp else 3.dp)
                    .background(if (isHoliday) Brand.secondary else Brand.primary)
                    .cornerRadius(2.dp),
            ) {}
        }
    }
}
