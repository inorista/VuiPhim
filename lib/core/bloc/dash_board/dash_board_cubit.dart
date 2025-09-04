import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dash_board_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  DashBoardCubit() : super(DashBoardLoaded(boardIndex: 0));

  void changeBoardIndex(int index) {
    emit(DashBoardLoaded(boardIndex: index));
  }
}
