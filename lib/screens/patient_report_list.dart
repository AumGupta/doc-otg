import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/screens/report_page.dart';
import 'package:docotg/utils/constants.dart';
import 'package:docotg/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/texts.dart';

class PatientReportList extends StatefulWidget {
  final snap;

  const PatientReportList.PatientReportList({super.key, this.snap});

  @override
  State<PatientReportList> createState() => _PatientReportListState();
}

class _PatientReportListState extends State<PatientReportList> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String uid = widget.snap['uid'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: screenBgColor,
        title: textHeader('All Reports'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: screenBgColor,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(width * 0.07, width * 0.07, width * 0.07, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.075),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${widget.snap['fname']} ${widget.snap['lname']}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          'Gender: ${widget.snap['gender']}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          'Age: ${widget.snap['age']}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Container(
                        height: width * 0.21,
                        width: width * 0.21,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: blueTint,
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.snap['photoUrl'],
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
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("reports")
                    .where("uid", isEqualTo: uid)
                    .orderBy('datePublished', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.size == 0) {
                    return Container(
                        height: height * 0.15,
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
                              Icons.bug_report,
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
                        )));
                  }
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        // Returns the number of documents in the 'posts' collection on Firestore
                        itemBuilder: (context, index) {
                          List colors = getReportStatusColors(snapshot
                              .data!.docs[index]
                              .data()['finalResult']!);
                          IconData icon = getReportStatusIcon(snapshot
                              .data!.docs[index]
                              .data()['finalResult']!);
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReportPage(
                                        snap: snapshot.data!.docs[index].data(),
                                      )));
                            },
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 18),
                              color: colors[1],
                              clipBehavior: Clip.hardEdge,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 25, 16, 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "COVID 19",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: colors[0],
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_tab,
                                          color: colors[0],
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]
                                              .data()['finalResult']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: colors[0],
                                          ),
                                        ),
                                        Icon(
                                          icon,
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
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: snapshot.data!.docs[index]
                                                      .data()['finalResult']! ==
                                                  'Pending'
                                              ? primaryColor
                                              : colors[0].withOpacity(0.1)),
                                      child: snapshot.data!.docs[index]
                                                  .data()['finalResult']! ==
                                              'Pending'
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                  const Text(
                                                    "Validate",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.02,
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward_rounded,
                                                    color: Colors.white,
                                                  ),
                                                ])
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                  Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: colors[0]
                                                        .withOpacity(0.4),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.02,
                                                  ),
                                                  Text(
                                                    "${DateFormat.yMMMd().format(snapshot.data!.docs[index].data()['datePublished']!.toDate())} - ${DateFormat.jm().format(snapshot.data!.docs[index].data()['datePublished']!.toDate())}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colors[0]),
                                                  )
                                                ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
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
