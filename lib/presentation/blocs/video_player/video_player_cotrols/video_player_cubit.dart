import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/ipath_provider_service.dart';
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerController? _controller;
  Timer? _seekDebounceTimer;
  Duration _pendingSeekAmount = Duration.zero;
  VideoPlayerController? get controller => _controller;
  MovieDetailEntity? _movieDetailEntity;
  ServerDataEntity? _serverDataEntity;
  VideoPlayerCubit() : super(const VideoPlayerState());
  final IServerDataService _serverDataService = locator<IServerDataService>();
  final IPathProviderService _pathProviderService =
      locator<IPathProviderService>();

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
      bool canLoadFromFile = false;
      emit(state.copyWith(status: VideoPlayerStatus.loading));
      _movieDetailEntity = movieDetailEntity;
      _serverDataEntity = serverDataEntity;
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      if (isClosed) return;
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      if (isClosed) return;
      if (serverDataEntity.downloadPath != null) {
        try {
          // IF DOWNLOAD PATH IS NOT NULL, PLAY FROM FILE
          final String fileName = serverDataEntity.downloadPath!
              .split('/')
              .last;
          final String currentPath = await _pathProviderService
              .getDownloadedEpisodePath(fileName);

          final file = File(currentPath);
          final isFileExists = await file.exists();

          if (isFileExists) {
            _controller = VideoPlayerController.file(File(currentPath));
            canLoadFromFile = true;
          }
        } catch (e) {
          // IF FAILED TO LOAD FROM FILE, FALLBACK TO NETWORK
          canLoadFromFile = false;
        }
      }
      if (!canLoadFromFile) {
        // IF DOWNLOAD PATH IS NULL, PLAY FROM NETWORK
        _controller = VideoPlayerController.networkUrl(
          Uri.parse(serverDataEntity.linkM3U8 ?? ''),
        );
      }
      if (_controller != null) {
        await _controller!.initialize();
        if (isClosed) return;
        _controller!.addListener(_onControllerUpdate);

        emit(
          state.copyWith(
            status: VideoPlayerStatus.ready,
            duration: _controller!.value.duration,
            controller: _controller,
          ),
        );
        play();
      } else {
        if (isClosed) return;
        emit(
          state.copyWith(
            status: VideoPlayerStatus.error,
            errorMessage: 'Failed to create video controller.',
          ),
        );
        return;
      }
    } catch (e) {
      if (isClosed) return;
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
      final runtime = _controller?.value.duration.inMilliseconds;
      final currentPosition = _controller?.value.position ?? Duration.zero;
      final existedServerData = await _serverDataService.getServerDataById(
        _serverDataEntity?.id ?? '',
      );
      if (existedServerData != null) {
        final updatedServerData = existedServerData.copyWith(
          runtime: runtime,
          playingDuration: currentPosition.inMilliseconds,
        );
        await _serverDataService.updateServerData(
          _serverDataEntity!.id,
          updatedServerData,
        );
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
    if (!isClosed) {
      emit(state.copyWith(status: VideoPlayerStatus.initial));
    }

    _seekDebounceTimer?.cancel();
    _pendingSeekAmount = Duration.zero;
    _controller?.removeListener(_onControllerUpdate);
    await _startAutoSavePosition();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await _controller?.dispose();

    return super.close();
  }
}
