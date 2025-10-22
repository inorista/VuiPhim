import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iffmpeg_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart';

class FFmpegService implements IFFmpegService {
  final _serverDataService = locator<IServerDataService>();
  @override
  Future<void> downloadM3U8Video(String videoId, String m3u8Url) async {
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

    await FFmpegKit.execute(command).then((session) async {
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
      }
    });
  }
}
