import 'package:docotg/screens/login_screen.dart';
import 'package:docotg/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    final user user1 =
        Provider.of<UserProvider>(context, listen: false).getUser;
     var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String photourl = user1.photoUrl;
    var name = user1.fname;
    return Scaffold(
      appBar: AppBar(elevation: 0,title: Text("Profile Page",style: TextStyle(color: darkgreenColor,fontSize: 18,fontWeight: FontWeight.w500)),centerTitle: true,backgroundColor: lightgreenColor,),
      backgroundColor: bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(width*0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: width*0.8,
                    height: height*0.35,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage(photourl),
                          fit: BoxFit.cover,
                        ),
                        ),
                        // child: ClipRRect(
                        //   borderRadius: BorderRadius.circular(10.0),
                        //   child: Image.network(photourl,width: double.infinity,height: height*0.2,),
                        // ),
                  ),
                )     ,
                SizedBox(height: height*0.08,),
                  Text("Name",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                  SizedBox(height: height*0.02,),
                  Row(
                    children: [
                      Expanded(child: TextFormField(
                        readOnly: true,
                       
                        
                        decoration:  InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                      
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: user1.fname.toUpperCase(),
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      ))),
                     const SizedBox(width: 9,),
                      Expanded(child: TextFormField(
                        
                         
                        decoration:  InputDecoration(
                       border: const OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                       fillColor: Colors.white,
                        filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: user1.lname.toUpperCase(),
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      )))
                    ],
                  ),
                   SizedBox(height: height*0.02,),
                  const Text("Age",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                  SizedBox(height: height*0.01,),
                  Row(
                    children: [
                      GestureDetector(
                      
                        child: CircleAvatar(
                          radius: width*0.06,
                          backgroundColor: lightgreenColor,
                          child: Icon(Icons.remove,color: darkgreenColor,),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        width: width*0.29,
                        height: height*0.06,
                        child: Center(child: Text("${user1.age}")),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      ),
                      SizedBox(width: 15,),
                       GestureDetector(
                       
                         child: CircleAvatar(
                          radius: width*0.06,
                          backgroundColor: lightgreenColor,
                          child: Icon(Icons.add,color: darkgreenColor,),
                                             ),
                       ),
                    ],
                  ),
                   SizedBox(height: height*0.02,),
                  Text("Gender",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                  SizedBox(height: height*0.01,),
                   Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                            border: Border.all(width: 0, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        readOnly: true,
                       
                        
                        decoration:  InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                      
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: user1.gender,
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      ))
                      ),
                        SizedBox(height: height*0.02,),
                  Text("Nationality",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                  SizedBox(height: height*0.01,),
                  TextFormField(
                   readOnly: true,
                        decoration:  InputDecoration(
                       border: OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                       fillColor: Colors.white,
                        filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: user1.nationality,
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      )),
                       SizedBox(height: height*0.02,),
                  Text("Phone Number",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                  SizedBox(height: height*0.01,),
                  TextFormField(
                   
                    readOnly: true,
                        decoration:  InputDecoration(
                       border: const OutlineInputBorder(
                        borderSide: BorderSide(
              width: 3, color: Colors.greenAccent),
                      ),
                       fillColor: Colors.white,
                        filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      hintText: user1.number,
                      hintStyle: TextStyle(color: Color(0xFFacb1c8))
                      )),

                      SizedBox(height: height*0.05,),
                      Center(child: SignoutButton())
                    


              ],
            ),
          ),
        ),)
    );
  }
}

class SignoutButton extends StatelessWidget {
  const SignoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: lightgreenColor,
                              ),
                              onPressed: () async {
                                Future<void> logout(
                                    BuildContext context) async {
                                  await FirebaseAuth.instance.signOut();

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                }

                               
                            

                                logout(context);
                              },
                              child:  Text("Sign out",style: TextStyle(color: darkgreenColor,fontSize: 18,fontWeight: FontWeight.w500)));
  }
}