import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  final String uid;
  final String fname;
  final String lname;
  final String email;
  final String gender;
  final String nationality;
  final int age;
  final String number;
  final String profImageUrl;

  user({required this.uid,
   required this.fname,
   required this.lname,
    required this.email,
    required  this.gender,
     required  this.nationality,
     required   this.age,
      required   this.number,
       required   this.profImageUrl});

  Map<String,dynamic> toJson() => {
    'fname':fname,
    'lname':lname,
    'uid':uid,
    'email':email,
    'gender':gender,
    'nationality':nationality,
    'age':age,
    'number':number,
    'photoUrl':profImageUrl

  };
  static user fromSnap(DocumentSnapshot snap) {
    // TODO: If there is any issue with user sign up functions refer to this "User instance" in this function definition
    var snapshot = snap.data() as Map<String, dynamic>;
    return user(
     uid: snapshot['uid'],
     fname:  snapshot['fname'],
     lname:   snapshot['lname'],
      email:   snapshot['email'],
      gender:    snapshot['gender'],
      nationality:    snapshot['nationality'],
      age:snapshot['age'],
           number: snapshot['number'],
          profImageUrl:   snapshot['photoUrl']);
  }
}