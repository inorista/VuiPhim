import 'dart:async';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerController? controller;
  Timer? _autoSaveTimer;

  VideoPlayerCubit() : super(const VideoPlayerState());

  Future<void> initializePlayer(String videoUrl) async {
    try {
      emit(state.copyWith(status: VideoPlayerStatus.loading));

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await controller!.initialize();

      controller!.addListener(_onControllerUpdate);

      emit(
        state.copyWith(
          status: VideoPlayerStatus.ready,
          duration: controller!.value.duration,
          controller: controller,
        ),
      );

      play();
      _startAutoSavePosition();
    } catch (e) {
      emit(
        state.copyWith(
          status: VideoPlayerStatus.error,
          errorMessage: 'Failed to initialize video: $e',
        ),
      );
    }
  }

  void _onControllerUpdate() {
    if (controller == null || !controller!.value.isInitialized) return;

    final value = controller!.value;
    emit(state.copyWith(position: value.position, isPlaying: value.isPlaying));
  }

  void _startAutoSavePosition() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (state.status == VideoPlayerStatus.ready) {
        final currentPosition = state.position;
      }
    });
  }

  void play() => controller?.play();
  void pause() => controller?.pause();
  void seekTo(Duration position) => controller?.seekTo(position);

  void togglePlayPause() {
    if (state.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  void toggleControls() {
    emit(state.copyWith(showControls: !state.showControls));
  }

  void onSliderChangeStart() {
    if (state.isPlaying) {
      pause();
    }
    emit(state.copyWith(isScrubbing: true));
  }

  void onSliderChangeEnd(Duration newPosition) {
    seekTo(newPosition);
    if (!state.isPlaying) {
      play();
    }
    emit(state.copyWith(isScrubbing: false));
  }

  @override
  Future<void> close() async {
    _autoSaveTimer?.cancel();
    controller?.removeListener(_onControllerUpdate);
    await controller?.dispose();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return super.close();
  }
}
