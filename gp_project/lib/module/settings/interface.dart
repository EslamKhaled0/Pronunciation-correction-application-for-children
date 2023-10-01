import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gp_project/module/level/cubit/cubit.dart';
import 'package:gp_project/module/level/lessons_screen_level1.dart';
import 'package:gp_project/module/settings/settings.dart';
import 'package:gp_project/users/userPrefrences/current_user.dart';

class Interface extends StatefulWidget {
  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  CurrentUser _currentUser = Get.put(CurrentUser());
  String title = 'المستوي 1';
  var numOfLevel;
  int currentIndex = 0;
  List<Widget> screens = [
    Settings(),
  ];
  late AppCubitLevel1 _cubit1;

  void initState() {
    super.initState();
    _cubit1 = AppCubitLevel1.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/image_auto_x2-removebg.png'),
        title: Align(
          child: const Text('المُلَقِّنْ',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              )),
        ),
        actions: [
          Text(title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              )),
        ],
      ),
      body: Stack(
        children: [
          Image(
            height: double.infinity,
            width: double.infinity,
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
          ListView.separated(
            itemBuilder: (context, index) => buildLevelItem(index),
            separatorBuilder: (context, index) => const SizedBox(
              height: 300.0,
            ),
            itemCount: 12,
          )
        ],
      ),
    );
  }

  Widget buildLevelItem(index) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: (index + 1) % 2 == 0
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.large(
                      heroTag: "btn${index + 1}",
                      onPressed: () {
                        print(_currentUser.user.id);
                        _cubit1.insertToDatabase1('locks1', {
                          'level1': 1,
                          'level2': 1,
                          'level3': 1,
                          'level4': 1,
                          'level5': 1,
                          'level6': 1,
                          'level7': 1,
                          'level8': 1,
                          'level9': 1,
                          'level10': 1,
                          'level11': 1,
                          'level12': 1,
                          'user_id': _currentUser.user.id,
                        });
                        numOfLevel = index + 1;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<AppCubitLevel1>(context),
                              child: LessonsScreenLevel1(
                                numOfLevel: numOfLevel,
                              ),
                            ),
                          ),
                        );
                        setState(() {
                          title = index + 1 == 12
                              ? 'الاختبار'
                              : 'المستوي ${index + 1}';
                        });
                      },
                      shape: const CircleBorder(),
                      child: Text(
                        index + 1 == 12 ? 'اختبار' : '${index + 1}',
                        style: TextStyle(
                          fontSize: index + 1 == 12 ? 30.0 : 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
