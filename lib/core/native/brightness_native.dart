import 'dart:developer';

import 'package:flutter/services.dart';

class BrightnessNative {
  static const MethodChannel _channel = MethodChannel('native/brightness');

  static Future<void> setBrightness(double brightness) async {
    try {
      await _channel.invokeMethod('setBrightness', {'brightness': brightness});
    } on PlatformException catch (e) {}
  }

  static Future<double> getBrightness() async {
    try {
      final currentBrightness = await _channel.invokeMethod('getBrightness');
      return currentBrightness;
    } catch (e) {
      return 1.0;
    }
  }

  static Future<void> resetBrightness() async {
    try {
      await const MethodChannel(
        'native/brightness',
      ).invokeMethod('resetBrightness');
    } catch (e) {
      log(e.toString());
    }
  }
}
