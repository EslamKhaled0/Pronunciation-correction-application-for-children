import 'package:get/get.dart';

import 'user_preferences.dart';
import '../model/user.dart';

class CurrentUser extends GetxController{
  Rx<User> _currentUser = User(0,'','','').obs;

  User get user => _currentUser.value;
  getUserInfo() async{
    User? getUserInfo = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfo!;
  }
}