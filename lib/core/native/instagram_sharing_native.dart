import 'package:flutter/services.dart'
    show MethodChannel, Uint8List, PlatformException, MissingPluginException;
import 'package:flutter/widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vuiphim/core/utils/wrapper.dart';

class InstagramSharingNative {
  static const MethodChannel _channel = MethodChannel(
    'native/instagramSharing',
  );

  Future<void> captureAndShareWidget(
    BuildContext context,
    Widget background,
    Widget sticker,
  ) async {
    final screenshotController = ScreenshotController();
    try {
      final Uint8List stickerBytes = await screenshotController
          .captureFromWidget(wrapWidget(sticker, context));
      final Uint8List backgroundBytes = await screenshotController
          .captureFromWidget(wrapWidget(background, context));

      await _channel.invokeMethod('instagramShareSticker', {
        'stickerImage': stickerBytes,
        'backgroundImage': backgroundBytes,
      });
    } on PlatformException catch (e) {
      debugPrint('PlatformException when sharing to Instagram: $e');
    } on MissingPluginException catch (e) {
      debugPrint('MissingPluginException when sharing to Instagram: $e');
    } catch (e) {
      debugPrint('Unknown error when sharing to Instagram: $e');
    }
  }
}
