import 'package:firebase_and_flutter_app/shared/mode_cubit/cubit.dart';
import 'package:firebase_and_flutter_app/shared/mode_cubit/states.dart';
import 'package:firebase_and_flutter_app/shared/network/cach_helper.dart';
import 'package:firebase_and_flutter_app/shared/network/dio_helper.dart';
import 'package:firebase_and_flutter_app/shared/styles/bloc_observer.dart';
import 'package:firebase_and_flutter_app/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'layout/home_layout/home_layout.dart';


void main() async { 
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // BlocOverrides.runZoned(
  //       () {},
  //   blocObserver: MyBlocObserver() ,
  // );
  DioHelper.init();
  await CacheHelper.init();

  late bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(Myapp(
    // startWidget: widget ,
    isDark: isDark,
  ));
}

class Myapp extends StatelessWidget {
  final  bool? isDark;

  const Myapp({Key? key,
    this.isDark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ModeCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ) ,
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ModeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}