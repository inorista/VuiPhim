part of 'dash_board_cubit.dart';

abstract class DashBoardState extends Equatable {
  const DashBoardState();

  @override
  List<Object> get props => [];
}

class DashBoardLoaded extends DashBoardState {
  final int boardIndex;
  const DashBoardLoaded({this.boardIndex = 0});

  @override
  List<Object> get props => [boardIndex];
}
