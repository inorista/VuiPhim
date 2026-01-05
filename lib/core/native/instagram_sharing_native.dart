import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart'
    show MethodChannel, Uint8List, PlatformException, MissingPluginException;
import 'package:flutter/widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vuiphim/core/utils/wrapper.dart';
import 'package:vuiphim/presentation/utils/loading_dialog_utils.dart';

Uint8List _processImageIsolate(Uint8List imageBytes) {
  final end = DateTime.now().add(const Duration(milliseconds: 200));
  while (DateTime.now().isBefore(end)) {}
  return imageBytes;
}

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
      await LoadingDialogUtils.showLoading();

      if (context.mounted) {
        final Uint8List stickerBytes = await screenshotController
            .captureFromWidget(wrapWidget(sticker, context));
        final Uint8List backgroundBytes = await screenshotController
            .captureFromWidget(wrapWidget(background, context));

        final results = await Future.wait([
          compute(_processImageIsolate, stickerBytes),
          compute(_processImageIsolate, backgroundBytes),
        ]);

        final processedStickerBytes = results[0];
        final processedBackgroundBytes = results[1];

        await _channel.invokeMethod('instagramShareSticker', {
          'stickerImage': processedStickerBytes,
          'backgroundImage': processedBackgroundBytes,
        });
      }
      await LoadingDialogUtils.hideLoading();
    } on PlatformException catch (e) {
      debugPrint('PlatformException when sharing to Instagram: $e');
    } on MissingPluginException catch (e) {
      debugPrint('MissingPluginException when sharing to Instagram: $e');
    } catch (e) {
      debugPrint('Unknown error when sharing to Instagram: $e');
    } finally {
      await LoadingDialogUtils.hideLoading();
    }
  }
}
