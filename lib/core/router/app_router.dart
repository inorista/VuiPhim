import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
import 'package:vuiphim/presentation/blocs/movie_search/movie_search_cubit.dart';
import 'package:vuiphim/presentation/screens/download_manager_screen/download_manager_screen.dart';
import 'package:vuiphim/presentation/screens/main_screen/main_screen.dart';
import 'package:vuiphim/presentation/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:vuiphim/presentation/screens/search_screen/search_screen.dart';
import 'package:vuiphim/presentation/screens/select_movie_episode_screen/select_movie_episode_screen.dart';
import 'package:vuiphim/presentation/screens/sticker_screen/sticker_screen.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/video_player_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRouter.main,
  routes: [
    GoRoute(
      path: AppRouter.main,
      builder: (context, state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: AppRouter.movieDetail,
      builder: (context, state) {
        final movieId = state.pathParameters['id'];
        return MovieDetailScreen(movieId: movieId!);
      },
    ),

    GoRoute(
      path: AppRouter.selectMovieEpisode,
      builder: (context, state) {
        final movieDetail = state.extra as MovieDetailEntity;
        return SelectMovieEpisodeScreen(movieDetail: movieDetail);
      },
    ),

    GoRoute(
      path: AppRouter.search,
      builder: (context, state) {
        return BlocProvider<MovieSearchCubit>(
          create: (context) => MovieSearchCubit()..getNowPlayingMovies(),
          child: const SearchScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRouter.videoPlayer,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final movieDetail = data['movieDetail'] as MovieDetailEntity;
        final serverData = data['serverData'] as ServerDataEntity;
        return VideoPlayerScreen(
          movieDetail: movieDetail,
          serverData: serverData,
        );
      },
    ),

    GoRoute(
      path: AppRouter.stickerScreen,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final movieDetail = data['movieDetail'] as MovieDetailEntity;
        return StickerScreen(movieDetail: movieDetail);
      },
    ),

    GoRoute(
      path: AppRouter.downloadManager,
      builder: (context, state) {
        return const DownloadManagerScreen();
      },
    ),
  ],
);

// Export the navigator key so it can be used in other files
GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

class AppRouter {
  static String main = '/main';
  static String movieDetail = '/movie_detail/:id';
  static String selectMovieEpisode = '/select_movie_episode';
  static String videoPlayer = '/video_player';
  static String search = '/search';
  static String stickerScreen = '/sticker_screen';
  static String downloadManager = '/download_manager';
}
