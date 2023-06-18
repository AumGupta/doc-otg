import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/screens/result_screen.dart';
import 'package:docotg/screens/detailed_User_list.dart';
import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';
import '../widgets/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    addData();
  }
  addData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
    // await _userProvider.refreshUser();
  }
 
  @override
  Widget build(BuildContext context) {
     final user user1 =
        Provider.of<UserProvider>(context, listen: false).getUser;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String photourl = user1.photoUrl;
    var name = user1.fname;
    return Scaffold(
      backgroundColor: screenBgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: screenBgColor,
        actions: [
        IconButton(onPressed: (){
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext bc) {
              return Container(
                height: height*0.3,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Row(
                        children: [
                          SizedBox(width: width*0.1,),
                          const Icon(Icons.settings),
                          SizedBox(width: width*0.07,),
                          const Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: [
                          SizedBox(width: width*0.1,),
                          const Icon(Icons.info_rounded),
                          SizedBox(width: width*0.07,),
                          const Text("About us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: [
                          SizedBox(width: width*0.1,),
                          const Icon(Icons.support_agent),
                          SizedBox(width: width*0.07,),
                          const Text("Support",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
                        ],
                      ),
                      SizedBox(height: height*0.025,),
                      Row(
                        children: [
                          SizedBox(width: width*0.1,),
                          const Icon(Icons.share),
                          SizedBox(width: width*0.07,),
                          const Text("Share",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
            icon: Icon(Icons.menu_rounded,color: darkPurple,))
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width*0.075),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //Profile
                    Container(
                      height: width*0.18,
                      width: width*0.18,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: blueTint,
                      ),
                      child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: photourl,
                                placeholder: (context, url) => CircularProgressIndicator(color: screenBgColor),
                                errorWidget: (context, url, error) => Icon(Icons.account_circle, color: screenBgColor,),
                              )
                    ),
                    // Greeting
                    SizedBox(width: width*0.03,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Hi, $name!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: darkPurple),),
                        //location
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: lightGreenColor
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,size: 16, color: greenColor,),
                              Text("India", style: TextStyle(fontSize: 14, color: greenColor),),
                              const SizedBox(width: 5,)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                 SizedBox(height: height*0.015,),
                 Text("Welcome back to DOC-OTG!",style: TextStyle(color: secondaryTextColor,fontSize: 14),),
                  SizedBox(height: height*0.05,),
                   Text("Latest Report",style: TextStyle(fontSize: height*0.036,fontWeight: FontWeight.bold, color: darkPurple),),
                  SizedBox(height: height*0.03,),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResultScreen(),));
                    },
                    child: Container(
                      width: double.infinity,
                      height: height*0.25,
                      decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColor
                                                  ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical:width*0.04,horizontal: width*0.04),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Disease:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),),
                                  SizedBox(height: height*0.025,),
                                  const Text("Result:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),),
                                  SizedBox(height: height*0.025,),
                                  const Text("Inputs:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),),

                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 2,),
                                  const Text("COVID-19",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white),),
                                  SizedBox(height: height*0.025,),
                                  const Text("Negative",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white),),
                                  SizedBox(height: height*0.025,),
                                  const Text("- Text",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white),),
                                  const Text("- Image",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white),),

                                ],
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.verified,color: greenColor,),
                              )
                            ],),
                            SizedBox(height: height*0.01,),
                            Container(
                              height: height*0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFF696ce8)
                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                const Icon(Icons.calendar_today_outlined,color: Colors.white,),
                                SizedBox(width: width*0.02,),
                                const Text("20 Jan 2023, 03:18 pm",style: TextStyle(color: Colors.white),)
                              ]),
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: height*0.05,),
                  Text("Doctors",style: TextStyle(fontSize: height*0.036,fontWeight: FontWeight.bold, color: darkPurple),),
                  SizedBox(height: height*0.03,),
                  SizedBox(
                    height: height*0.30,
                    width: double.infinity,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                           return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs
                                .length, // Returns the number of documents in the 'posts' collection on Firestore
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDetailedPage(snap:snapshot.data!.docs[index]
                                      .data())));
                              },
                              child: UserPostCard(
                                  snap: snapshot.data!.docs[index]
                                      .data() // Getting the Post Data from Firebase and Passing it to the "PostCard Widget"
                                  ),
                            ));

                      },
                    ),
                  ),

                   Text("Past Reports",style: TextStyle(fontSize: height*0.036,fontWeight: FontWeight.bold, color: darkPurple),),
                  SizedBox(height: height*0.03,),
                  Container(
                    height: height*0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: lightGreenColor
                                                ),
                    child: Center(child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_copy_outlined,color: greenColor,),
                        SizedBox(width: width*0.01,),
                        Text("No reports to see",style: TextStyle(color: greenColor),)
                      ],
                    )),
                  )

              ],
            ),
          ),
        ),
      ),
    );
  }
}