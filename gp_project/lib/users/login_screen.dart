// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp_project/animation_enum.dart';
import 'package:gp_project/layout/toggle.dart';
import 'package:gp_project/users/register.dart';
import 'package:gp_project/users/userPrefrences/preferences.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';
import 'userPrefrences/user_preferences.dart';
import 'model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard? riveArtBoard;
  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookDownRight;
  late RiveAnimationController controllerLookDownLeft;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLookingRight = false;
  bool isLookingLeft = false;
  bool userFound = false;
  bool _passwordInVisible = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordFocusNode = FocusNode();

  loginUser() async{

    try{
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },

      );
      if(res.statusCode == 200){
        var resBodyOfLogin = await jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true){
          Fluttertoast.showToast(msg: "لقد قمت بالتسحيل بنجاح");
          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          await Preferences.saveUser(userInfo);//pass the logged in user data
          await RememberUserPrefs.saveRememberUser(userInfo);
          emailController.clear();
          passwordController.clear();
          userFound = true;

          Future.delayed(Duration(seconds: 2),(){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Toggle()));
          });
        }
        else{
          userFound = false;
          Fluttertoast.showToast(msg: "لقد حدث خطأ, حاول اعادة كتابة البريد الاكتروني و كلمة السر مرة اخري");
        }
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  void removeAllControllers(){
    riveArtBoard?.artboard.removeController(controllerIdle);
    riveArtBoard?.artboard.removeController(controllerFail);
    riveArtBoard?.artboard.removeController(controllerHandsDown);
    riveArtBoard?.artboard.removeController(controllerHandsUp);
    riveArtBoard?.artboard.removeController(controllerLookDownLeft);
    riveArtBoard?.artboard.removeController(controllerLookDownRight);
    riveArtBoard?.artboard.removeController(controllerSuccess);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addIdleController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerIdle);
  }

  void addHandsUpController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerHandsUp);
  }

  void addHandsDownController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerHandsDown);
  }

  void addLookDownRightController(){
    removeAllControllers();
    isLookingRight = true;
    riveArtBoard?.artboard.addController(controllerLookDownRight);
  }

  void addLookDownLeftController(){
    removeAllControllers();
    isLookingLeft = true;
    riveArtBoard?.artboard.addController(controllerLookDownLeft);
  }

  void addSuccessController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerSuccess);
  }

  void addFailController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerFail);
  }

  void checkPassFocusNode(){
    passwordFocusNode.addListener(() {
      if(passwordFocusNode.hasFocus){
        addHandsUpController();
      }
      else{
        addHandsDownController();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.Hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerLookDownRight = SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerLookDownLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    rootBundle.load('assets/animated_login_screen.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerIdle);
      setState(() {
        riveArtBoard = artboard;
      });
    });

    checkPassFocusNode();
  }

  void validateEmailAndPassword(){
    Future.delayed(const Duration(seconds: 1),(){
      if(userFound){
        addSuccessController();
      }
      else{
        addFailController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Align(
            child: const Text(
              "نسجيل الدخول",
            ),
          )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.width / 1.7,
                child: (riveArtBoard == null)? const SizedBox.shrink() : Rive(artboard: riveArtBoard!)
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: emailController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "البريد الاكتروني",
                          contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0)
                          ),
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        style: TextStyle(fontSize: 20),
                        //validator: (value) => (value != loginUser())? "Wrong Email" : null,
                        onChanged: (value) {
                          if(value.isNotEmpty && value.length < 14 && !isLookingLeft){
                            addLookDownLeftController();
                          }
                          else if(value.isNotEmpty && value.length > 14 && !isLookingRight){
                            addLookDownRightController();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextFormField(
                        controller: passwordController, obscureText: _passwordInVisible,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "كلمة السر",
                          contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20, 18.0),
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
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                        focusNode: passwordFocusNode,
                        //validator: (value) => (value != testPass)? "Wrong password" : null,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 18,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 8
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 14)
                        ),
                        onPressed: (){
                          passwordFocusNode.unfocus();

                          if(formKey.currentState!.validate()){
                            validateEmailAndPassword();
                            loginUser();
                          }
                        },
                        child: const Text(
                          "تسجيل الدخول",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height:70,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Text("ليس لديك حساب ؟",style: TextStyle(fontSize: 20,color:Colors.blueAccent.shade700),),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                          },
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}