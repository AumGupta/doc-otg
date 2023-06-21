import 'package:docotg/utils/colors.dart';
import 'package:docotg/utils/texts.dart';
import 'package:flutter/material.dart';

import '../resources/firebase_methods.dart';
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
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          height: double.maxFinite,
          width: double.maxFinite,
          child: FutureBuilder<List<Map>>(
            future: getReportList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator(
                  color: whiteColorTransparent,
                );
              } else if (snapshot.hasData) {
                try {
                  reportList = snapshot.data!;
                  return (ListView.separated(
                    itemCount: reportList.length - 1,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 14,
                      );
                    },
                    itemBuilder: (context, index) {
                      List<Color> colors = getReportStatusColors(
                          reportList[index]['textResult']);
                      return Card(
                        color: colors[1],
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                ],
                              ),
                              Container(
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: whiteColorTransparent),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        color: whiteColorTransparent,
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
                  print(error);
                  return const Center(
                      child: Text(
                          "Oops... Something went wrong! Please try again!"));
                }
              } else if (snapshot.hasError) {
                print(snapshot.error);
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
