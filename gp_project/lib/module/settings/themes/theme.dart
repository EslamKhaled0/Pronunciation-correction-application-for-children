import 'package:flutter/material.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_cubit.dart';

class Themes extends StatefulWidget {
  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              children: [
                MaterialButton(
                  minWidth: double.infinity,
                  height: 75,
                  onPressed: () {
                    MatrialAppCubit.get(context).initialAppMode();
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      'أزرق',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),

                MaterialButton(
                  minWidth: double.infinity,
                  height: 75,
                  onPressed: () {
                    MatrialAppCubit.get(context).changeAppMode();
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      'روز',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ],
              ),
        ),
        );
    }
}
