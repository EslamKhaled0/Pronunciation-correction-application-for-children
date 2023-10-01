import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationState();

  static FlutterLocalNotificationsPlugin localNotification =
      new FlutterLocalNotificationsPlugin();
  static bool notificationStatus = true;

  static Future showNotification(
      String titleOfNotification, String bodyOfNotification) async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName",
        channelDescription: "this is the description");
    var iosDetails = new DarwinNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
     localNotification.show(0, "$titleOfNotification",
        "$bodyOfNotification", generalNotificationDetails);
  }
}

class _NotificationState extends State<NotificationScreen> {
   FlutterLocalNotificationsPlugin? localNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = new DarwinInitializationSettings();
     var initializationSetting = new InitializationSettings(
         android: androidInitialize, iOS: iOSInitialize);
     localNotification = new FlutterLocalNotificationsPlugin();
    localNotification!.initialize(initializationSetting);
  }

   //  Future _showNotification(String titleOfNotification , String bodyOfNotification) async {
   //   // String titleOfNotification = '';
   //   // String bodyOfNotification = '';
   //   var androidDetails = new AndroidNotificationDetails(
   //       "channelId", "channelName",
   //       channelDescription: "this is the description");
   //  var iosDetails = new DarwinNotificationDetails();
   //  var generalNotificationDetails =
   //       new NotificationDetails(android: androidDetails, iOS: iosDetails);
   //   await localNotification?.show(0, "$titleOfNotification",
   //       "$bodyOfNotification", generalNotificationDetails);
   // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text(
              'الاشعارات',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                // _showNotification('this is title', 'goood');
                setState(() {
                  NotificationScreen.notificationStatus =
                      !NotificationScreen.notificationStatus;
                });
              },
              child: Icon(NotificationScreen.notificationStatus == true
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              size: 100,),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text('اضغط علي زر الجرس لإظهار أو لإخفاء الإشعارات'),
            ),
          ],
        ));
  }
}
