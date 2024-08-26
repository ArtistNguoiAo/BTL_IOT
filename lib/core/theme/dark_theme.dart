import 'package:btl_iot/core/theme/base_theme.dart';
import 'package:flutter/material.dart';

class DarkTheme extends BaseTheme {
  DarkTheme._();

  static final DarkTheme _instance = DarkTheme._();

  factory DarkTheme() => _instance;

  @override
  Color get backgroundColor => const Color(0xFF000000);
}