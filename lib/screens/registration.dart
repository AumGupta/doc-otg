import 'package:docotg/screens/form.dart';
import 'package:docotg/screens/login_screen.dart';
import 'package:docotg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _emailController = TextEditingController();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _isVisible = false;
  bool _isDoctor = false;

  void resetAllTextFields() {
    formKey.currentState?.reset();
    _autoValidate = AutovalidateMode.disabled;
    _emailController.clear();
    _passwordController.clear();
    _passwordController2.clear();
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
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
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.08, vertical: 24.0),
                child: Form(
                  key: formKey,
                  autovalidateMode: _autoValidate,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.045,
                          ),
                          Text(
                            "New user?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.042,
                                color: darkPurple),
                          ),
                          Text(
                            "Let's Sign Up!",
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              color: blueTint,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isDoctor = false;
                                      resetAllTextFields();
                                    });
                                  },
                                  child: Container(
                                    width: width * 0.40,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        color: _isDoctor
                                            ? blueTint
                                            : primaryColor),
                                    child: Center(
                                        child: Text(
                                      "Patient",
                                      style: TextStyle(
                                          color: _isDoctor
                                              ? greyColor
                                              : Colors.white,
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
                                    resetAllTextFields();
                                  }),
                                  child: Container(
                                    width: width * 0.40,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: _isDoctor ? greenColor : blueTint,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Doctor",
                                      style: TextStyle(
                                          color: !_isDoctor
                                              ? greyColor
                                              : Colors.white,
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
                            height: height * 0.02,
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                EmailValidator.validate(value!)
                                    ? null
                                    : "Please enter a valid email",
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                fillColor: blueTint,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: greyColor)),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          TextFormField(
                            obscureText: !_isVisible,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at-least 8 characters long';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                fillColor: blueTint,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: greyColor)),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.68,
                                child: TextFormField(
                                  obscureText: !_isVisible,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _passwordController2,
                                  validator: (value) {
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    fillColor: blueTint,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    hintText: 'Re-enter Password',
                                    hintStyle: TextStyle(color: greyColor),
                                  ),
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
                            height: height * 0.1,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormPage(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            isDoctor: _isDoctor,
                                          )),
                                );
                              } else {
                                setState(() =>
                                    _autoValidate = AutovalidateMode.always);
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0x90585be4), blurRadius: 20),
                                ],
                                borderRadius: BorderRadius.circular(50),
                                color: primaryColor,
                              ),
                              child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign Up  ",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 2),
                                child: Text(
                                  "Already have an account?",
                                  style: TextStyle(color: greyColor),
                                ),
                              ),
                              GestureDetector(
                                onTap: navigateToLogin,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    " Login.",
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
                )),
          )),
    );
  }
}
