import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
import 'package:vuiphim/presentation/screens/main_screen/main_screen.dart';
import 'package:vuiphim/presentation/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:vuiphim/presentation/screens/select_movie_episode_screen/select_movie_episode_screen.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/video_player_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/main',
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
      path: AppRouter.videoPlayer,
      builder: (context, state) {
        final serverData = state.extra as ServerDataEntity;
        return VideoPlayerScreen(serverData: serverData);
      },
    ),
  ],
);

class AppRouter {
  static String main = '/main';
  static String movieDetail = '/movie_detail/:id';
  static String selectMovieEpisode = '/select_movie_episode';
  static String videoPlayer = '/video_player';
}
