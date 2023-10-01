import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_cubit.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_states.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required VoidCallback function,
  required String text,
}) =>
    BlocProvider(
      create: (BuildContext context) => MatrialAppCubit(),
      child: BlocConsumer<MatrialAppCubit, MatrialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              color: background,
            ),
            child: MaterialButton(
              onPressed: function,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.mic,
                    ),
                    Spacer(),
                    Text(
                      isUpperCase ? text.toUpperCase() : text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
