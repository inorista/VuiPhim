import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/ui/main_screen/main_screen.dart';

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
  ],
);
