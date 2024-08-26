import 'package:btl_iot/core/theme/base_theme.dart';
import 'package:btl_iot/core/theme/inherited_theme.dart';
import 'package:btl_iot/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

extension ExtContext on BuildContext {
  BaseTheme get theme {
    final theme = InheritedThemeWidget.of(this)?.getThemeData() ?? LightTheme();
    return theme;
  }
}