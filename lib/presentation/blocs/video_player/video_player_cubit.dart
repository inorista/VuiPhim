import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerController? _controller;
  Timer? _positionTimer;

  VideoPlayerCubit() : super(VideoPlayerInitial());

  Future<void> initializeVideo(String videoUrl) async {
    try {
      emit(VideoPlayerLoading());

      // Set system UI mode for fullscreen
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _controller!.initialize();

      emit(
        VideoPlayerReady(
          controller: _controller!,
          showControls: false,
          isPlaying: false,
          position: Duration.zero,
          duration: _controller!.value.duration,
        ),
      );

      // Start position tracking
      _startPositionTracking();

      // Auto play
      play();
    } catch (e) {
      emit(VideoPlayerError('Failed to initialize video: $e'));
    }
  }

  void _startPositionTracking() {
    _positionTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_controller != null && _controller!.value.isInitialized) {
        final currentState = state;
        if (currentState is VideoPlayerReady) {
          emit(
            currentState.copyWith(
              position: _controller!.value.position,
              isPlaying: _controller!.value.isPlaying,
            ),
          );
        }
      }
    });
  }

  void toggleControls() {
    final currentState = state;
    if (currentState is VideoPlayerReady) {
      emit(currentState.copyWith(showControls: !currentState.showControls));
    }
  }

  void play() {
    _controller?.play();
    final currentState = state;
    if (currentState is VideoPlayerReady) {
      emit(currentState.copyWith(isPlaying: true));
    }
  }

  void pause() {
    _controller?.pause();
    final currentState = state;
    if (currentState is VideoPlayerReady) {
      emit(currentState.copyWith(isPlaying: false));
    }
  }

  void togglePlayPause() {
    final currentState = state;
    if (currentState is VideoPlayerReady) {
      if (currentState.isPlaying) {
        pause();
      } else {
        play();
      }
    }
  }

  void seekTo(Duration position) {
    _controller?.seekTo(position);
  }

  void onSliderChangeStart() {
    final currentState = state;
    if (currentState is VideoPlayerReady && currentState.isPlaying) {
      pause();
    }
  }

  void onSliderChangeEnd() {
    final currentState = state;
    if (currentState is VideoPlayerReady && !currentState.isPlaying) {
      play();
    }
  }

  Future<void> dispose() async {
    _positionTimer?.cancel();
    _controller?.dispose();

    // Restore system UI mode
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Future<void> close() {
    dispose();
    return super.close();
  }
}
