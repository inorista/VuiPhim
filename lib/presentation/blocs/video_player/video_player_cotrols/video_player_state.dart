import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

abstract class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object?> get props => [];
}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerReady extends VideoPlayerState {
  final VideoPlayerController controller;
  final bool showControls;
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  const VideoPlayerReady({
    required this.controller,
    required this.showControls,
    required this.isPlaying,
    required this.position,
    required this.duration,
  });

  @override
  List<Object?> get props => [
    controller,
    showControls,
    isPlaying,
    position,
    duration,
  ];

  VideoPlayerReady copyWith({
    VideoPlayerController? controller,
    bool? showControls,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
  }) {
    return VideoPlayerReady(
      controller: controller ?? this.controller,
      showControls: showControls ?? this.showControls,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }
}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
