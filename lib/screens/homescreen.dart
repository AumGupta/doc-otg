import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/resources/firebase_methods.dart';
import 'package:docotg/screens/reports_list_screen.dart';
import 'package:docotg/screens/result_screen.dart';
import 'package:docotg/screens/detailed_User_list.dart';
import 'package:docotg/utils/constants.dart';
import 'package:docotg/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../provider/user_provider.dart';
import '../widgets/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .refreshUser(false)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading){
      addData();
      isLoading = false;
    }
    final user1 = Provider.of<UserProvider>(context, listen: false).getUser;
    final Future<Map<String, String>> getReport =
        FireStoreMethods().getLatestReport(user1.uid);
    Map<String, String> report = {};

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String profPhotoUrl = user1.profImageUrl;
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
                FutureBuilder<Map<String, String>>(
                    future: getReport,
                    builder: (context, snapshot) {
                      // Loading Shimmer Effect
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: double.infinity,
                          height: height * 0.25,
                          padding: EdgeInsets.fromLTRB(width * 0.06,
                              width * 0.075, width * 0.06, width * 0.05),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: primaryColor),
                          child: Shimmer.fromColors(
                            highlightColor: whiteColorTransparent,
                            baseColor: primaryColorLight,
                            direction: ShimmerDirection.ttb,
                            period: const Duration(milliseconds: 700),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 26,
                                          width: 215,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: primaryColor),
                                        ),
                                        SizedBox(
                                          height: height * 0.016,
                                        ),
                                        Container(
                                          height: 25.5,
                                          width: 190,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: primaryColor),
                                        ),
                                      ],
                                    ),
                                    const CircleAvatar(
                                      radius: 16,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: primaryColorLight),
                                ),
                                Container(
                                  height: 20,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: primaryColor),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      // Loaded Report Card
                      else if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return (Container(
                            width: double.infinity,
                            height: height * 0.25,
                            padding: EdgeInsets.fromLTRB(width * 0.06,
                                width * 0.075, width * 0.06, width * 0.05),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.policy_rounded,
                                  size: 100,
                                  color: primaryColorLight,
                                ),
                                Text(
                                  "No Latest Report",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ));
                        }
                        report = snapshot.data!;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ResultScreen(report: report),
                            ));
                          },
                          child: Container(
                              width: double.infinity,
                              height: height * 0.25,
                              padding: EdgeInsets.fromLTRB(width * 0.06,
                                  width * 0.075, width * 0.06, width * 0.05),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: primaryColor),
                              child: Column(
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
                                            report['finalResult']!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),

                                      // Report Icon
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: getReportStatusColors(
                                            report['finalResult']!)[1],
                                        child: Icon(
                                          getReportStatusIcon(
                                              report['finalResult']!),
                                          color: getReportStatusColors(
                                              report['finalResult']!)[0],
                                        ),
                                      ),
                                    ],
                                  ),

                                  //Date and Time
                                  Container(
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
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
                              )),
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Text('Oops...Something went VERY wrong!');
                      } else {
                        return const Text('Oops...Something went wrong!');
                      }
                    }),
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
                  height: height * 0.21,
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
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            // Returns the number of documents in the 'posts' collection on Firestore
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserDetailedPage(
                                                    snap: snapshot
                                                        .data!.docs[index]
                                                        .data())));
                                  },
                                  child: UserPostCard(
                                      snap: snapshot.data!.docs[index]
                                          .data() // Getting the Post Data from Firebase and Passing it to the "PostCard Widget"
                                      ),
                                ));
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 0,
                          itemBuilder: (context, index) => Container(
                            child: Column(
                              children: [
                                Container(
                                  width: width * 0.440,
                                  height: height * 0.25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: blueTint),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            width: width * 0.4,
                                            height: height * 0.20,
                                            color: screenBgColor,
                                          )),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                      Text(
                                        "Doctor Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: darkPurple),
                                      )
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
