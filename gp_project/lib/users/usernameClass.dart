import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gp_project/module/settings/settings.dart';
import 'package:gp_project/users/userPrefrences/current_user.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';
import 'model/user.dart';

class UsernameClass extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());
  TextEditingController username = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    saveUserData() async{
      User userModel = User(
          _rememberCurrentUser.user.id,
          username.text,
          _rememberCurrentUser.user.email,
          _rememberCurrentUser.user.password
      );

      try{
        var res = await http.post(
          Uri.parse(API.updateName),
          body: userModel.toJson(),
        );

        if(res.statusCode == 200){
          var resBodyOfSignup = jsonDecode(res.body);
          if(resBodyOfSignup['success']){
            _rememberCurrentUser.user.name = username.text;
            Fluttertoast.showToast(msg: "مبروك, لقد تم تغيير اسمك بنجاح");

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

    username = TextEditingController(text: _rememberCurrentUser.user.name);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text(
            'اسم المستخدم',
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
              "اسم المستخدم ",
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
                    controller: username,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20, 18, 0, 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      labelStyle: TextStyle(fontSize: 20),
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
