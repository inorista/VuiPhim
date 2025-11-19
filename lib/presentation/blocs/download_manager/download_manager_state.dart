import 'package:equatable/equatable.dart';

enum DownloadStatus { idle, downloading, success, failure }

class DownloadItemState extends Equatable {
  final DownloadStatus status;
  final double progress;
  final int movieId;
  final String videoId;

  const DownloadItemState({
    this.status = DownloadStatus.idle,
    this.progress = 0.0,
    required this.movieId,
    required this.videoId,
  });

  DownloadItemState copyWith({
    DownloadStatus? status,
    double? progress,
    int? movieId,
    String? videoId,
  }) {
    return DownloadItemState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      movieId: movieId ?? this.movieId,
      videoId: videoId ?? this.videoId,
    );
  }

  @override
  List<Object?> get props => [status, progress, movieId, videoId];
}

class DownloadManagerState extends Equatable {
  final Map<String, DownloadItemState> downloads;

  const DownloadManagerState({this.downloads = const {}});

  DownloadManagerState copyWith({Map<String, DownloadItemState>? downloads}) {
    return DownloadManagerState(downloads: downloads ?? this.downloads);
  }

  @override
  List<Object?> get props => [downloads];
}
