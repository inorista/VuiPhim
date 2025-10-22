part of 'continue_watching_cubit.dart';

enum ContinueWatchingStatus { initial, loading, loaded, error }

class ContinueWatchingState extends Equatable {
  final ContinueWatchingStatus status;

  const ContinueWatchingState({this.status = ContinueWatchingStatus.initial});

  @override
  List<Object> get props => [status];
}
