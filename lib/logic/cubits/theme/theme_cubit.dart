import 'package:calculator2/presentation/designs/app_theme.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> with HydratedMixin {
  ThemeCubit() : super(ThemeMode.light) {
    hydrate();
    _onSetStatusBarAndNavigationBarColors(state);
  }

  void onToggleTheme({ThemeMode? themeMode}) {
    themeMode ??= (state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    _onSetStatusBarAndNavigationBarColors(themeMode);
    emit(themeMode);
  }

  void _onSetStatusBarAndNavigationBarColors(ThemeMode themeMode) =>
      AppTheme.setStatusBarAndNavigationBarColors(themeMode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values
        .firstWhereOrNull((element) => element.name == json['value']);
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'value': state.name};
  }
}
