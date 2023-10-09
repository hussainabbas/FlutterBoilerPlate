package ifisol.manawanui

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                if (call.method.equals("getIsAppetizeIntent")) {
                    val isAppetize = intent.getBooleanExtra("isAppetize", false)
                    result.success(isAppetize)
                } else {
                    result.success(false)
                }
            }
    }

    companion object {
        const val channel = "myappetizeintent"
    }
}
