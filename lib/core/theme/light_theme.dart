import 'package:btl_iot/core/theme/base_theme.dart';
import 'package:flutter/material.dart';

class LightTheme extends BaseTheme {
  LightTheme._();

  static final LightTheme _instance = LightTheme._();

  factory LightTheme() => _instance;

  @override
  Color get backgroundColor => const Color(0xFF000000);
}