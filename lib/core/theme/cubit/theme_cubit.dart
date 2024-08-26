import 'package:bloc/bloc.dart';
import 'package:btl_iot/core/theme/inherited_theme.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeModeEnum: ThemeModeEnum.light));

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    String? themeSaved = prefs.getString('theme_saved');
    if (themeSaved == null) {
      emit(const ThemeState(themeModeEnum: ThemeModeEnum.light));
    } else {
      if (themeSaved == ThemeModeEnum.dark.name) {
        emit(const ThemeState(themeModeEnum: ThemeModeEnum.dark));
      }
      if (themeSaved == ThemeModeEnum.light.name) {
        emit(const ThemeState(themeModeEnum: ThemeModeEnum.light));
      }
    }
  }

  Future<void> changeTheme(ThemeModeEnum themeModeEnum) async {
    final prefs = await SharedPreferences.getInstance();
    if (themeModeEnum == ThemeModeEnum.dark) {
      await prefs.setString('theme_saved', ThemeModeEnum.dark.name);
    }
    if (themeModeEnum == ThemeModeEnum.light) {
      await prefs.setString('theme_saved', ThemeModeEnum.light.name);
    }
    emit(ThemeState(themeModeEnum: themeModeEnum));
  }
}
