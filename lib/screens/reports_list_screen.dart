import 'package:docotg/utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/firebase_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class ReportsListScreen extends StatefulWidget {
  final String uid;

  const ReportsListScreen({super.key, required this.uid});

  @override
  State<ReportsListScreen> createState() => _ReportsListScreenState();
}

class _ReportsListScreenState extends State<ReportsListScreen> {
  List<Map> reportList = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final Future<List<Map>> getReportList =
        FireStoreMethods().getReportList(widget.uid);
    return Scaffold(
        appBar: AppBar(
          title: textHeader('All Reports'),
          centerTitle: true,
          scrolledUnderElevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.075),
          height: double.maxFinite,
          width: double.maxFinite,
          child: FutureBuilder<List<Map>>(
            future: getReportList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey.shade300,
                    period: const Duration(milliseconds: 900),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 18),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Container(
                            height: height * 0.152,
                          ),
                        );
                      },
                    ));
              } else if (snapshot.hasData) {
                try {
                  reportList = snapshot.data!;
                  if (reportList.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.policy_rounded,
                          size: width * 0.5,
                          color: blueTint,
                        ),
                        SizedBox(height: height*0.05,),
                        Text(
                          "No Reports To Show",
                          style: TextStyle(
                              color: darkPurple, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }
                  return (ListView.builder(
                    itemCount: reportList.length,
                    itemBuilder: (context, index) {
                      List<Color> colors = getReportStatusColors(
                          reportList[index]['textResult']);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 18),
                        color: colors[1],
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(16, height * 0.03, 16, 16),
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
                                      fontWeight: FontWeight.w600,
                                      color: colors[0],
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_tab,
                                    color: colors[0],
                                  ),
                                  Text(
                                    reportList[index]['textResult'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colors[0],
                                    ),
                                  ),
                                  Icon(
                                    getReportStatusIcon(
                                        reportList[index]['textResult']),
                                    color: colors[0],
                                    size: 30,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                height: height * 0.05,
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
                                        "${reportList[index]['datePublished']!} - ${reportList[index]['timePublished']!}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: colors[0]),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
                } catch (error) {
                  return const Center(
                      child: Text(
                          "Oops... Something went wrong! Please try again!"));
                }
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text("Oops... Something went wrong!"));
              } else {
                return const Center(
                    child: Text("Oops... Something went wrong!"));
              }
            },
          ),
        ));
  }
}
