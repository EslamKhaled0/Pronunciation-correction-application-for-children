import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/module/level/cubit/cubit.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_cubit.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_states.dart';
import 'package:gp_project/layout/toggle.dart';
import 'package:gp_project/users/login_screen.dart';
import 'package:gp_project/users/userPrefrences/user_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MatrialAppCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubitLevel1(),
        ),
      ],
      child: BlocConsumer<MatrialAppCubit, MatrialAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Login',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.blue[500],
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.blue[500],
                  elevation: 20.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.blue[500],
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.blue[500],
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Color.fromARGB(255, 37, 79, 113),
                ),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.pink,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.pink,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.pink,
                  elevation: 20.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.pink,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.pink,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Color.fromARGB(255, 82, 17, 39),
                ),
              ),
              themeMode: MatrialAppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: FutureBuilder(
                future: RememberUserPrefs.readUserInfo(),
                builder: (context, datasnapshot){
                  if(datasnapshot.data == null){
                    return LoginScreen();
                  }
                  else{
                    return Toggle();
                  }
                },
              ),
            );
          }),
    );
  }
}
