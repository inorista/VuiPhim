import 'package:equatable/equatable.dart';

enum DownloadStatus { idle, downloading, success, failure }

class DownloadItemState extends Equatable {
  final DownloadStatus status;
  final double progress;

  const DownloadItemState({
    this.status = DownloadStatus.idle,
    this.progress = 0.0,
  });

  DownloadItemState copyWith({DownloadStatus? status, double? progress}) {
    return DownloadItemState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [status, progress];
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
