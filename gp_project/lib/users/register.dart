import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api_connection/api_connection.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
import 'model/user.dart';

class Register extends StatefulWidget{
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateUserEmail() async{
    try{
      var res = await http.post(
          Uri.parse(API.validateEmail),
          body: {
            //to connect the php code file with the flutter
            'email': emailController.text.trim()
          }
      );

      if(res.statusCode == 200){
        var resBody = jsonDecode(res.body);//get the returned value from the file

        if(resBody['emailFound']){ //means that it already exists as the result will return true
          Fluttertoast.showToast(msg: "البريد الاكتروني يوجد بالفعل");
        }
        else{
          saveUserData();
        }
      }
    }
    catch(e){

    }
  }

  saveUserData() async{
    User userModel = User(
        1,
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim()
    );

    try{
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if(res.statusCode == 200){
        var resBodyOfSignup = jsonDecode(res.body);
        if(resBodyOfSignup['success']){
          Fluttertoast.showToast(msg: "لقد قمت بانشاء الحساب بنجاح");
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          passwordConfirmController.clear();

          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
        else{
          Fluttertoast.showToast(msg: "حدث خطأ ما, حاول نسجيل دخولك مرة اخري");
        }
      }
    }

    catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "إنشاء حساب",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery
              .of(context)
              .size
              .width / 20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: 50,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "الإسم",
                            contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0)
                            ),
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty || (!RegExp((r'(\w){3,}'))
                                  .hasMatch(value))) {
                                return "الاسم يجب ان يحتوي علي 3 حروف علي الاقل";
                              }
                            }
                            else {
                              return null;
                            }
                          },
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "إسم الحساب",
                              contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0)
                              ),
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (!RegExp(
                                    (r'^([a-z0-9A-Z]{3,})[@][g][m][a][i][l][.]([c][o][m]|[n][e][t])$'))
                                    .hasMatch(value)) {
                                  return "البردي الالكتروني غير صحيح\n";
                                }
                              }
                              else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "كلمة السر",
                              contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0)
                              ),
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (value.length < 8) {
                                  return "كلمة المرور تتكون من 8 أحرف على الأقل\n";
                                }

                                if (!RegExp("(?=.*[a-z])").hasMatch(value)) {
                                  return "يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل\n";
                                }
                                if (!RegExp((r'\d')).hasMatch(value)) {
                                  return "يجب أن تحتوي كلمة المرور على رقم واحد على الأقل\n";
                                }
                              }
                              else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: passwordConfirmController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "تأكيد كلمة السر",
                              contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0)
                              ),
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            validator: (value) {
                              String confirm = passwordController.text;
                              if (value != null) {
                                if (value != confirm) {
                                  return "كلمة المرور غير متطابقة";
                                }
                              }
                              else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width / 8
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14)
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //validate that the email doesn't exist in the database
                                validateUserEmail();
                              }
                            },
                            child: const Text(
                              "إنشاء الحساب",
                              style: TextStyle(fontSize: 22,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Text("هل لديك حساب بالفعل؟", style: TextStyle(
                                fontSize: 20, color: Colors.blueAccent.shade700),),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}