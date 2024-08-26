import 'package:btl_iot/core/extension/ext_context.dart';
import 'package:btl_iot/core/route/app_route.dart';
import 'package:btl_iot/core/theme/cubit/theme_cubit.dart';
import 'package:btl_iot/core/theme/inherited_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit()..init(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return InheritedThemeWidget(
            themeModeEnum: state.themeModeEnum,
            child: MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: context.theme.backgroundColor),
                useMaterial3: true,
              ),
              initialRoute: AppRoutes.splash,
              onGenerateRoute: AppRoutes.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
