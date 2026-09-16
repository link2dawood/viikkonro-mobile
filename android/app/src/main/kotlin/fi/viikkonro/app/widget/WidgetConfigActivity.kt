package fi.viikkonro.app.widget

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.CheckBox
import android.widget.LinearLayout
import android.widget.RadioButton
import android.widget.RadioGroup
import android.widget.Spinner
import android.widget.TextView
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.glance.appwidget.AppWidgetId
import fi.viikkonro.app.R
import fi.viikkonro.app.widget.shared.WidgetModel
import fi.viikkonro.app.widget.shared.WidgetOptions
import fi.viikkonro.app.widget.shared.WidgetPrefs
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/** One optional, native configuration surface shared by all seven widgets. */
@Suppress("RestrictedApi")
class WidgetConfigActivity : Activity() {
    private var appWidgetId = AppWidgetManager.INVALID_APPWIDGET_ID

    override fun onCreate(savedInstanceState: Bundle?) {
        WindowCompat.setDecorFitsSystemWindows(window, false)
        super.onCreate(savedInstanceState)
        setResult(RESULT_CANCELED)
        appWidgetId = intent.getIntExtra(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID,
        )
        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            finish()
            return
        }

        val provider = AppWidgetManager.getInstance(this)
            .getAppWidgetInfo(appWidgetId)?.provider?.className.orEmpty()
        val current = WidgetPrefs.options(this, appWidgetId)
        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(dp(24), dp(24), dp(24), dp(24))
        }
        ViewCompat.setOnApplyWindowInsetsListener(root) { view, insets ->
            val bars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            view.setPadding(
                dp(24) + bars.left,
                dp(24) + bars.top,
                dp(24) + bars.right,
                dp(24) + bars.bottom,
            )
            insets
        }

        root.addView(TextView(this).apply {
            setText(R.string.widget_config_title)
            textSize = 24f
            setPadding(0, 0, 0, dp(16))
        })

        var citySpinner: Spinner? = null
        if (provider.endsWith("SchoolHolidayReceiver")) {
            root.addView(label(R.string.widget_config_city))
            val cities = listOf(getString(R.string.widget_config_automatic)) + WidgetModel(this).schoolCities()
            citySpinner = Spinner(this).apply {
                adapter = ArrayAdapter(
                    this@WidgetConfigActivity,
                    android.R.layout.simple_spinner_dropdown_item,
                    cities,
                )
                setSelection(cities.indexOf(current.city).takeIf { it >= 0 } ?: 0)
            }
            root.addView(citySpinner)
        }

        var targetGroup: RadioGroup? = null
        if (provider.endsWith("CountdownReceiver")) {
            root.addView(label(R.string.widget_config_countdown_target))
            targetGroup = RadioGroup(this).apply {
                orientation = RadioGroup.VERTICAL
                addView(radio(R.string.widget_next_holiday, WidgetOptions.TARGET_HOLIDAY, current.countdownTarget))
                addView(radio(R.string.widget_next_flag_day, WidgetOptions.TARGET_FLAG_DAY, current.countdownTarget))
            }
            root.addView(targetGroup)
        }

        val supportsEventToggle = provider.endsWith("WeekCardReceiver") ||
            provider.endsWith("WeekStripReceiver") || provider.endsWith("MonthReceiver")
        val events = CheckBox(this).apply {
            setText(R.string.widget_config_show_events)
            isChecked = current.showEvents
            visibility = if (supportsEventToggle) View.VISIBLE else View.GONE
        }
        root.addView(events)

        val dynamicColors = CheckBox(this).apply {
            setText(R.string.widget_config_dynamic_colors)
            isChecked = current.dynamicColors
        }
        root.addView(dynamicColors)

        root.addView(Button(this).apply {
            setText(R.string.widget_config_save)
            setOnClickListener {
                val selectedCity = citySpinner?.selectedItemPosition?.takeIf { it > 0 }
                    ?.let { citySpinner?.selectedItem as? String }
                val selectedTarget = targetGroup?.let { group ->
                    group.findViewById<RadioButton>(group.checkedRadioButtonId)?.tag as? String
                } ?: current.countdownTarget
                save(
                    current.copy(
                        city = selectedCity ?: current.city.takeIf { citySpinner == null },
                        countdownTarget = selectedTarget,
                        showEvents = if (supportsEventToggle) events.isChecked else current.showEvents,
                        dynamicColors = dynamicColors.isChecked,
                    ),
                    provider,
                )
            }
        })
        setContentView(root)
    }

    private fun label(resource: Int) = TextView(this).apply {
        setText(resource)
        textSize = 14f
        setPadding(0, dp(16), 0, dp(4))
    }

    private fun radio(label: Int, value: String, selected: String) = RadioButton(this).apply {
        id = View.generateViewId()
        setText(label)
        tag = value
        isChecked = value == selected
    }

    private fun save(options: WidgetOptions, provider: String) {
        WidgetPrefs.save(this, appWidgetId, options)
        val widget = when {
            provider.endsWith("WeekMiniReceiver") -> WeekMiniWidget()
            provider.endsWith("WeekCardReceiver") -> WeekCardWidget()
            provider.endsWith("WeekStripReceiver") -> WeekStripWidget()
            provider.endsWith("MonthReceiver") -> MonthWidget()
            provider.endsWith("CountdownReceiver") -> CountdownWidget()
            provider.endsWith("HolidaysReceiver") -> HolidaysWidget()
            provider.endsWith("SchoolHolidayReceiver") -> SchoolHolidayWidget()
            else -> null
        }
        CoroutineScope(Dispatchers.Main).launch {
            withContext(Dispatchers.Default) {
                runCatching {
                    widget?.update(this@WidgetConfigActivity, AppWidgetId(appWidgetId))
                }
            }
            setResult(
                RESULT_OK,
                Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId),
            )
            finish()
        }
    }

    private fun dp(value: Int): Int = (value * resources.displayMetrics.density).toInt()
}
