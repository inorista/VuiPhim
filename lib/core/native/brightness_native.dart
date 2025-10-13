import 'dart:developer';

import 'package:flutter/services.dart';

class BrightnessNative {
  static const MethodChannel _channel = MethodChannel('native/brightness');

  static Future<void> setBrightness(double brightness) async {
    try {
      await _channel.invokeMethod('setBrightness', {'brightness': brightness});
    } on PlatformException catch (e) {
      log('PlatformException when setting brightness: $e');
    } on MissingPluginException catch (e) {
      log('MissingPluginException when setting brightness: $e');
    } catch (e) {
      log('Unknown error when setting brightness: $e');
    }
  }

  static Future<double> getBrightness() async {
    try {
      final currentBrightness = await _channel.invokeMethod('getBrightness');
      return currentBrightness as double;
    } on PlatformException catch (e) {
      log('PlatformException when getting brightness: $e');
    } on MissingPluginException catch (e) {
      log('MissingPluginException when getting brightness: $e');
    } catch (e) {
      log('Unknown error when getting brightness: $e');
    }
    return 1.0;
  }

  static Future<void> resetBrightness() async {
    try {
      await _channel.invokeMethod('resetBrightness');
    } on PlatformException catch (e) {
      log('PlatformException when resetting brightness: $e');
    } on MissingPluginException catch (e) {
      log('MissingPluginException when resetting brightness: $e');
    } catch (e) {
      log('Unknown error when resetting brightness: $e');
    }
  }
}
