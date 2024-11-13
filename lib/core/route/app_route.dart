import 'package:btl_iot/iot_pdf_screen/view/iot_pdf_screen.dart';
import 'package:btl_iot/profile_screen/view/profile_screen.dart';
import 'package:btl_iot/salomon_screen/view/salomon_screen.dart';
import 'package:btl_iot/splash_screen/view/splash_screen.dart';
import 'package:btl_iot/wind_screen/wind_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String salomon = '/salomon';
  static const String profile = '/profile';
  static const String iotPdf = '/iot-pdf';
  static const String wind = '/wind';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case salomon:
        return MaterialPageRoute(builder: (_) => const SalomonScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case iotPdf:
        return MaterialPageRoute(builder: (_) => const IotPdfScreen());
      case wind:
        return MaterialPageRoute(builder: (_) => const WindScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Error!'))));
    }
  }
}