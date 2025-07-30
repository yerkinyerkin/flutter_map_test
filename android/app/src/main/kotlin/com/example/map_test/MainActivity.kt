package com.example.map_test

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity()  {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setLocale("ru_RU") 
    MapKitFactory.setApiKey("ecfa252d-8cfc-45ac-8d85-4ac2bdd1e427")
    super.configureFlutterEngine(flutterEngine)
  }
}
