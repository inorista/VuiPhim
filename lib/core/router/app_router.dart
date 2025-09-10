import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/presentation/screens/main_screen/main_screen.dart';
import 'package:vuiphim/presentation/screens/movie_detail_screen/movie_detail_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/main',
      builder: (context, state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      name: 'movie_detail',
      path: '/movie_detail/:id',
      builder: (context, state) {
        final movieId = state.pathParameters['id'];
        return MovieDetailScreen(movieId: movieId!);
      },
    ),
  ],
);
