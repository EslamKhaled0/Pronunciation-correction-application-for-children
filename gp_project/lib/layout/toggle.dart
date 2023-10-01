import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gp_project/module/settings/interface.dart';
import 'package:gp_project/module/level/cubit/cubit.dart';
import 'package:gp_project/module/settings/settings.dart';
import 'package:gp_project/users/userPrefrences/current_user.dart';

class Toggle extends StatefulWidget {
  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  CurrentUser _currentUser = Get.put(CurrentUser());
  int currentIndex = 0;
  bool createdDB = false;
  late AppCubitLevel1 _cubit1;


  List<Widget> screens = [
    Interface(),
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
    _cubit1 = AppCubitLevel1.get(context);

    _cubit1.createDatabase1();
    _cubit1.getDataFromDatabase1(AppCubitLevel1.database1);
    // if(createdDB == true){
    //   _cubit1.insertToDatabase1('locks1', {
    //     'level1': 1,
    //     'level2': 1,
    //     'level3': 1,
    //     'level4': 1,
    //     'level5': 1,
    //     'level6': 1,
    //     'level7': 1,
    //     'level8': 1,
    //     'level9': 1,
    //     'level10': 1,
    //     'level11': 1,
    //     'level12': 1,
    //     'user_id': _currentUser.user.id,
    //   });
    //
    // }

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CurrentUser(),
        initState: (currentState){
          _currentUser.getUserInfo();
        },
        builder: (controller){
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 20.0,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.white),
                  label: 'المستويات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  label: 'الإعدادات',
                ),
              ],
            ),
          );
          },
        );
    }
}