import 'package:docotg/resources/auth_methods.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  user? _user = user(
      uid: "uid",
      fname: "User",
      lname: "lname",
      email: "email",
      gender: "gender",
      nationality: "nationality",
      age: 18,
      number: "number",
      profImageUrl:
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");

  user get getUser => _user!;

  final AuthMethods _authMethods = AuthMethods();
  Future<void> refreshUser(bool _isDoctor) async {
    // user user1 = await _authMethods.getUserDetails();
    // _user = user1;
    _user = await _authMethods.getUserDetails(_isDoctor);
    print({_user});
    print("user:$_user");
    notifyListeners();
  }

  void setUser(user User) {
    _user = User;
    notifyListeners();
  }
}
