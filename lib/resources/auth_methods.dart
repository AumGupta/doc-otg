import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docotg/model/user.dart';
import 'package:docotg/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<user> getUserDetails() async {
    User currentuser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentuser.uid).get();

    return user.fromSnap(snap);
  }

  Future<user> getDocDetails() async {
    User currentuser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('Doctors').doc(currentuser.uid).get();

    return user.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String fname,
    required String lname,
    required int age,
    required String email,
    required String password,
    required String gender,
    required String nationality,
    required String number,
    required Uint8List file

    }) async {
      String result = "Some Error Occured";
      try{
        if(fname.isNotEmpty || email.isNotEmpty&&password.isNotEmpty){
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          print(userCredential.user!.uid);
           String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

          user user1 = user(
           uid: userCredential.user!.uid,
           fname: fname,
           lname: lname,
           email: email,
           nationality: nationality,
           photoUrl: photoUrl,
           number: number,
           age: age,
           gender: gender
          );
          await _firestore.collection('users').doc(userCredential.user!.uid).set(
              user1.toJson(),
            );
             result = "success";
        }

      }
      on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        result = "You have entered an invalid email.";
      } else if (e.code == "email-already-in-use") {
        result = "This email is already in use by another account.";
      } else if (e.code == "operation-not-allowed") {
        result =
            "Your account has been suspended. Kindly contact support for more information";
      } else if (e.code == "weak-password") {
        result = "Your password should be at least 6 characters long.";
      } else {
        result = "Aw Snap! An unknown error occurred.";
      }
    } catch (err) {
      result = err.toString();
    }
      return result;
    }

     Future<String> signUpDoc({
    required String fname,
    required String lname,
    required int age,
    required String email,
    required String password,
    required String gender,
    required String nationality,
    required String number,
    required Uint8List file

    }) async {
      String result = "Some Error Occured";
      try{
        if(fname.isNotEmpty || email.isNotEmpty&&password.isNotEmpty){
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          print(userCredential.user!.uid);
           String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

          user user1 = user(
           uid: userCredential.user!.uid,
           fname: fname,
           lname: lname,
           email: email,
           nationality: nationality,
           photoUrl: photoUrl,
           number: number,
           age: age,
           gender: gender
          );
          await _firestore.collection('Doctors').doc(userCredential.user!.uid).set(
              user1.toJson(),
            );
             result = "success";
        }

      }
      on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        result = "You have entered an invalid email.";
      } else if (e.code == "email-already-in-use") {
        result = "This email is already in use by another account.";
      } else if (e.code == "operation-not-allowed") {
        result =
            "Your account has been suspended. Kindly contact support for more information";
      } else if (e.code == "weak-password") {
        result = "Your password should be at least 6 characters long.";
      } else {
        result = "Aw Snap! An unknown error occurred.";
      }
    } catch (err) {
      result = err.toString();
    }
      return result;
    }

    // logging in User

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = "Some error occoured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //log in the user
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = "success";
      } else {
        result = "Please fill up all fields.";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email" || e.code == "wrong-password") {
        result = "You have entered an invalid email/password";
      } else if (e.code == "user-disabled") {
        result =
            "This account has been disabled. Kindly contact support for more information.";
      } else if (e.code == "user-not-found") {
        result =
            "This user does not exist. Kindly Sign Up to create an account.";
      } else {
        result = "Aw Snap! An unknown error occurred.";
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

}