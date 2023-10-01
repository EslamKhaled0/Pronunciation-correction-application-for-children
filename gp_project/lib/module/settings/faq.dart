import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_cubit.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_states.dart';

class FAQ extends StatefulWidget {
  @override
  State<FAQ> createState() => _FAQState();
}



class _FAQState extends State<FAQ> {

  String textFromFile = 'empty';

  getData() async {
    String response;
    response = await rootBundle
        .loadString('assets/text_files/FAQ.txt');
    setState(() {
      textFromFile = response;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<MatrialAppCubit, MatrialAppStates>(
      listener: (BuildContext context, MatrialAppStates state) {},
      builder: (BuildContext context, MatrialAppStates state) {
        return Scaffold(
          appBar: AppBar(
            // leading: Icon(Icons.arrow_back),
            title: Align(
              child: Text(
                'الاسئلة المتكررة',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                height: 600,
                // width: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: MatrialAppCubit.get(context).background,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            textFromFile,
                            textDirection: TextDirection.rtl,
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
