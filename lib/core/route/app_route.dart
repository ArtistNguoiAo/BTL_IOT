import 'package:btl_iot/profile_screen/view/profile_screen.dart';
import 'package:btl_iot/salomon_screen/view/salomon_screen.dart';
import 'package:btl_iot/splash_screen/view/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String salomon = '/salomon';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case salomon:
        return MaterialPageRoute(builder: (_) => const SalomonScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Error!'))));
    }
  }
}