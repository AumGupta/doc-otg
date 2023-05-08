import 'package:docotg/main.dart';
import 'package:docotg/screens/homescreen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import 'login_screen.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  @override
  Widget build(BuildContext context) {
     var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return EasySplashScreen(
      logo: Image.asset("assets/Logo.png"),
      showLoader: false,
      logoWidth: width*0.3,
      title: Text(
        "Doc-OTG",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,

      // navigator: logicBuilder(),
      navigator: LoginPage(),
      durationInSeconds: 2,
    );
  }
}