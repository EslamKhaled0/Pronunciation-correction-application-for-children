import 'package:flutter/material.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_cubit.dart';
import 'package:gp_project/presentation/my_flutter_app_icons.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  final members = [
    {'name': 'إسراء سعيد هاشم', 'role': 'القائد', 'icon': MyFlutterApp.user_female},
    {'name': 'إسلام خالد محمد', 'role': 'عضو', 'icon': MyFlutterApp.user_male},
    {'name': 'إسلام خالد السيد', 'role': 'عضو', 'icon': MyFlutterApp.user_male},
    {'name': 'إسلام حامد أحمد', 'role': 'عضو', 'icon': MyFlutterApp.user_male},
    {'name': 'سارة إبراهيم صلاح', 'role': 'عضو', 'icon': MyFlutterApp.user_female},
    {'name': 'إستبرق محمد صبحي', 'role': 'عضو', 'icon': MyFlutterApp.user_male},
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _animation =
        CurvedAnimation(parent: _controller!, curve: Curves.linearToEaseOut);
    _controller?.forward();
  }

  @override
  dispose() {
    _controller!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          child: Text(
            'نبذة عنا',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: 0,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ))),
                child: Text(
                  'تعرف علينا',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),

              Container(
                height: 500,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 30.0),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];

                    return Align(
                      alignment: Alignment.centerRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizeTransition(
                          sizeFactor: _animation!,
                          axis: Axis.horizontal,
                          axisAlignment: 0,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 175,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Align(
                                            alignment : Alignment.centerRight,
                                            child: Text(
                                              member['name'].toString(),
                                              textDirection: TextDirection.rtl,
                                              // maxLines: 1,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    member['role'].toString(),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20.0),
                              Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: MatrialAppCubit.get(context).buttonColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(80),
                                    bottomLeft: Radius.circular(80),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    member['icon'] as IconData?,
                                    size: 75.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
