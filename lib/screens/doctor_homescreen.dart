import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/screens/reportsPageDoc.dart';
import 'package:docotg/screens/userReportList.dart';
import 'package:docotg/utils/colors.dart';
import 'package:docotg/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DocHomePage extends StatefulWidget {
  const DocHomePage({super.key});

  @override
  State<DocHomePage> createState() => _DocHomePageState();
}

class _DocHomePageState extends State<DocHomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
    backgroundColor: Color(0xFFfafbff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFfafbff),
        actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.black,))
      ]),
      body: Padding(
        padding: EdgeInsets.all(width*0.08),
        child: SingleChildScrollView(  
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                Container(
                  height: width*0.25,
                  width: width*0.25,
                  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          
                                            ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                              imageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                  )
,
      
                ),
                SizedBox(width: width*0.03,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello Doctor!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: lightgreenColor
                                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on,size: 15,),
                            Text("India"),
                            SizedBox(width: 5,)
                          ],
                        ),

                        
                      ),
                    ),
                    
                  ],
                )
              ],
            ),
             SizedBox(height: height*0.015,),
             Text("Welcome back to DOC-OTG",style: TextStyle(color: secondaryTextcolor,fontSize: 15),),
              SizedBox(height: height*0.05,),
              Text("Patient Report",style: TextStyle(fontSize: height*0.044,fontWeight: FontWeight.w500),),
              SizedBox(height: height*0.03,),  
              Container(
                height: height*0.35,
                width: double.infinity,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserReportListPage(snap:snapshot.data!.docs[index]
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
              Text("Past Reports",style: TextStyle(fontSize: height*0.044,fontWeight: FontWeight.w500),),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReportsPAgeDoc()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("See all"),
                    SizedBox(width: 2,),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              SizedBox(height: height*0.03,),  
               Container(
                height: height*0.16,
                width: double.infinity,
                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: lightgreenColor
                                            ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      Text("COVID-19",style: TextStyle(color: darkgreenColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward_sharp,color: darkgreenColor,),
                      Text("Negetive",style: TextStyle(color: darkgreenColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.verified,color: darkgreenColor,),
                      
                    ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                Container(
                          width: width*0.7,
                          height: height*0.062,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffbce6e2)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month,color: darkgreenColor,),

                            Text("   24 june 2022, 07:42 pm ",style: TextStyle(fontSize: 18,color: darkgreenColor),),
                            
                          ]),
                          ),
                          
                  ],
                ),
              ),
          ]),
        ),
      ),
    );
  }
}