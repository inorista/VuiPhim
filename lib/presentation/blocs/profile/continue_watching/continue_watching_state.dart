part of 'continue_watching_cubit.dart';

enum ContinueWatchingStatus { initial, loading, loaded, error }

class ContinueWatchingState extends Equatable {
  final ContinueWatchingStatus status;
  final List<ContinueWatchingUIModel> continueWatchingList;

  const ContinueWatchingState({
    this.status = ContinueWatchingStatus.initial,
    this.continueWatchingList = const [],
  });

  @override
  List<Object> get props => [status, continueWatchingList];

  ContinueWatchingState copyWith({
    ContinueWatchingStatus? status,
    List<ContinueWatchingUIModel>? continueWatchingList,
  }) {
    return ContinueWatchingState(
      status: status ?? this.status,
      continueWatchingList: continueWatchingList ?? this.continueWatchingList,
    );
  }
}
