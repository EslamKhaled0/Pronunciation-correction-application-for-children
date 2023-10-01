import 'package:flutter/material.dart';
import 'package:gp_project/module/settings/about.dart';
import 'package:gp_project/module/settings/contact_us.dart';
import 'package:gp_project/module/settings/faq.dart';
import 'package:gp_project/module/settings/notification.dart';
import 'package:gp_project/module/settings/stories.dart';
import 'package:gp_project/module/settings/themes/theme.dart';
import 'package:gp_project/users/login_screen.dart';
import 'package:gp_project/users/userPasswordClass.dart';
import 'package:gp_project/users/userPrefrences/user_preferences.dart';
import 'package:gp_project/users/usernameClass.dart';
//import 'package:gp_project/users/userpasswordClass.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'تسجيل الخروج',
              style: TextStyle(fontSize: 23),
              textDirection: TextDirection.rtl,
            ),
            content: const SingleChildScrollView(
              child:  Text(
                'هل انت متأكد انك تريد تسجيل الخروج؟',
                style: TextStyle(fontSize: 19),
                textDirection: TextDirection.rtl,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'لا',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'نعم',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async{
                  await RememberUserPrefs.removeUserInfo().then((value) => {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()),ModalRoute.withName("/Login"))
                  });
                },
              ),
            ],

          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text(
            'الاعدادات',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: Image.asset(
          'assets/images/image_auto_x2-removebg.png',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Themes(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الألوان',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.format_paint,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UsernameClass()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'إسم المستخدم',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.person,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserPasswordClass()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'كلمة المرور',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.lock,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQ()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الاسئلة المتكررة',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.question_mark_outlined,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الإشعارات',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.notifications_active,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'نبذة عنا',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.announcement_outlined,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUs(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'إتصل بنا',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.phone,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Stories(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'قصص',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.local_library_outlined,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    _showMyDialog();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'تسجيل خروج',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
