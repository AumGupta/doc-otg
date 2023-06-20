import 'package:docotg/utils/colors.dart';
import 'package:docotg/utils/texts.dart';
import 'package:flutter/material.dart';

import '../resources/firebase_methods.dart';

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
    final Future<List<Map>> getReportList =
        FireStoreMethods().getReportList(widget.uid);
    return Scaffold(
        appBar: AppBar(
          title: textHeader('All Reports'),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                reportList = snapshot.data!;
                return ListView.builder(
                  itemCount: reportList.length - 1,
                  itemBuilder: (context, index) {
                    return Card(
                      color: primaryColor,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(50,16, 100,16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Result:'),
                                Text('Date:'),
                              ],
                            ),Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(reportList[index]['textResult']),
                                Text(reportList[index]['datePublished']),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
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
