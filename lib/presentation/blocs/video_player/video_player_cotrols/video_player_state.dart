part of 'video_player_cubit.dart';

enum VideoPlayerStatus { initial, loading, ready, error }

class VideoPlayerState extends Equatable {
  const VideoPlayerState({
    this.status = VideoPlayerStatus.initial,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.isPlaying = false,
    this.showControls = true,
    this.isScrubbing = false,
    this.pendingSeekDuration = Duration.zero,
    this.errorMessage,
    this.controller,
  });

  final VideoPlayerStatus status;
  final Duration duration;
  final Duration position;
  final bool isPlaying;
  final bool showControls;
  final bool isScrubbing;
  final Duration pendingSeekDuration;
  final String? errorMessage;
  final VideoPlayerController? controller;

  @override
  List<Object?> get props => [
    status,
    duration,
    position,
    isPlaying,
    showControls,
    isScrubbing,
    pendingSeekDuration,
    errorMessage,
    controller,
  ];

  VideoPlayerState copyWith({
    VideoPlayerStatus? status,
    Duration? duration,
    Duration? position,
    bool? isPlaying,
    bool? showControls,
    bool? isScrubbing,
    Duration? pendingSeekDuration,
    String? errorMessage,
    VideoPlayerController? controller,
  }) {
    return VideoPlayerState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
      showControls: showControls ?? this.showControls,
      isScrubbing: isScrubbing ?? this.isScrubbing,
      pendingSeekDuration: pendingSeekDuration ?? this.pendingSeekDuration,
      errorMessage: errorMessage ?? this.errorMessage,
      controller: controller ?? this.controller,
    );
  }
}
