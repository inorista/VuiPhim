import 'dart:async';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:ffmpeg_kit_flutter_new/ffprobe_kit.dart';
import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iffmpeg_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart';

@LazySingleton(as: IFFmpegService)
class FFmpegService implements IFFmpegService {
  final _serverDataService = locator<IServerDataService>();

  Future<double> _getMediaDuration(String m3u8Url) async {
    try {
      final session = await FFprobeKit.getMediaInformation(m3u8Url);
      final info = session.getMediaInformation();
      if (info != null) {
        final durationString = info.getDuration();
        if (durationString != null) {
          final durationInSeconds = double.tryParse(durationString) ?? 0.0;
          return durationInSeconds * 1000.0;
        }
      }
      return 0.0;
    } catch (e) {
      print("Error getting media duration: $e");
      return 0.0;
    }
  }

  @override
  Future<void> downloadM3U8Video(
    String videoId,
    String m3u8Url,
    StreamController<double> progressController,
  ) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String outputPath = '${appDir.path}/$videoId.mp4';
    final outputFile = File(outputPath);
    if (await outputFile.exists()) {
      await outputFile.delete();
    }

    //
    final String command =
        "-protocol_whitelist file,http,https,tcp,tls,crypto "
        "-i \"$m3u8Url\" "
        "-c copy "
        "-bsf:a aac_adtstoasc "
        "\"$outputPath\"";

    final completer = Completer<void>();

    final totalDurationMs = await _getMediaDuration(m3u8Url);
    if (totalDurationMs <= 0) {
      final error = Exception(
        "Không thể lấy tổng thời lượng video. "
        "Không thể báo cáo tiến độ.",
      );
      progressController.addError(error);
      completer.completeError(error);
      return completer.future;
    }

    print("Tổng thời lượng: $totalDurationMs ms");

    await FFmpegKit.executeAsync(
      command,
      (FFmpegSession session) async {
        final returnCode = await session.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          final existedServerData = await _serverDataService.getServerDataById(
            videoId,
          );
          if (existedServerData != null) {
            final needToUpdate = existedServerData.copyWith(
              downloadPath: outputPath,
            );
            await _serverDataService.updateServerData(videoId, needToUpdate);
          }
          progressController.add(1.0);
          completer.complete();
        } else {
          final error = Exception("FFmpeg failed with code: $returnCode");
          progressController.addError(error);
          completer.completeError(error);
        }
      },
      (log) {
        //
      },
      (statistics) {
        final currentTimeMs = statistics.getTime();
        if (currentTimeMs > 0) {
          double progress = (currentTimeMs / totalDurationMs).clamp(0.0, 1.0);
          progressController.add(progress);
        }
      },
    );
    return completer.future;
  }
}
