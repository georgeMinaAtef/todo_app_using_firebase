
import 'package:firebase_and_flutter_app/shared/mode_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../network/cach_helper.dart';



class ModeCubit extends Cubit<ModeStates> {
  ModeCubit() : super(ModeInitialState());

  static ModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  Color backgroundColor = Colors.white;

  void changeAppMode({bool? fromShared}) {
    if (fromShared == null)
    {
      isDark = !isDark;
    }
    else
    {
      isDark = fromShared;
    }
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
    {
      if (isDark)
      {
        backgroundColor = HexColor('333739').withOpacity(0.8);
        emit(AppChangeModeState());
      }
      else
      {
        backgroundColor = Colors.white;
        emit(AppChangeModeState());
      }
      emit(AppChangeModeState());
    });
  }
}
