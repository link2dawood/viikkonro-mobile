package fi.viikkonro.app

import java.io.ByteArrayOutputStream
import java.io.DataInputStream
import java.util.zip.Inflater
import org.junit.Assert.assertEquals
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
            val image = checkNotNull(javaClass.classLoader?.getResourceAsStream(name)) { name }
                .use { Png.decode(DataInputStream(it)) }
            assertEquals(name, dimensions.first, image.width)
            assertEquals(name, dimensions.second, image.height)
            assertTrue(name, image.hasVisibleVariation())
        }
    }

    private fun Png.hasVisibleVariation(): Boolean {
        val samples = mutableSetOf<Int>()
        val stepX = (width / 20).coerceAtLeast(1)
        val stepY = (height / 20).coerceAtLeast(1)
        for (x in 0 until width step stepX) {
            for (y in 0 until height step stepY) samples += pixel(x, y)
        }
        return samples.size >= 3
    }

    /**
     * Minimal 8-bit, non-interlaced RGB/RGBA PNG decoder. Local unit tests
     * compile against android.jar, which provides neither java.awt nor
     * javax.imageio, so the previews are decoded here with java.util.zip.
     */
    private class Png(val width: Int, val height: Int, private val channels: Int, private val data: ByteArray) {
        fun pixel(x: Int, y: Int): Int {
            val offset = (y * width + x) * channels
            var argb = if (channels == 4) data[offset + 3].toInt() and 0xFF else 0xFF
            for (c in 0 until 3) argb = (argb shl 8) or (data[offset + c].toInt() and 0xFF)
            return argb
        }

        companion object {
            private val signature = byteArrayOf(-119, 80, 78, 71, 13, 10, 26, 10)

            fun decode(input: DataInputStream): Png {
                val header = ByteArray(8).also { input.readFully(it) }
                check(header.contentEquals(signature)) { "Not a PNG" }
                var width = 0
                var height = 0
                var channels = 0
                val compressed = ByteArrayOutputStream()
                while (true) {
                    val length = input.readInt()
                    val type = ByteArray(4).also { input.readFully(it) }.toString(Charsets.US_ASCII)
                    val chunk = ByteArray(length).also { input.readFully(it) }
                    input.readInt() // CRC
                    when (type) {
                        "IHDR" -> {
                            val ihdr = DataInputStream(chunk.inputStream())
                            width = ihdr.readInt()
                            height = ihdr.readInt()
                            val bitDepth = ihdr.readUnsignedByte()
                            val colorType = ihdr.readUnsignedByte()
                            ihdr.readUnsignedByte() // compression
                            ihdr.readUnsignedByte() // filter method
                            val interlace = ihdr.readUnsignedByte()
                            check(bitDepth == 8 && interlace == 0) { "Unsupported PNG layout" }
                            channels = when (colorType) {
                                2 -> 3
                                6 -> 4
                                else -> error("Unsupported PNG color type $colorType")
                            }
                        }
                        "IDAT" -> compressed.write(chunk)
                        "IEND" -> break
                    }
                }
                return Png(width, height, channels, unfilter(inflate(compressed.toByteArray()), width, height, channels))
            }

            private fun inflate(bytes: ByteArray): ByteArray {
                val inflater = Inflater().apply { setInput(bytes) }
                val out = ByteArrayOutputStream()
                val buffer = ByteArray(64 * 1024)
                while (!inflater.finished()) {
                    val count = inflater.inflate(buffer)
                    check(count > 0 || !inflater.needsInput()) { "Truncated PNG data" }
                    out.write(buffer, 0, count)
                }
                inflater.end()
                return out.toByteArray()
            }

            private fun unfilter(raw: ByteArray, width: Int, height: Int, bpp: Int): ByteArray {
                val stride = width * bpp
                val out = ByteArray(stride * height)
                for (y in 0 until height) {
                    val filter = raw[y * (stride + 1)].toInt()
                    val src = y * (stride + 1) + 1
                    val dst = y * stride
                    for (i in 0 until stride) {
                        val a = if (i >= bpp) out[dst + i - bpp].toInt() and 0xFF else 0
                        val b = if (y > 0) out[dst - stride + i].toInt() and 0xFF else 0
                        val c = if (i >= bpp && y > 0) out[dst - stride + i - bpp].toInt() and 0xFF else 0
                        val predictor = when (filter) {
                            0 -> 0
                            1 -> a
                            2 -> b
                            3 -> (a + b) / 2
                            4 -> paeth(a, b, c)
                            else -> error("Unknown PNG filter $filter")
                        }
                        out[dst + i] = (raw[src + i] + predictor).toByte()
                    }
                }
                return out
            }

            private fun paeth(a: Int, b: Int, c: Int): Int {
                val p = a + b - c
                val pa = Math.abs(p - a)
                val pb = Math.abs(p - b)
                val pc = Math.abs(p - c)
                return if (pa <= pb && pa <= pc) a else if (pb <= pc) b else c
            }
        }
    }
}
