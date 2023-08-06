import 'package:docotg/utils/constants.dart';
import 'package:docotg/utils/texts.dart';
import 'package:docotg/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, String> report;

  const ResultScreen({super.key, required this.report});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final user user1 = Provider.of<UserProvider>(context).getUser;
    String name = '${user1.fname} ${user1.lname}';

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
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.07),
                  child: Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Report Badge
                        Center(
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

                        // Report
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                    "Disease:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                    "Result:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                    "Date:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                    "Time:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                    "COVID-19",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                    widget.report['finalResult']!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                    widget.report['datePublished']!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                    widget.report['timePublished']!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 21,
                                        color: darkPurple),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        widget.report['prescription']! == ''
                            ? const SizedBox()
                            : Text(
                                'Prescription:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    color: darkPurple),
                              ),
                        widget.report['prescription']! == ''
                            ? const SizedBox()
                            : Text(
                                widget.report['prescription']!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 21,
                                    color: darkPurple),
                              ),
                        Text(
                          "ReportID: ${widget.report['reportId']}",
                          style: TextStyle(
                            fontSize: 10,
                            color: darkPurple,
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              // Download And Share Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text('Download'),
                        Icon(Icons.file_download_outlined)
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    child: const Row(
                      children: [Text('Share'), Icon(Icons.share)],
                    ),
                  ),
                  // Container(
                  //   width: width * 0.4,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50),
                  //       border: Border.all(width: 1, color: greyColor),
                  //       color: Colors.white),
                  //   child: Center(
                  //       child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: const [Text("Download"), Icon(Icons.download)],
                  //   )),
                  // ),
                  // Container(
                  //   width: width * 0.4,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50),
                  //       color: const Color(0xff585ce5)),
                  //   child: Center(
                  //       child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: const [
                  //       Text("Share",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //           )),
                  //       Icon(Icons.share)
                  //     ],
                  //   )),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
