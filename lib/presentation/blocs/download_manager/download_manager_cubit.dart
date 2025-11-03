import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iffmpeg_service.dart';
import 'download_manager_state.dart';

class DownloadManagerCubit extends Cubit<DownloadManagerState> {
  final Map<String, StreamSubscription> _subscriptions = {};
  final _ffmpegService = locator<IFFmpegService>();

  DownloadManagerCubit() : super(const DownloadManagerState());

  DownloadItemState getDownloadState(String videoId) {
    return state.downloads[videoId] ?? const DownloadItemState();
  }

  void startDownload(String videoId, String m3u8Url) async {
    if (state.downloads[videoId]?.status == DownloadStatus.downloading) {
      return;
    }

    _subscriptions[videoId]?.cancel();

    final progressController = StreamController<double>();
    _updateDownloadState(
      videoId,
      const DownloadItemState(
        status: DownloadStatus.downloading,
        progress: 0.0,
      ),
    );

    _subscriptions[videoId] = progressController.stream.listen(
      (progress) {
        _updateDownloadState(
          videoId,
          DownloadItemState(
            status: DownloadStatus.downloading,
            progress: progress,
          ),
        );
      },
      onError: (error) {
        print("Download error for $videoId: $error");
        _updateDownloadState(
          videoId,
          DownloadItemState(
            status: DownloadStatus.failure,
            progress: state.downloads[videoId]?.progress ?? 0.0,
          ),
        );
        progressController.close();
        _subscriptions.remove(videoId);
      },
      onDone: () {
        progressController.close();
        _subscriptions.remove(videoId);
      },
    );

    try {
      await _ffmpegService.downloadM3U8Video(
        videoId,
        m3u8Url,
        progressController,
      );

      _updateDownloadState(
        videoId,
        const DownloadItemState(status: DownloadStatus.success, progress: 1.0),
      );
    } catch (e) {
      print("FFmpeg service failed for $videoId: $e");
    } finally {
      if (!progressController.isClosed) {
        progressController.close();
      }
      _subscriptions.remove(videoId);
    }
  }

  void _updateDownloadState(String videoId, DownloadItemState itemState) {
    final newDownloads = Map<String, DownloadItemState>.from(state.downloads);
    newDownloads[videoId] = itemState;
    emit(state.copyWith(downloads: newDownloads));
  }

  @override
  Future<void> close() {
    for (var sub in _subscriptions.values) {
      sub.cancel();
    }
    _subscriptions.clear();
    return super.close();
  }
}
