import 'package:appgain_movies_task/features/notifications/view.dart';
import 'package:appgain_movies_task/features/splash/view.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {NotificationsView.route: (context) => const NotificationsView()},
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.orange,
      )),
      home: const SplashView(),
    );
  }
}
