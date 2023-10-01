import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_states.dart';

class MatrialAppCubit extends Cubit<MatrialAppStates> {
  MatrialAppCubit() : super(MatrialAppInitialState());

  static MatrialAppCubit get(context) => BlocProvider.of(context);

  //initial blue , change pink

  bool isDark = false;

  Color background = Colors.blue;
  Color buttonColor = Colors.blue;

  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode() {
    isDark = true;
    background = Colors.pink[200]!;
    buttonColor = Colors.pink;
    Colors.pink;
    emit(AppInitialModeState());
  }

  void initialAppMode() {
    isDark = false;
    Colors.blue;
    background = Colors.blue;
    buttonColor = Colors.blue;

    emit(AppChangeModeState());
  }
}
