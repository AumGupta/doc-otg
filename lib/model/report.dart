import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Report {
  final String reportId;
  final String uid;
  final String postId;
  final String textResult;
  final String imageResult;
  final datePublished;
  String? finalResult;
  String? prescription;
  String? doctorName;

  Report(
      {required this.reportId,
      required this.uid,
      required this.postId,
      required this.textResult,
      required this.imageResult,
      required this.datePublished,
      required this.doctorName,
      required this.finalResult,
      required this.prescription});

  Map<String, dynamic> toJson() => {
        'reportId': reportId,
        'uid': uid,
        'postId': postId,
        'textResult': textResult,
        'imageResult': imageResult,
        'datePublished': datePublished,
        'doctorName': doctorName,
        'finalResult': finalResult,
        'prescription': prescription,
      };

  static Report fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Report(
        reportId: snapshot['reportId'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        textResult: snapshot['textResult'],
        imageResult: snapshot['imageResult'],
        datePublished: snapshot['datePublished'],
        doctorName: snapshot['doctorName'],
        finalResult: snapshot['finalResult'],
        prescription: snapshot['prescription']);
  }

  static List<Report> fromQuerySnap(QuerySnapshot snap) {
    List<Report> reportList = [];
    for (int i = 0; i <= snap.size - 1; i++) {
      var snapshot = snap.docs[i].data() as Map<String, dynamic>;
      Report report = Report(
          reportId: snapshot['reportId'],
          uid: snapshot['uid'],
          postId: snapshot['postId'],
          textResult: snapshot['textResult'],
          imageResult: snapshot['imageResult'],
          datePublished: snapshot['datePublished'],
          doctorName: snapshot['doctorName'],
          finalResult: snapshot['finalResult'],
          prescription: snapshot['prescription']);
      reportList.add(report);
    }
    return reportList;
  }

  Map<String, String> toReadableReport() {
    Map<String, String> readableReport = {
      'reportId': reportId,
      'uid': uid,
      'postId': postId,
      'textResult': textResult,
      'imageResult': imageResult,
      'datePublished': DateFormat.yMMMd().format(datePublished.toDate()),
      'doctorName': doctorName!,
      'timePublished': DateFormat.jm().format(datePublished.toDate()),
      'finalResult': finalResult!,
      'prescription': prescription!,
    };
    return readableReport;
  }
}
