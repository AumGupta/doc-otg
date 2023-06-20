import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/model/report.dart';
import 'package:docotg/resources/firebase_methods.dart';
import 'package:docotg/screens/reports_list_screen.dart';
import 'package:docotg/screens/result_screen.dart';
import 'package:docotg/screens/detailed_User_list.dart';
import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final user1 = Provider.of<UserProvider>(context, listen: false).getUser;
    final Future<Map<String, String>> getReport =
        FireStoreMethods().getLatestReport(user1.uid);
    Map<String, String> report = {};

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String photourl = user1.photoUrl;
    var name = user1.fname;
    return Scaffold(
      backgroundColor: screenBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.075),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //Profile
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
                          imageUrl: photourl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(color: screenBgColor),
                          errorWidget: (context, url, error) => Icon(
                            Icons.account_circle,
                            color: screenBgColor,
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
                          "Hi, $name!",
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
                                style:
                                    TextStyle(fontSize: 14, color: greenColor),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest Report",
                      style: TextStyle(
                          fontSize: height * 0.036,
                          fontWeight: FontWeight.bold,
                          color: darkPurple),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ReportsListScreen(uid: user1.uid),
                        ));
                      },
                      child: const Text('See all'),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResultScreen(report: report),
                    ));
                  },

                  // Latest Report Card
                  child: Container(
                      width: double.infinity,
                      height: height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: primaryColor),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.06,
                            width * 0.075, width * 0.06, width * 0.05),
                        child: FutureBuilder<Map<String, String>>(
                            future: getReport,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Disease:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: height * 0.016,
                                            ),
                                            const Text(
                                              "Result:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: height * 0.016,
                                            ),
                                            const Text(
                                              "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.access_time_filled_rounded,
                                              color: primaryColor,
                                            ))
                                      ],
                                    ),
                                    Container(
                                      height: height * 0.05,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: whiteColorTransparent,
                                      ),
                                      child: LinearProgressIndicator(
                                        color: whiteColorTransparent,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    //ReportID
                                    const Text(
                                      " ",
                                      style: TextStyle(fontSize: 9),
                                    ),
                                  ],
                                );
                              }
                              else if (snapshot.hasData) {
                                report = snapshot.data!;
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Disease:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: height * 0.016,
                                            ),
                                            const Text(
                                              "Result:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //Disease
                                            const Text(
                                              "COVID-19",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: height * 0.016,
                                            ),
                                            // result
                                            Text(
                                              report['textResult']!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        // Report Badge
                                        report['textResult'] == 'Positive'
                                            ? CircleAvatar(
                                                radius: 16,
                                                backgroundColor: lightRedColor,
                                                child: Icon(
                                                  Icons.report_rounded,
                                                  color: redColor,
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 16,
                                                backgroundColor:
                                                    lightGreenColor,
                                                child: Icon(
                                                  Icons.verified_rounded,
                                                  color: greenColor,
                                                ),
                                              ),
                                      ],
                                    ),

                                    //Date and Time
                                    Container(
                                      height: height * 0.05,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: whiteColorTransparent),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: whiteColorTransparent,
                                            ),
                                            SizedBox(
                                              width: width * 0.02,
                                            ),
                                            Text(
                                              "${report['datePublished']!} - ${report['timePublished']!}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),

                                    //ReportID
                                    Text(
                                      "ReportID: ${report["reportId"]}",
                                      style: const TextStyle(
                                          fontSize: 9, color: Colors.white),
                                    ),
                                  ],
                                );
                              }
                              else {
                                return const Text('No data');
                              }
                            }),
                      )),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                  "Doctors",
                  style: TextStyle(
                      fontSize: height * 0.036,
                      fontWeight: FontWeight.bold,
                      color: darkPurple),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  height: height * 0.30,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Doctors')
                        .snapshots(),
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
                                      builder: (context) => UserDetailedPage(
                                          snap: snapshot.data!.docs[index]
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
                Text(
                  "Past Reports",
                  style: TextStyle(
                      fontSize: height * 0.036,
                      fontWeight: FontWeight.bold,
                      color: darkPurple),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  height: height * 0.16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: lightGreenColor),
                  child: Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_copy_outlined,
                        color: greenColor,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Text(
                        "No reports to see",
                        style: TextStyle(color: greenColor),
                      )
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
