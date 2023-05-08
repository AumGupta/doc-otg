
import 'package:docotg/resources/auth_methods.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  user? _user = user(uid: "uid", fname: "fname", lname: "lname", email: "email", gender: "gender", nationality: "nationality", age: 18, number: "number", photoUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.veryicon.com%2Ficons%2Finternet--web%2F55-common-web-icons%2Fperson-4.html&psig=AOvVaw1pVG8cXmDxeFJ-9Z2QCfoS&ust=1674582329650000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCMCMvcCf3vwCFQAAAAAdAAAAABAN");
  user get getUser => _user!;
  final AuthMethods _authMethods = AuthMethods();

  Future<void> refreshUser() async {
    user user1 = await _authMethods.getUserDetails();
    _user = user1;
    //print(_user?.name);
    notifyListeners();
  }
}