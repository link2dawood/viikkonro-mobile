package fi.viikkonro.app

import java.awt.image.BufferedImage
import javax.imageio.ImageIO
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Test

/** Guards the Android 7–11 picker fallbacks against icon or blank regressions. */
class WidgetPreviewAssetTest {
    private val expected = mapOf(
        "widget_preview_week_mini.png" to (120 to 120),
        "widget_preview_week_card.png" to (260 to 260),
        "widget_preview_week_strip.png" to (500 to 140),
        "widget_preview_month.png" to (500 to 500),
        "widget_preview_countdown.png" to (260 to 140),
        "widget_preview_holidays.png" to (500 to 220),
        "widget_preview_school.png" to (500 to 220),
    )

    @Test fun everyWidgetHasANonBlankPreviewAtItsDesignedAspectRatio() {
        expected.forEach { (name, dimensions) ->
            val image = ImageIO.read(checkNotNull(javaClass.classLoader?.getResourceAsStream(name)))
            assertNotNull(name, image)
            assertEquals(name, dimensions.first, image.width)
            assertEquals(name, dimensions.second, image.height)
            assertTrue(name, image.hasVisibleVariation())
        }
    }

    private fun BufferedImage.hasVisibleVariation(): Boolean {
        val samples = mutableSetOf<Int>()
        val stepX = (width / 20).coerceAtLeast(1)
        val stepY = (height / 20).coerceAtLeast(1)
        for (x in 0 until width step stepX) {
            for (y in 0 until height step stepY) samples += getRGB(x, y)
        }
        return samples.size >= 3
    }
}
