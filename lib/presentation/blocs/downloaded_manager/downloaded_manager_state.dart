part of 'downloaded_manager_cubit.dart';

enum DownloadedStatus { initial, loaded, error }

class DownloadedManagerState extends Equatable {
  final DownloadedStatus status;
  final Map<MovieEntity, List<ServerDataEntity>> downloadedMovieMaps;
  const DownloadedManagerState({
    this.status = DownloadedStatus.initial,
    this.downloadedMovieMaps = const {},
  });

  @override
  List<Object> get props => [status, downloadedMovieMaps];

  DownloadedManagerState copyWith({
    DownloadedStatus? status,
    Map<MovieEntity, List<ServerDataEntity>>? downloadedMovieMaps,
  }) {
    return DownloadedManagerState(
      status: status ?? this.status,
      downloadedMovieMaps: downloadedMovieMaps ?? this.downloadedMovieMaps,
    );
  }
}
