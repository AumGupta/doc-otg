import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/screens/report_page.dart';
import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';

class UserReportListPage extends StatefulWidget {
  final snap;
  const UserReportListPage({super.key, this.snap});

  @override
  State<UserReportListPage> createState() => _UserReportListPageState();
}

class _UserReportListPageState extends State<UserReportListPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String uid = widget.snap['uid'];
    return Scaffold(
      backgroundColor: screenBgColor,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(width*0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                    radius: width*0.2,
                    backgroundImage: NetworkImage(widget.snap['photoUrl']),
                  ),
              ),
                SizedBox(height: height*0.02,),
              Center(child: Text(widget.snap['fname'].toString().toUpperCase(),style: const TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),),
              SizedBox(height: height*0.02,),
              Text("Reports",style: TextStyle(fontSize: height*0.044,fontWeight: FontWeight.bold),),
              SizedBox(height: height*0.03,),  
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').doc(uid).collection('posts').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if (snapshot.data!.size == 0){
                       return Container(
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
                    Icon(Icons.bug_report,color: greenColor,),
                    SizedBox(width: width*0.01,),
                    Text("No reports to see",style: TextStyle(color: greenColor),)
                  ],
                )));
                      }
                       return Expanded(
                         child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs
                              .length, // Returns the number of documents in the 'posts' collection on Firestore
                          itemBuilder: (context, index) { 
                           
                            return Column(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                                  child: ListTile(
                                    leading: const Icon(Icons.document_scanner),
                                    title:  Text(
                                      'Report ${index+1}',
                                      textScaleFactor: 1.5,
                                    ),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                    // subtitle:  Text(snapshot.data!.docs[index]
                                    //                   .data()['datePublished'].toString()),
                                    selected: true,
                                    onTap: () {
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReportPage(snap: snapshot.data!.docs[index].data(),)));
                                    //                   .data(),)));
                                    },
                                  ),
                                ),
                                SizedBox(height: height*0.02,)
                              ],
                            );}
                    ),
                       );
  
                  },
                ),
            ],
          ),
          
        ),
      ),
    );
  }
}


