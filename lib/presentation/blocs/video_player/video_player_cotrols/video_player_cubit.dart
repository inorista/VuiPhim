import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerController? _controller;
  Timer? _seekDebounceTimer;
  Duration _pendingSeekAmount = Duration.zero;
  VideoPlayerController? get controller => _controller;

  VideoPlayerCubit() : super(const VideoPlayerState());

  void forward10s() {
    _debounceSeek(const Duration(seconds: 10));
  }

  void rewind10s() {
    _debounceSeek(const Duration(seconds: -10));
  }

  void _debounceSeek(Duration seekAmount) {
    _seekDebounceTimer?.cancel();
    _pendingSeekAmount += seekAmount;
    emit(state.copyWith(pendingSeekDuration: _pendingSeekAmount));

    _seekDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      final currentPosition = _controller?.value.position ?? Duration.zero;
      final totalDuration = state.duration;
      final totalMilliseconds =
          (currentPosition + _pendingSeekAmount).inMilliseconds;
      final durationMilliseconds = totalDuration.inMilliseconds;

      final clampedMilliseconds = totalMilliseconds.clamp(
        0,
        durationMilliseconds,
      );
      final newPosition = Duration(milliseconds: clampedMilliseconds);
      seekTo(newPosition);

      _pendingSeekAmount = Duration.zero;
      emit(state.copyWith(pendingSeekDuration: _pendingSeekAmount));
    });
  }

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

      _controller!.addListener(_onControllerUpdate);

      emit(
        state.copyWith(
          status: VideoPlayerStatus.ready,
          duration: _controller!.value.duration,
          controller: _controller,
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
    if (_controller == null || !_controller!.value.isInitialized) return;

    final value = _controller!.value;
    emit(state.copyWith(position: value.position, isPlaying: value.isPlaying));
  }

  void _startAutoSavePosition() {
    if (state.status == VideoPlayerStatus.ready) {
      final currentPosition = state.position;
    }
  }

  void play() => _controller?.play();
  void pause() => _controller?.pause();
  void seekTo(Duration position) => _controller?.seekTo(position);

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
    emit(state.copyWith(status: VideoPlayerStatus.initial));
    _seekDebounceTimer?.cancel();
    _pendingSeekAmount = Duration.zero;
    _controller?.removeListener(_onControllerUpdate);
    await _controller?.dispose();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return super.close();
  }
}
