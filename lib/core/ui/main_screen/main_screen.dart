import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/core/bloc/dash_board/dash_board_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DashBoardCubit(),
        child: BlocBuilder<DashBoardCubit, DashBoardState>(
          builder: (context, state) {
            if (state is DashBoardLoaded) {
              final currentIndex = state.boardIndex;
              return Center(child: Text('Current Board Index: $currentIndex'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
