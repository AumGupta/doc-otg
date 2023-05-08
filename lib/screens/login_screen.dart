import 'package:docotg/screens/mobile_screen_layout.dart';
import 'package:docotg/screens/registration.dart';
import 'package:docotg/utils/colors.dart';
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
  bool _isDoctor =  false;
  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegistrationPage()));
  }
  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (result == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MobileScreenLayout(_isDoctor)));
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
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:width*0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.1,),
              Text("Hello,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: height*0.045),),
              Text("Let's Login In!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: height*0.045),),
              SizedBox(height: height*0.015,),
              Text("Welcome aboard,Let's get you diagnosed!",style: TextStyle(color: secondaryTextcolor,fontSize: 15),),
              SizedBox(height: height*0.045,),
              Container(
                width: double.infinity,
                
                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)),color: secondaryColor,),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDoctor = false;
                        });
                      },
                      child: Container(
                        width: width*0.42,
                        height: 42,
                       
                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                        color: _isDoctor?secondaryColor:blueColor
                        
                        ),
                        child: Center(child: Text("Patient",style: TextStyle(color:_isDoctor?Colors.black: Colors.white,fontSize: 18),)),
                        
                      ),
                    ),
                     GestureDetector(
                      onTap:() =>  setState(() {
                        _isDoctor = true;
                        
                      }),
                       child: Container(
                        width: width*0.42,
                        height: 42,
                         decoration: BoxDecoration(
                          color: _isDoctor?lightgreenColor: secondaryColor,
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),),
                          child: Center(child: Text("Doctor",style: TextStyle(color:!_isDoctor?Colors.black: darkgreenColor,fontSize: 18),)),
                        
                                         ),
                     )
                  ],
                ),
              ),
              SizedBox(height: height*0.025,),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: secondaryColor,
                ),
                child:  TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Color(0xFFacb1c8))
                  ),
                ),
              ),
               SizedBox(height: height*0.035,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width*0.68,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: secondaryColor,
                    ),
                    child:  TextFormField(
                      controller: _passwordController,
                      obscureText: !_isVisible,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Color(0xFFacb1c8))
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
                                 radius: width*0.065,
                                 backgroundColor: secondaryTextcolor,
                                  child: CircleAvatar(
                                   radius: width*0.09,
                                   backgroundColor: lightgreenColor,
                                   child: _isVisible? Icon(Icons.visibility,color: darkgreenColor,):Icon(Icons.visibility_off,color: darkgreenColor,),
                                  ),
                                ),
                   ),
                ],
              ),
              SizedBox(height: height*0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password?",style: TextStyle(color: secondaryTextcolor,fontSize: 15),),
                ],
              ),
              SizedBox(height: height*0.03,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                      child: const Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: navigateToSignUp,
                      //print("Signup tapped!");
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child:  Text(
                          " Sign up.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.1,),
              GestureDetector(
                onTap: () => logInUser(),
                child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff585ce5)
                      ),
                      child: _isLoading?const Center(child: CircularProgressIndicator(),) :Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const Text("Login  ",style: TextStyle(fontSize: 18,color: Colors.white),),
                        const Icon(Icons.arrow_forward_sharp,color: Colors.white,)
                      ]),
                      ),
              ),
                      SizedBox(height: height*0.05,),
                    Row(
                      children: [
                          Expanded(
                              child: Divider(
                                color: secondaryTextcolor,
                              )
                          ),       
        
                          Text("  or login with  ",style: TextStyle(color: secondaryTextcolor),),        
        
                          Expanded(
                              child: Divider(color: secondaryTextcolor,)
                          ),
                      ]
                  ),
                  SizedBox(height: height*0.02,),
                   Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const Icon(Icons.circle_notifications,color: Colors.black,),
                      const Text("  Login with google  ",style: TextStyle(fontSize: 18,color: Colors.black),),
                     
                    ]),
                    ),
            ]),
          ),
        ),
      ),
    );
  }
}