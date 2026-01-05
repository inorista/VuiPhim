import 'dart:async';

abstract class IFFmpegService {
  Future<void> downloadM3U8Video(
    String videoId,
    String m3u8Url,
    StreamController<double> progressController,
  );
}
