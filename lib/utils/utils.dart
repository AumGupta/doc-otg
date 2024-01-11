import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:docotg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/user.dart';
import 'package:flutter/services.dart' show rootBundle;

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  } else {}
}

pickVideo(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: const Duration(minutes: 10));
  if (_file != null) {
    return _file.path;
  }
}

Future<Uint8List> makePDF(Map report, user user1) async {
  final userProfile = await networkImage(user1.profImageUrl);
  final imageLogo = (await rootBundle.load('assets/images/icon-1024x1024.png'))
      .buffer
      .asUint8List();
  final pdf = pw.Document();
  // var sign_font = await PdfGoogleFonts.homemadeAppleRegular();
  var signFont = await rootBundle.load("assets/fonts/Bastliga-One.ttf");
  final PdfColor primaryColorPDF = PdfColor.fromHex('585BE4');
  // final PdfColor primaryColorPDF = PdfColor.fromHex('ff585be4');
  pdf.addPage(
    pw.Page(
      margin: pw.EdgeInsets.only(top: 36, left: 36, right: 36),
      build: (pw.Context context) => pw.Container(
        child: pw.Column(
          children: [
            pw.Row(
              // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Image(
                  pw.MemoryImage(imageLogo),
                  height: 100,
                  width: 100,
                ),
                pw.SizedBox(width: 50),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'COVID-19',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 36,
                        color: primaryColorPDF,
                      ),
                    ),
                    pw.Text(
                      'Analysis Report',
                      style: pw.TextStyle(
                        // fontWeight: pw.FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(height: 1),
            pw.SizedBox(height: 50),
            pw.Table(
              children: <pw.TableRow>[
                pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Patient Name:',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'Sex:',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'Age:',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'Place of Birth:',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'Phone Number:',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ]),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('${user1.fname} ${user1.lname}'),
                            pw.SizedBox(height: 10),
                            pw.Text(user1.gender),
                            pw.SizedBox(height: 10),
                            pw.Text('${user1.age}'),
                            pw.SizedBox(height: 10),
                            pw.Text(user1.nationality),
                            pw.SizedBox(height: 10),
                            pw.Text(user1.number),
                          ]),
                      pw.Column(children: [
                        pw.Container(
                          height: 100,
                          width: 100,
                          child: pw.Image(
                            userProfile,
                            fit: pw.BoxFit.cover,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'uid: ${user1.uid}',
                          style: const pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.grey500,
                          ),
                        ),
                      ]),
                    ])
              ],
            ),
            pw.SizedBox(height: 50),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: <pw.TableRow>[
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        paddedText('Disease:'),
                        paddedText('Result:'),
                        paddedText('Date:'),
                        paddedText('Time:'),
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        paddedText('COVID-19'),
                        paddedText(
                          '${report['finalResult']}',
                          style: pw.TextStyle(
                              color: (report['finalResult'] == 'Positive')
                                  ? PdfColors.red
                                  : PdfColors.green),
                        ),
                        paddedText('${report['datePublished']}'),
                        paddedText('${report['timePublished']}'),
                      ]),
                ]),
                pw.TableRow(
                  children: [
                    paddedText('Prescription:'),
                    paddedText('${report['prescription']}'),
                  ],
                ),
              ],
            ),
            // pw.Table(
            //   border: pw.TableBorder.all(color: PdfColors.black),
            //   children: <pw.TableRow>[
            //     pw.TableRow(children: [
            //       paddedText('DOC-OTG Model Analysis Results'),
            //     ]),
            //     pw.TableRow(children: [
            //       pw.Column(
            //           crossAxisAlignment: pw.CrossAxisAlignment.start,
            //           children: [
            //             paddedText('Text Analysis Result:'),
            //             paddedText('Image Analysis Result:'),
            //           ]),
            //       pw.Column(
            //           crossAxisAlignment: pw.CrossAxisAlignment.start,
            //           children: [
            //             paddedText('${report['textResult']}'),
            //             paddedText('${report['imageResult']}'),
            //           ]),
            //     ])
            //   ],
            // ),
            pw.SizedBox(height: 10),
            pw.Text('Report ID: ${report['reportId']}'),
            pw.SizedBox(height: 40),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Verified By',
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      report['doctorName']
                          .toString()
                          .replaceAll('Dr. ', '')
                          .replaceAll(' ', ''),
                      style: pw.TextStyle(
                        font: pw.Font.ttf(signFont),
                        color: PdfColors.blue900,
                        fontSize: 36,
                      ),
                    ),
                    pw.Text(
                      '${report['doctorName']}',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Date downloaded:\n${DateTime.now()}',
                      style: const pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.grey500,
                      ),
                    ),
                  ],
                )
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(height: 1),
          ],
        ),
      ),
    ),
  );
  return pdf.save();
}

pw.Widget paddedText(
  final String text, {
  final pw.TextAlign align = pw.TextAlign.left,
  final pw.TextStyle style = const pw.TextStyle(),
}) =>
    pw.Padding(
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        textAlign: align,
        style: style,
      ),
    );

downloadPdf(report, user1) async {
  final Uint8List pdf = await makePDF(report, user1);
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf);
}

sharePdf(report, user1) async {
  final Uint8List pdf = await makePDF(report, user1);
  await Printing.sharePdf(bytes: pdf, filename: 'DOC-OTG-Report.pdf');
}

pickAudio() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
  );

  if (result != null) {
    return await result.files.single.path;
  } else {}
}

launchMyURL(url) async {
  final Uri link = Uri.parse(url);
  if (!await launchUrl(link)) {
    throw Exception('Could not launch $link');
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
      child: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: darkPurple,
        ),
      ),
    ),
    backgroundColor: blueTint,
    showCloseIcon: true,
    closeIconColor: darkPurple,
  ));
}

List<Color> getReportStatusColors(String status) {
  return status == 'Pending'
      ? [primaryColor, blueTint]
      : (status == 'Positive'
          ? [redColor, lightRedColor]
          : [greenColor, lightGreenColor]);
}

IconData getReportStatusIcon(String status) {
  return status == 'Pending'
      ? Icons.access_time_filled_rounded
      : (status == 'Positive' ? Icons.report_rounded : Icons.verified_rounded);
}
