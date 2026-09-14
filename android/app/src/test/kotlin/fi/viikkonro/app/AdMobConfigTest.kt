package fi.viikkonro.app

import org.junit.Assert.assertEquals
import org.junit.Test

class AdMobConfigTest {
    @Test fun debugBuildAlwaysUsesGooglesTestBanner() {
        assertEquals(
            "ca-app-pub-3940256099942544/6300978111",
            BuildConfig.ADMOB_BANNER_AD_UNIT_ID,
        )
    }
}
