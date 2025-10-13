import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_cotrols/video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerController? _controller;
  Timer? _positionTimer;
  Timer? _autoSaveTimer;
  bool _isDisposed = false;

  VideoPlayerCubit() : super(VideoPlayerInitial());

  void autoSavePosition() async {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }

      final currentState = state;
      if (currentState is VideoPlayerReady) {
        final currentPosition = _controller!.value.position;
      }
    });
  }

  Future<void> initializeVideo(String videoUrl) async {
    if (_isDisposed) return;

    try {
      emit(VideoPlayerLoading());

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _controller!.initialize();

      if (_isDisposed) {
        _controller?.dispose();
        return;
      }

      emit(
        VideoPlayerReady(
          controller: _controller!,
          showControls: false,
          isPlaying: false,
          position: Duration.zero,
          duration: _controller!.value.duration,
        ),
      );

      _startPositionTracking();

      // Auto play
      play();
    } catch (e) {
      if (_isDisposed) return;

      emit(VideoPlayerError('Failed to initialize video: $e'));
    }
  }

  void _startPositionTracking() {
    _positionTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }

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
    if (_isDisposed) return;

    final currentState = state;
    if (currentState is VideoPlayerReady) {
      emit(currentState.copyWith(showControls: !currentState.showControls));
    }
  }

  void play() {
    if (_isDisposed || _controller == null) return;

    _controller?.play();
    final currentState = state;
    if (currentState is VideoPlayerReady) {
      emit(currentState.copyWith(isPlaying: true));
    }
  }

  void pause() {
    if (_isDisposed || _controller == null) return;

    _controller?.pause();
    final currentState = state;
    if (currentState is VideoPlayerReady) {
      emit(currentState.copyWith(isPlaying: false));
    }
  }

  void togglePlayPause() {
    if (_isDisposed) return;

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
    if (_isDisposed || _controller == null) return;

    _controller?.seekTo(position);
  }

  void onSliderChangeStart() {
    if (_isDisposed) return;

    final currentState = state;
    if (currentState is VideoPlayerReady && currentState.isPlaying) {
      pause();
    }
  }

  void onSliderChangeEnd() {
    if (_isDisposed) return;

    final currentState = state;
    if (currentState is VideoPlayerReady && !currentState.isPlaying) {
      play();
    }
  }

  Future<void> disposeVideo() async {
    _isDisposed = true;
    _positionTimer?.cancel();
    await _controller?.dispose();
    _controller = null;
    emit(VideoPlayerInitial());
    // Restore system UI mode
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}
