import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iwatching_movie_service.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/watching_movie_entity/watching_movie_entity.dart';
part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final _watchingMovieService = locator<IWatchingMovieService>();
  VideoPlayerController? _controller;
  Timer? _seekDebounceTimer;
  Duration _pendingSeekAmount = Duration.zero;
  VideoPlayerController? get controller => _controller;
  MovieDetailEntity? _movieDetailEntity;
  ServerDataEntity? _serverDataEntity;

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

  Future<void> initializePlayer({
    required MovieDetailEntity movieDetailEntity,
    required ServerDataEntity serverDataEntity,
  }) async {
    try {
      emit(state.copyWith(status: VideoPlayerStatus.loading));
      final watchingMovie = await _watchingMovieService.getWatchingMovie(
        movieDetailEntity.id,
      );

      _movieDetailEntity = movieDetailEntity;
      _serverDataEntity = serverDataEntity;
      if (watchingMovie != null) {
        final serverData = watchingMovie.serverDataList.firstOrDefault(
          (item) => item == _serverDataEntity,
        );
      }
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(serverDataEntity.linkM3U8 ?? ''),
      );

      await _controller!.initialize();

      _controller!.addListener(_onControllerUpdate);

      emit(
        state.copyWith(
          status: VideoPlayerStatus.ready,
          duration: _controller!.value.duration,
          controller: _controller,
        ),
      );

      play();
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

  Future<void> _startAutoSavePosition() async {
    if (_movieDetailEntity != null && _serverDataEntity != null) {
      final watchingMovie = await _watchingMovieService.getWatchingMovie(
        _movieDetailEntity!.id,
      );
      if (watchingMovie == null) {
        _serverDataEntity!.playingDuration = state.position.inMilliseconds;
        final newWatchingMovie = WatchingMovieEntity(
          serverDataList: [_serverDataEntity!],
          movieDetail: _movieDetailEntity!,
        );
        await _watchingMovieService.saveWatchingMovie(newWatchingMovie);
        return;
      } else {
        watchingMovie.serverDataList
                .firstOrDefault((serverData) => serverData == _serverDataEntity)
                ?.playingDuration =
            state.position.inMilliseconds;
        await _watchingMovieService.saveWatchingMovie(watchingMovie);
      }
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
    // await _startAutoSavePosition();
    _seekDebounceTimer?.cancel();
    _pendingSeekAmount = Duration.zero;
    _controller?.removeListener(_onControllerUpdate);
    _startAutoSavePosition();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await _controller?.dispose();

    return super.close();
  }
}
