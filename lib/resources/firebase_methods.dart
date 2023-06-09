import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/resources/storage_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/post.dart';
import '../model/report.dart';
import '../model/user.dart';
import '../provider/user_provider.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, String>> getLatestReport(
    String uid,
  ) async {
    QuerySnapshot snap = await _firestore
        .collection("reports")
        .orderBy("datePublished", descending: true)
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    if (snap.size == 0) {
      return {};
    }
    return Report.fromQuerySnap(snap)[0].toReadableReport();
  }

  Future<List<Map>> getReportList(
    String uid,
  ) async {
    QuerySnapshot snap = await _firestore
        .collection("reports")
        .where("uid", isEqualTo: uid)
        .orderBy('datePublished', descending: true)
        .get();
    List<Report> reportList = Report.fromQuerySnap(snap);
    List<Map> readableReportList = [];
    for (Report report in reportList) {
      readableReportList.add(report.toReadableReport());
    }
    return readableReportList;
  }

  // Upload a Report (Analysed Post)
  Future<String> uploadReport(String uid, Map<String, String> symptoms) async {
    String res = "Some Error Occoured";
    String textResult = '';
    var url = Uri.parse('https://docotg.onrender.com/text');
    try {
      var response = await http.post(
        url,
        body: json.encode(symptoms),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        textResult = '$data';
      } else {
        textResult = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      textResult = 'Error: $e';
    }

    try {
      var latestPost = await _firestore
          .collection("users")
          .doc(uid)
          .collection("posts")
          .orderBy("datePublished", descending: true)
          .limit(1)
          .get();
      var post = latestPost.docs.first.data();
      String postId = post["postId"];

      String reportId = const Uuid().v1();
      Report report = Report(
        textResult: textResult,
        reportId: reportId,
        uid: uid,
        postId: postId,
        datePublished: DateTime.now(),
      );
      _firestore.collection("reports").doc(reportId).set(report.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Upload Post
  Future<String> uploadPost(
    Map<String, String> symptoms,
    Uint8List imageFile,
    String uid,
    String name,
    String profImage,
    String audioPath,
    BuildContext context,
    // String textAnalysisResult,
    String otherSymptom,
  ) async {
    String res = "Some Error Occoured";
    final user user1 =
        Provider.of<UserProvider>(context, listen: false).getUser;

    try {
      String imageUrl = '';
      if (imageFile.isNotEmpty) {
        imageUrl = await StorageMethods().uploadImageToStorage(
          'posts',
          imageFile,
          true,
        );
      }
      String audioURL = audioPath.isNotEmpty?await uploadAudioFile(audioPath):'';
      String postId = const Uuid().v1();
      Post post = Post(
          symptoms: symptoms,
          uid: uid,
          name: name,
          postId: postId,
          datePublished: DateTime.now(),
          imageUrl: imageUrl,
          profImage: profImage,
          audio: audioURL,
          otherSymptom: otherSymptom);
      _firestore.collection("posts").doc(postId).set(post.toJson());
      await _firestore
          .collection("users")
          .doc(user1.uid)
          .collection("posts")
          .doc(postId)
          .set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> uploadAudioFile(String filePath) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String fileName = filePath.split('/').last;
    final Reference ref = storage.ref().child('audios/$fileName');
    final UploadTask uploadTask = ref.putFile(File(filePath));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> updateDoctor(String uid, BuildContext context) async {
    String res = "Some Error Occoured";
    final user user1 =
        Provider.of<UserProvider>(context, listen: false).getUser;
    try {
      await _firestore
          .collection("users")
          .doc(user1.uid)
          .update({"DoctorId": uid});
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
