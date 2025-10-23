import 'dart:io';
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:vuiphim/core/native/vibration_native.dart';
import 'package:vuiphim/presentation/blocs/dash_board/dash_board_cubit.dart';
import 'package:vuiphim/core/constants/app_text.dart';
import 'package:vuiphim/presentation/blocs/explore/explore_cubit.dart';
import 'package:vuiphim/presentation/blocs/home/popular_movie/popular_movie_cubit.dart';
import 'package:vuiphim/presentation/blocs/home/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:vuiphim/presentation/blocs/home/upcoming_movie/upcoming_movie_cubit.dart';
import 'package:vuiphim/presentation/screens/explore_screen/explore_screen.dart';
import 'package:vuiphim/presentation/screens/home_screen/home_screen.dart';
import 'package:vuiphim/presentation/screens/main_screen/widgets/bottom_navigation_item.dart';
import 'package:vuiphim/presentation/screens/profile_screen/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashBoardCubit>(
      create: (context) => DashBoardCubit(),
      child: Scaffold(
        extendBody: true,
        body: BlocBuilder<DashBoardCubit, DashBoardState>(
          builder: (context, state) {
            if (state is DashBoardLoaded) {
              return LazyLoadIndexedStack(
                index: state.boardIndex,
                preloadIndexes: const [0, 1],
                autoDisposeIndexes: const [2],
                children: [
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<PopularMovieCubit>(
                        create: (context) =>
                            PopularMovieCubit()..fetchPopularMovies(),
                      ),
                      BlocProvider<TopRatedMovieCubit>(
                        create: (context) =>
                            TopRatedMovieCubit()..fetchTopRatedMovies(),
                      ),
                      BlocProvider<UpcomingMovieCubit>(
                        create: (context) =>
                            UpcomingMovieCubit()..fetchUpcomingMovies(),
                      ),
                    ],
                    child: const HomeScreen(),
                  ),
                  BlocProvider<ExploreCubit>(
                    create: (context) => ExploreCubit()..loadNowPlayingMovies(),
                    child: const ExploreScreen(),
                  ),
                  const ProfileScreen(),
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
              return _buildBottomNavigationBar(context, state, dashboardCubit);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    DashBoardLoaded state,
    DashBoardCubit dashboardCubit,
  ) {
    return Stack(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              color: Colors.black.withAlpha(150),
              height: Platform.isAndroid ? 65 : 88,
              width: double.infinity,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          height: Platform.isAndroid ? 65 : 88,
          color: Colors.transparent,
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: BottomNavigationItem(
                    onTap: () {
                      VibrationNative.vibrateWithIntensity(1);
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
                      VibrationNative.vibrateWithIntensity(1);
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
                      VibrationNative.vibrateWithIntensity(1);
                      dashboardCubit.changeBoardIndex(2);
                    },
                    isSelected: state.boardIndex == 2,
                    label: AppText.settings,
                    iconPath: 'assets/icons/profile_icon.svg',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
