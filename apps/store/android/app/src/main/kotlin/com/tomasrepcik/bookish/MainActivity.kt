package com.tomasrepcik.bookish

import android.content.Intent
import android.provider.Settings
import androidx.mediarouter.app.SystemOutputSwitcherDialogController
import androidx.mediarouter.media.MediaRouter
import androidx.mediarouter.media.MediaRouterParams
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : AudioServiceActivity(), AudioOutputHostApi {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        AudioOutputHostApi.setUp(flutterEngine.dartExecutor.binaryMessenger, this)
    }

    override fun showPicker() {
        val router = MediaRouter.getInstance(this)
        router.routerParams = MediaRouterParams.Builder()
            .setOutputSwitcherEnabled(true)
            .build()
        if (!SystemOutputSwitcherDialogController.showDialog(this)) {
            startActivity(Intent(Settings.ACTION_BLUETOOTH_SETTINGS))
        }
    }
}
