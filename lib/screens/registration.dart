import 'package:docotg/screens/form.dart';
import 'package:docotg/screens/login_screen.dart';
import 'package:docotg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final reEnteredPasswordController = TextEditingController();
  bool _isVisible = false;
  bool _isDoctor = false;

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: screenBgColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.12,
                        ),
                        Text(
                          "New User?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height * 0.045),
                        ),
                        Text(
                          "Let's Sign Up!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height * 0.045),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          "Welcome aboard,Let's get you diagnosed!",
                          style: TextStyle(color: greyColor, fontSize: 15),
                        ),
                        SizedBox(
                          height: height * 0.045,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: blueTint,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isDoctor = false;
                                  });
                                },
                                child: Container(
                                  width: width * 0.42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      color:
                                          _isDoctor ? blueTint : primaryColor),
                                  child: Center(
                                      child: Text(
                                    "Patient",
                                    style: TextStyle(
                                        color: _isDoctor
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 18),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(() {
                                  _isDoctor = true;
                                }),
                                child: Container(
                                  width: width * 0.42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color:
                                        _isDoctor ? lightGreenColor : blueTint,
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Doctor",
                                    style: TextStyle(
                                        color: !_isDoctor
                                            ? Colors.black
                                            : greenColor,
                                        fontSize: 18),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: blueTint,
                          ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Color(0xFFacb1c8))),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.035,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: blueTint,
                          ),
                          child: TextFormField(
                            obscureText: !_isVisible,
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Color(0xFFacb1c8))),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.035,
                        ),
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
                                obscureText: !_isVisible,
                                validator: (value) {
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    hintText: 'Re enter Password',
                                    hintStyle:
                                        TextStyle(color: Color(0xFFacb1c8))),
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
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 2),
                              child: const Text("Already have an account?"),
                            ),
                            GestureDetector(
                              onTap: navigateToLogin,
                              //print("Signup tapped!");
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  " Login.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormPage(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          isDoctor: _isDoctor,
                                        )),
                              );
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff585ce5)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Sign Up  ",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_sharp,
                                    color: Colors.white,
                                  )
                                ]),
                          ),
                        ),
                      ]),
                ),
              )),
        )));
  }
}
