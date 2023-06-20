
import 'package:docotg/resources/auth_methods.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  user? _user = user(
      uid: "uid",
      fname: "fname",
      lname: "lname",
      email: "email",
      gender: "gender",
      nationality: "nationality",
      age: 18,
      number: "number",
      photoUrl: "https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,1,0"
  );

  user get getUser => _user!;

  final AuthMethods _authMethods = AuthMethods();
  Future<void> refreshUser() async {
    user user1 = await _authMethods.getUserDetails();
    _user = user1;
    //print(_user?.name);
    notifyListeners();
  }
}