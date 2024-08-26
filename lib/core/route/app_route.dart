import 'package:btl_iot/home_screen/view/home_screen.dart';
import 'package:btl_iot/splash_screen/view/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Error!'))));
    }
  }
}