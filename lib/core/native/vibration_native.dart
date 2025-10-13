import 'dart:io' show Platform;
import 'package:flutter/services.dart';

class VibrationNative {
  static const MethodChannel _channel = MethodChannel('native/vibration');

  static Future<void> vibrate() async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('vibrate');
      } on PlatformException catch (e) {
        print('Vibration error: ${e.message}');
      } catch (e) {
        print('Unknown vibration error: $e');
      }
    }
  }

  static Future<void> vibrateWithIntensity(int intensity) async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('vibrateWithIntensity', {
          'intensity': intensity,
        });
      } on PlatformException catch (e) {
        print('Vibration error: ${e.message}');
      } catch (e) {
        print('Unknown vibration error: $e');
      }
    }
  }

  static Future<void> impactFeedback(String style) async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('impactFeedback', {'style': style});
      } on PlatformException catch (e) {
        print('Vibration error: ${e.message}');
      } catch (e) {
        print('Unknown vibration error: $e');
      }
    }
  }

  static Future<void> selectionFeedback() async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('selectionFeedback');
      } on PlatformException catch (e) {
        print('Vibration error: ${e.message}');
      } catch (e) {
        print('Unknown vibration error: $e');
      }
    }
  }

  static Future<void> notificationFeedback(String type) async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('notificationFeedback', {'type': type});
      } on PlatformException catch (e) {
        print('Vibration error: ${e.message}');
      } catch (e) {
        print('Unknown vibration error: $e');
      }
    }
  }
}
