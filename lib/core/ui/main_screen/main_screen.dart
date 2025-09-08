import 'dart:io';
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/core/blocs/dash_board/dash_board_cubit.dart';
import 'package:vuiphim/core/constants/app_text.dart';
import 'package:vuiphim/core/ui/home_screen/home_screen.dart';
import 'package:vuiphim/core/ui/main_screen/widgets/bottom_navigation_item.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashBoardCubit(),
      child: Scaffold(
        extendBody: true,
        body: BlocBuilder<DashBoardCubit, DashBoardState>(
          builder: (context, state) {
            if (state is DashBoardLoaded) {
              return IndexedStack(
                index: state.boardIndex,
                children: const [
                  HomeScreen(),
                  HomeScreen(),
                  HomeScreen(),
                  HomeScreen(),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),

        bottomNavigationBar: BlocBuilder<DashBoardCubit, DashBoardState>(
          builder: (context, state) {
            final dashboardCubit = context.read<DashBoardCubit>();
            if (state is DashBoardLoaded) {
              return Stack(
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        color: Colors.black.withAlpha(150),
                        height: Platform.isIOS ? 100 : 80,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: Platform.isIOS ? 100 : 80,
                    color: Colors.transparent,
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: BottomNavigationItem(
                              onTap: () {
                                dashboardCubit.changeBoardIndex(0);
                              },
                              isSelected: state.boardIndex == 0,
                              label: AppText.home,
                              iconPath: 'assets/icons/home_icon.svg',
                            ),
                          ),

                          Expanded(
                            child: BottomNavigationItem(
                              onTap: () {
                                dashboardCubit.changeBoardIndex(1);
                              },
                              isSelected: state.boardIndex == 1,
                              label: AppText.explore,
                              iconPath: 'assets/icons/explore_icon.svg',
                            ),
                          ),
                          Expanded(
                            child: BottomNavigationItem(
                              onTap: () {
                                dashboardCubit.changeBoardIndex(2);
                              },
                              isSelected: state.boardIndex == 2,
                              label: AppText.favorites,
                              iconPath: 'assets/icons/favourite_icon.svg',
                            ),
                          ),
                          Expanded(
                            child: BottomNavigationItem(
                              onTap: () {
                                dashboardCubit.changeBoardIndex(3);
                              },
                              isSelected: state.boardIndex == 3,
                              label: AppText.settings,
                              iconPath: 'assets/icons/setting_icon.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
