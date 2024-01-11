import 'package:docotg/utils/constants.dart';
import 'package:docotg/utils/texts.dart';
import 'package:docotg/utils/utils.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, String> report;
  final user user1;

  const ResultScreen({super.key, required this.report, required this.user1});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: screenBgColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.clear_rounded,
                color: darkPurple,
              )),
        ],
      ),
      backgroundColor: screenBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textHeader("Report"),
              SizedBox(
                height: height * 0.015,
              ),
              textSubTitle("Post analysis Report"),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: blueTint,
                  border: Border.all(width: 1, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Report Badge
                      Padding(
                        padding: EdgeInsets.only(top: width * 0.07),
                        child: Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: getReportStatusColors(
                                widget.report['finalResult']!)[1],
                            child: Icon(
                              getReportStatusIcon(
                                  widget.report['finalResult']!),
                              color: getReportStatusColors(
                                  widget.report['finalResult']!)[0],
                              size: 86,
                            ),
                          ),
                        ),
                      ),

                      // Report
                      Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.07, left: width * 0.07),
                        child: Table(
                          children: [
                            TableRow(children: [
                              Text(
                                "Name:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    color: darkPurple),
                              ),
                              Text(
                                '${widget.user1.fname} ${widget.user1.lname}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 21,
                                    color: darkPurple),
                              ),
                            ]),
                            TableRow(
                              children: [
                                Text(
                                  "Disease:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21,
                                      color: darkPurple),
                                ),
                                Text(
                                  "COVID-19",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 21,
                                      color: darkPurple),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  "Result:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21,
                                      color: darkPurple),
                                ),
                                Text(
                                  widget.report['finalResult']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 21,
                                      color: darkPurple),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  "Date:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21,
                                      color: darkPurple),
                                ),
                                Text(
                                  widget.report['datePublished']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 21,
                                      color: darkPurple),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  "Time:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21,
                                      color: darkPurple),
                                ),
                                Text(
                                  widget.report['timePublished']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 21,
                                      color: darkPurple),
                                ),
                              ],
                            ),
                            // widget.report['prescription']! == ''
                            //     ? const TableRow(children:[
                            //       SizedBox(),
                            //       SizedBox(),
                            // ])
                            //     : TableRow(
                            //   children: [
                            //     Text(
                            //       'Prescription:',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 21,
                            //           color: darkPurple),
                            //     ),
                            //     Text(
                            //       widget.report['prescription']!,
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.w500,
                            //           fontSize: 21,
                            //           color: darkPurple),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      widget.report['prescription']! == ''
                          ? const SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prescription:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  Text(
                                    widget.report['prescription']!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                ],
                              ),
                            ),
                      widget.report['doctorName']! == ''
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.07),
                                child: Text(
                                  "ReportID: ${widget.report['reportId']}",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: darkPurple,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(4),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: Colors.transparent),
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25)),
                              ),
                              padding: EdgeInsets.all(width * 0.07),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Validated By',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: darkPurple),
                                      ),
                                      Text(
                                        widget.report["doctorName"].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21,
                                            color: darkPurple),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "ReportID: ${widget.report['reportId']}",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: darkPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.verified,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                    ]),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              // Download And Share Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      await downloadPdf(widget.report, widget.user1);
                    },
                    child: const Row(
                      children: [
                        Text('Download'),
                        Icon(Icons.file_download_outlined)
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await sharePdf(widget.report, widget.user1);
                    },
                    child: const Row(
                      children: [Text('Share'), Icon(Icons.share)],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
