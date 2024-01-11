import 'package:docotg/utils/constants.dart';
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
    String photourl = user1.profImageUrl;
    return Scaffold(
      backgroundColor: screenBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  // child: CircleAvatar(
                  //   foregroundImage: NetworkImage(photourl),
                  //   backgroundColor: primaryColorLight,
                  //   radius: width*0.5,
                  // ),
                  child: Container(
                    width: width * 0.86,
                    height: height * 0.4,
                    decoration: BoxDecoration(
                      color: blueTint,
                      borderRadius: BorderRadius.circular(25.0),
                      image: DecorationImage(
                        image: NetworkImage(photourl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkPurple),
                ),

                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: blueTint,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          hintText: user1.fname,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          fillColor: blueTint,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          hintText: user1.lname,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Age",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkPurple),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: blueTint,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    hintText: user1.age.toString(),
                  ),
                ),
                // Row(
                //   children: [
                //     GestureDetector(
                //       child: CircleAvatar(
                //         radius: width * 0.06,
                //         backgroundColor: blueTint,
                //         child: Icon(
                //           Icons.remove,
                //           color: primaryColorLight,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 15,
                //     ),
                //     Container(
                //       width: width * 0.29,
                //       height: height * 0.06,
                //       decoration: BoxDecoration(
                //         color: blueTint,
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(15)),
                //       ),
                //       child: Center(
                //           child: Text(
                //         "${user1.age}",
                //         style: TextStyle(
                //             fontSize: 18, color: Colors.grey.shade700),
                //       )),
                //     ),
                //     const SizedBox(
                //       width: 15,
                //     ),
                //     GestureDetector(
                //       child: CircleAvatar(
                //         radius: width * 0.06,
                //         backgroundColor: blueTint,
                //         child: Icon(
                //           Icons.add,
                //           color: primaryColorLight,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Gender",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkPurple),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: blueTint,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    hintText: user1.gender,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Country",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkPurple),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    fillColor: blueTint,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    hintText: user1.nationality,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Phone Number",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkPurple),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    fillColor: blueTint,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    hintText: user1.number,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                // Text('uid: ${user1.uid}'),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
