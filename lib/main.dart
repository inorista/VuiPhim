import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/hive_database/hive_database.dart';
import 'package:vuiphim/core/router/app_router.dart';
import 'package:vuiphim/core/services/interfaces/ibackground_sync.dart';
import 'package:vuiphim/core/services/interfaces/ifirebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EnvironmentLocator.setupServiceLocator();
  await locator<IFirebaseService>().getTmdbApiKey();
  await EnvironmentLocator.setupRestClient();
  await HiveDatabase().setupHiveDatabase();
  await locator<IBackgroundSync>().syncGenres();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VuiPhim',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fontFamily: 'Roboto',
      ),
    );
  }
}
