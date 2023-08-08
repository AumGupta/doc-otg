import 'package:chips_choice/chips_choice.dart';
import 'package:docotg/resources/firebase_methods.dart';
import 'package:docotg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/utils.dart';

class ReportPage extends StatefulWidget {
  final snap;
  final doctorName;

  const ReportPage({super.key, this.snap, this.doctorName});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _descriptionController = TextEditingController();
  late FocusNode _focusNode;

  late String prescription = '';
  late String validatedResult = '';
  late List colors = [];
  late IconData icon = Icons.access_time_filled_rounded;

  @override
  void initState() {
    _focusNode = FocusNode();
    // Updating priscription
    _focusNode.addListener(() {
      if (_descriptionController.text != prescription &&
          !(_focusNode.hasFocus)) {
        FireStoreMethods().updateReport(
          doctorName: widget.doctorName,
          reportId: widget.snap['reportId'],
          newPrescription: _descriptionController.text,
        );
      }
      setState(() {
        prescription = _descriptionController.text;
      });
    });
    validatedResult = widget.snap['finalResult'];
    colors = getReportStatusColors(validatedResult);
    icon = getReportStatusIcon(validatedResult);
    prescription = widget.snap['prescription'];
    _descriptionController.text = prescription;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var report = widget.snap;
    var post = FireStoreMethods().getPost(report['postId']);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragCancel: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: screenBgColor,
          title: Text(
            "Report",
            style: TextStyle(
                color: darkPurple, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: screenBgColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    contentPadding: const EdgeInsets.all(20),
                    title: const Text(
                      "Validate",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    children: [
                      SimpleDialogOption(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const Text("Negative"),
                        onPressed: () {
                          setState(() {
                            validatedResult = 'Negative';
                            colors = getReportStatusColors(validatedResult);
                            icon = getReportStatusIcon(validatedResult);
                          });
                          FireStoreMethods().updateReport(
                            doctorName: widget.doctorName,
                            reportId: widget.snap['reportId'],
                            newResult: 'Negative',
                            // newPrescription: '',
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                      const Divider(height: 1),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: const Text("Positive"),
                        onPressed: () {
                          setState(() {
                            validatedResult = 'Positive';
                            colors = getReportStatusColors(validatedResult);
                            icon = getReportStatusIcon(validatedResult);
                          });
                          FireStoreMethods().updateReport(
                            doctorName: widget.doctorName,
                            reportId: widget.snap['reportId'],
                            newResult: 'Positive',
                            // newPrescription: '',
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                      const Divider(height: 1),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: const Text("Mark Pending"),
                        onPressed: () {
                          setState(() {
                            validatedResult = 'Pending';
                            colors = getReportStatusColors(validatedResult);
                            icon = getReportStatusIcon(validatedResult);
                          });
                          FireStoreMethods().updateReport(
                            doctorName: widget.doctorName,
                            reportId: widget.snap['reportId'],
                            newResult: 'Pending',
                            // newPrescription: '',
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                      const Divider(height: 1),
                      SimpleDialogOption(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text("Cancel"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
            // Navigator.pop(context);
          },
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          label: Text(
            widget.snap['finalResult'] == 'Pending' ? 'Validate' : 'Revalidate',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          icon: Icon(widget.snap['finalResult'] != 'Pending'
              ? Icons.refresh_rounded
              : Icons.verified_rounded),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.075),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Final Result",
                style: TextStyle(
                    color: darkPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Result Validated by Doctor",
                style: TextStyle(color: greyColor, fontSize: 14),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: colors[1],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "COVID 19",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colors[0],
                          ),
                        ),
                        Icon(
                          Icons.keyboard_tab,
                          color: colors[0],
                          size: 28,
                        ),
                        Text(
                          validatedResult,
                          style: TextStyle(
                              color: colors[0],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          icon,
                          color: colors[0],
                          size: 28,
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                          // border: Border.all(width: 1, color: greyColor),
                          borderRadius: BorderRadius.circular(15),
                          color: screenBgColor,
                        ),
                        child: TextFormField(
                          // textInputAction: TextInputAction.done,
                          focusNode: _focusNode,
                          controller: _descriptionController,
                          cursorColor: colors[0],
                          maxLines: 10,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(
                              color: darkPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixText: '℞   ',
                            prefixStyle: TextStyle(
                              fontFamily: 'Noto',
                              color: colors[0],
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            // contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            hintText: "Prescription (Optional)",
                          ),
                          // onTapOutside: (PointerDownEvent e) {
                          //   if (_descriptionController.text != prescription) {
                          //     FireStoreMethods().updateReport(
                          // doctorName: widget.doctorName,
                          //       reportId: report['reportId'],
                          //       newPrescription: _descriptionController.text,
                          //     );
                          //     FocusManager.instance.primaryFocus?.unfocus();
                          //   }
                          //   setState(() {
                          //     prescription = _descriptionController.text;
                          //   });
                          // },
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                "Analysis Result",
                style: TextStyle(
                    color: darkPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Results Through Machine Learning Models",
                style: TextStyle(color: greyColor, fontSize: 14),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.075),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: primaryColor),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.text_snippet_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Text Analysis',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const Text(
                              'Image Analysis',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              ':',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const Text(
                              ':',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${report['textResult']}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              '${report['imageResult']}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    //Date and Time
                    Container(
                      height: height * 0.04,
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
                              "${DateFormat.yMMMd().format(report['datePublished']!.toDate())} - ${DateFormat.jm().format(report['datePublished']!.toDate())}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ]),
                    ),

                    SizedBox(
                      height: height * 0.02,
                    ),

                    //ReportID
                    Text(
                      "ReportID: ${report["reportId"]}",
                      style: const TextStyle(fontSize: 9, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                "Clinical Inputs",
                style: TextStyle(
                    color: darkPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "All Inputs Submitted by User",
                style: TextStyle(color: greyColor, fontSize: 14),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: post,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: height * 0.1,
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: blueTint),
                      child: LinearProgressIndicator(
                        color: blueTint,
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'An ${snapshot.error} occurred',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data!;
                      List symptomList = [];
                      data['symptoms'].forEach((k, v) {
                        if (v == 'True') {
                          symptomList.add(toBeginningOfSentenceCase(
                              k.toString().replaceAll('_', ' ')));
                        }
                      });
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(width * 0.075),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: blueTint),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Symptoms",
                              style: TextStyle(
                                  color: darkPurple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            ChipsChoice.single(
                              padding: const EdgeInsets.only(bottom: 12),
                              onChanged: (symptomList) {},
                              value: symptomList,
                              wrapped: true,
                              choiceItems: C2Choice.listFrom(
                                source: symptomList,
                                value: (i, v) => v,
                                label: (i, v) => v,
                              ),
                              choiceStyle: C2ChipStyle.outlined(
                                foregroundStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Montserrat',
                                  color: darkPurple,
                                ),
                                color: darkPurple,
                                backgroundOpacity: 1,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            data['otherSymptom'] == 'NA'
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Text(
                                        "Additional Detail",
                                        style: TextStyle(
                                            color: darkPurple,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text(
                                        data['otherSymptom'],
                                        style: TextStyle(
                                            color: darkPurple,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                            data['postUrl'] == ''
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Text(
                                        "Image",
                                        style: TextStyle(
                                            color: darkPurple,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: screenBgColor,
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(data['postUrl']),
                                              fit: BoxFit.cover),
                                        ),
                                        height: height * 0.35,
                                        width: double.infinity,
                                      ),
                                    ],
                                  ),
                            // data['audio'] == ''
                            //     ? const SizedBox()
                            //     :
                          ],
                        ),
                      );
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
