import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gp_project/module/settings/notification.dart';
import 'package:gp_project/module/settings/settings.dart';
import 'package:gp_project/users/userPrefrences/current_user.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';
import 'model/user.dart';

class UserPasswordClass extends StatefulWidget {
  @override
  State<UserPasswordClass> createState() => _UserPasswordClassState();
}

class _UserPasswordClassState extends State<UserPasswordClass> {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _passwordInVisible = true;
  NotificationScreen notification = new NotificationScreen();

  @override
  Widget build(BuildContext context) {
    saveUserData() async{
      User userModel = User(
          _rememberCurrentUser.user.id,
          _rememberCurrentUser.user.name,
          _rememberCurrentUser.user.email,
          password.text
      );

      try{
        var res = await http.post(
          Uri.parse(API.updateName),
          body: userModel.toJson(),
        );

        if(res.statusCode == 200){
          var resBodyOfSignup = jsonDecode(res.body);
          if(resBodyOfSignup['success']){
            _rememberCurrentUser.user.password = password.text;
            Fluttertoast.showToast(msg: "مبروك, لقد تم تغيير كلمة السر بنجاح");

            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
          }
          else{
            Fluttertoast.showToast(msg: "لقد حدث خطأ ما, حاول مرة اخري");
          }
        }
      }

      catch(e){
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }

    password = TextEditingController(text: _rememberCurrentUser.user.password);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text(
            'كلمة المرور',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 30, 20, 0),
            child: Text(
              "كلمة المرور ",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: TextFormField(
                    controller: password,
                    obscureText: _passwordInVisible,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 18, 0, 18),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0)
                        ),
                        labelStyle: TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordInVisible ? Icons.visibility_off : Icons.visibility, //change icon based on boolean value
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: (){
                            setState(() {
                              _passwordInVisible = !_passwordInVisible; //change boolean value
                            });
                          },
                        )
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 60)
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      saveUserData();
                      if(NotificationScreen.notificationStatus == true) {
                        NotificationScreen.showNotification(
                            'كلمة السر', 'تم تغيير كلمة السر بنجاح');
                      }
                    }
                  },
                  child: const Text(
                    "حفظ",
                    style: TextStyle(fontSize: 25,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
