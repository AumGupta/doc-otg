import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Report {
  final String reportId;
  final String uid;
  final String postId;
  final String textResult;
  final datePublished;

  Report({
    required this.reportId,
    required this.uid,
    required this.postId,
    required this.textResult,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        'reportId': reportId,
        'uid': uid,
        'postId': postId,
        'textResult': textResult,
        'datePublished': datePublished,
      };

  static Report fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Report(
      reportId: snapshot['reportId'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      textResult: snapshot['textResult'],
      datePublished: snapshot['datePublished'],
    );
  }

  static List<Report> fromQuerySnap(QuerySnapshot snap) {
    List<Report> reportList = [];
    for (int i = 0; i <= snap.size-1; i++) {
      var snapshot = snap.docs[i].data() as Map<String, dynamic>;
      Report report = Report(
        reportId: snapshot['reportId'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        textResult: snapshot['textResult'],
        datePublished: snapshot['datePublished'],
      );
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
      'datePublished': DateFormat.yMMMd().format(datePublished.toDate()),
      'timePublished': DateFormat.jm().format(datePublished.toDate()),
    };
    return readableReport;
  }
}
