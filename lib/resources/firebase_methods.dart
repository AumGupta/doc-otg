import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/post.dart';
import '../model/user.dart';
import '../provider/user_provider.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<String> uploadPost(
    List<String> description,
    Uint8List file,
    String uid,
    String name,
    String profImage,
    
    BuildContext context,
    String otherSymptom,
  ) async {
    String res = "Some Error Occoured";
    final user user1 =
        Provider.of<UserProvider>(context, listen: false).getUser;
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('posts', file, true,);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          name: name,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          otherSymptom: otherSymptom??""
          );
      _firestore.collection("posts").doc(postId).set(post.toJson());
      await _firestore.collection("users").doc(user1.uid).collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> updateDoctor(
    String uid,
    BuildContext context
  ) async {
    String res = "Some Error Occoured";
    final user user1 =
        Provider.of<UserProvider>(context, listen: false).getUser;
    try{
       await _firestore.collection("users").doc(user1.uid).update({"DoctorId": uid});
       res = "success";
    }catch(e){
      res = e.toString();

    }
    return res;

  }

}