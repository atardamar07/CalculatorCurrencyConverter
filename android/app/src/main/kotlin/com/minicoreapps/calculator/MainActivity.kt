package com.minicoreapps.calculator

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Currency
import java.util.Locale

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Currency names in any language from Android's own locale data, so the
        // app needs no translation of its own for them.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "currency_names")
            .setMethodCallHandler { call, result ->
                val locale = Locale.forLanguageTag(call.argument<String>("locale") ?: "en")
                result.success(
                    Currency.getAvailableCurrencies()
                        .associate { it.currencyCode to it.getDisplayName(locale) }
                )
            }
    }
}
