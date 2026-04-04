import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/router/app_router.dart';
import 'package:vuiphim/core/services/interfaces/ibackground_sync.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';
import 'package:vuiphim/core/services/interfaces/ilocal_notification_service.dart';
import 'package:vuiphim/core/services/interfaces/ipush_notification_service.dart';
import 'package:vuiphim/presentation/blocs/download_manager/download_manager_cubit.dart';
import 'package:vuiphim/presentation/blocs/home/popular_movie/popular_movie_cubit.dart'
    show PopularMovieCubit;
import 'package:vuiphim/presentation/blocs/home/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:vuiphim/presentation/blocs/home/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:vuiphim/presentation/blocs/home/upcoming_movie/upcoming_movie_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();
  await locator<ILocalNotificationService>().initialize();
  await locator<ILocalNotificationService>().requestPermissions();
  await locator<IPushNotificationService>().initialize();
  await HiveDatabase().setupHiveDatabase();
  await locator<IBackgroundSync>().syncGenres();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DownloadManagerCubit>(
          create: (context) => DownloadManagerCubit(),
        ),
        BlocProvider<PopularMovieCubit>(
          create: (context) => PopularMovieCubit()..fetchPopularMovies(),
        ),
        BlocProvider<TopRatedMovieCubit>(
          create: (context) => TopRatedMovieCubit()..fetchTopRatedMovies(),
        ),
        BlocProvider<UpcomingMovieCubit>(
          create: (context) => UpcomingMovieCubit()..fetchUpcomingMovies(),
        ),
      ],
      child: MaterialApp.router(
        title: 'VuiPhim',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          fontFamily: 'Roboto',
        ),
        builder: EasyLoading.init(),
      ),
    );
  }
}
