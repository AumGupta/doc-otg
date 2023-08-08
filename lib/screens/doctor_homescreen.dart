import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/screens/reports_page_doc.dart';
import 'package:docotg/screens/patient_report_list.dart';
import 'package:docotg/utils/constants.dart';
import 'package:docotg/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';
import '../utils/utils.dart';

class DocHomePage extends StatefulWidget {
  const DocHomePage({super.key});

  @override
  State<DocHomePage> createState() => _DocHomePageState();
}

class _DocHomePageState extends State<DocHomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .refreshUser(true)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      addData();
      isLoading = false;
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final user user1 =
        Provider.of<UserProvider>(context, listen: false).getUser;
    String profPhotoUrl = user1.profImageUrl;
    var name = user1.fname;
    List<Color> colors = getReportStatusColors('Negative');
    return Scaffold(
      backgroundColor: screenBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.075),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                    height: width * 0.18,
                    width: width * 0.18,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: blueTint,
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: profPhotoUrl,
                      placeholder: (context, url) => Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: blueTint,
                        direction: ShimmerDirection.ttb,
                        period: const Duration(milliseconds: 1000),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person_rounded,
                        color: screenBgColor,
                        size: 50,
                      ),
                    )),
                // Greeting
                SizedBox(
                  width: width * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Hi, Dr. $name!",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: darkPurple),
                    ),
                    //location
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: lightGreenColor),
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: greenColor,
                          ),
                          Text(
                            "India",
                            style: TextStyle(fontSize: 14, color: greenColor),
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: height * 0.016,
            ),
            Text(
              "Welcome back to DOC-OTG!",
              style: TextStyle(color: greyColor, fontSize: 14),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              "Patients",
              style: TextStyle(
                  fontSize: height * 0.036,
                  fontWeight: FontWeight.bold,
                  color: darkPurple),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            SizedBox(
              height: height * 0.21,
              width: double.infinity,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      // Returns the number of documents in the 'posts' collection on Firestore
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PatientReportList.PatientReportList(
                                        snap: snapshot.data!.docs[index].data(),
                                        doctorName: "Dr. "+user1.fname+" "+user1.lname,
                                      )));
                            },
                            child: UserPostCard(
                                snap: snapshot.data!.docs[index]
                                    .data() // Getting the Post Data from Firebase and Passing it to the "PostCard Widget"
                                ),
                          ));
                },
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              "Self Reports",
              style: TextStyle(
                  fontSize: height * 0.036,
                  fontWeight: FontWeight.bold,
                  color: darkPurple),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ReportsPAgeDoc()));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("See all"),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 18),
              color: colors[1],
              clipBehavior: Clip.hardEdge,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "COVID 19",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors[0],
                          ),
                        ),
                        Icon(
                          Icons.keyboard_tab,
                          color: colors[0],
                        ),
                        Text(
                          'Negative',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors[0],
                          ),
                        ),
                        Icon(
                          getReportStatusIcon('Negative'),
                          color: colors[0],
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: colors[0].withOpacity(0.1)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: colors[0].withOpacity(0.4),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              "as",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colors[0]),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
