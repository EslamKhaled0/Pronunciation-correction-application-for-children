import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gp_project/module/level/cubit/states.dart';
import 'package:gp_project/module/level/the_lesson_level1.dart';
import 'package:gp_project/module/level/cubit/cubit.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_cubit.dart';
import 'package:gp_project/users/userPrefrences/current_user.dart';

class LessonsScreenLevel1 extends StatefulWidget {
  var numOfLevel;
  //came from previous screen and equal the number of level
  LessonsScreenLevel1({super.key, required this.numOfLevel});

  @override
  State<LessonsScreenLevel1> createState() => _LessonsScreenLevel1State();
}

class _LessonsScreenLevel1State extends State<LessonsScreenLevel1> {
  late AppCubitLevel1 _cubit;
  CurrentUser _currentUser = Get.put(CurrentUser());

  // late int theLessons ;


  @override
  void initState() {
    super.initState();
    _cubit = AppCubitLevel1.get(context);
    // theLessons = _cubit.locks1[0]['level${widget.numOfLevel}'];
    print(_cubit.locks1);

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitLevel1, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        List<int> numOfLessons = [
          _cubit.materials1.length,
          _cubit.materials2.length,
          _cubit.materials3.length,
          _cubit.materials4.length,
          _cubit.materials5.length,
          _cubit.materials6.length,
          _cubit.materials7.length,
          _cubit.materials8.length,
          _cubit.materials9.length,
          _cubit.materials10.length,
          _cubit.materials11.length,
          _cubit.materials12.length
        ];
        // print(widget.numOfLevel);
        // AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Align(
              child: Text(
                widget.numOfLevel != 12
                    ? 'المستوي ${widget.numOfLevel}'
                    : 'الاختبار',
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                buildLessonItem(index, context, widget.numOfLevel),
            // index used to send number of item to buildlessonItem

            separatorBuilder: (context, index) => const SizedBox(
              width: 20.0,
            ),

            itemCount: numOfLessons[widget.numOfLevel - 1],
          ),
        );
      },
    );
  }

  Widget buildLessonItem(index, context, numOfLevel) =>
      Builder(builder: (context) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // while(_cubit.locks1.length == 0) {}
                if (_cubit.locks1.isNotEmpty){
                  if (_cubit.locks1[_currentUser.user.id - 1]['level${widget.numOfLevel}'] - 1 >=
                      index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            TheLessonLevel1(
                              index: index,
                              numOfLevel: numOfLevel,
                            ),
                      ),
                    );
                  }
                }
            },
            child: Container(
              height: 55.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  color: MatrialAppCubit.get(context).buttonColor),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 35.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_cubit.locks1.isNotEmpty)
                    if (_cubit.locks1[_currentUser.user.id - 1]['level${widget.numOfLevel}'] - 1 < index)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.lock,
                              size: 35.0,
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'الدرس ${index + 1}',
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
