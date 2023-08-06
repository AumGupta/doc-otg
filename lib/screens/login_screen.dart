import 'package:docotg/screens/mobile_screen_layout.dart';
import 'package:docotg/screens/registration.dart';
import 'package:docotg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isVisible = false;
  bool _isDoctor = false;

  void navigateToSignUp() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const RegistrationPage()));
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (result == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MobileScreenLayout(isDoctor: _isDoctor)));
    } else {
      showSnackBar(result, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragCancel: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: screenBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.08, vertical: 24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.045,
                  ),
                  Text(
                    "Hello,",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.042,
                        color: darkPurple),
                  ),
                  Text(
                    "Let's Sign in!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.042,
                        color: darkPurple),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Text(
                    "Welcome aboard, let's get you diagnosed!",
                    style: TextStyle(color: greyColor, fontSize: 15),
                  ),
                  SizedBox(
                    height: height * 0.045,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: blueTint,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isDoctor = false;
                            });
                          },
                          child: Container(
                            width: width * 0.40,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                color: _isDoctor ? blueTint : primaryColor),
                            child: Center(
                                child: Text(
                              "Patient",
                              style: TextStyle(
                                  color: _isDoctor ? greyColor : Colors.white,
                                  fontSize: 16,
                                  fontWeight: _isDoctor
                                      ? FontWeight.normal
                                      : FontWeight.bold),
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            _isDoctor = true;
                          }),
                          child: Container(
                            width: width * 0.40,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _isDoctor ? greenColor : blueTint,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Center(
                                child: Text(
                              "Doctor",
                              style: TextStyle(
                                  color: !_isDoctor ? greyColor : Colors.white,
                                  fontSize: 16,
                                  fontWeight: !_isDoctor
                                      ? FontWeight.normal
                                      : FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  //Email
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: blueTint,
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Color(0xFFacb1c8))),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  // Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.68,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: blueTint,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          obscureText: !_isVisible,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Color(0xFFacb1c8))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        child: CircleAvatar(
                          radius: width * 0.065,
                          backgroundColor: greyColor,
                          child: CircleAvatar(
                            radius: width * 0.09,
                            backgroundColor: lightGreenColor,
                            child: _isVisible
                                ? Icon(
                                    Icons.visibility,
                                    color: greenColor,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: greenColor,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  // ForgotPassword
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: greyColor, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  //Login Button
                  GestureDetector(
                    onTap: () => logInUser(),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Color(0x90585be4), blurRadius: 20),
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: primaryColor,
                      ),
                      child: _isLoading
                          ? LinearProgressIndicator(
                              color: whiteColorTransparent,
                              backgroundColor: primaryColor,
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                    "Login  ",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_sharp,
                                    color: Colors.white,
                                    size: 20.0,
                                    weight: 100,
                                  )
                                ]),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(children: [
                    Expanded(
                        child: Divider(
                      color: greyColor,
                    )),
                    Text(
                      "  or login with  ",
                      style: TextStyle(color: greyColor),
                    ),
                    Expanded(
                        child: Divider(
                      color: greyColor,
                    )),
                  ]),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, color: greyColor),
                        color: Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Login with Google ",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            size: 20.0,
                            weight: 100,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  // Register Now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 2),
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(color: greyColor),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToSignUp,
                        //print("Signup tapped!");
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            " Register Now.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: greenColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
