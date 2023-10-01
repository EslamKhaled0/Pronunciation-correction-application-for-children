class API{
  static  const hostConnect = "http://192.168.1.12/flutter_api";
  static  const hostConnectUser = "$hostConnect/user";

  //signup user for now only
  static const signUp = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";
  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const updateName = "$hostConnect/user/updateName.php";
}