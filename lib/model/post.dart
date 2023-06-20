import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final Map<String,String> symptoms; // Post Description entered by the user
  final String uid; // UID that made the post
  final String name; // Name of the user that made the post
  final String postId; // Unique post ID
  final DateTime datePublished; // Date the post was published
  final String postUrl; //
  final String profImage; //
  String? otherSymptom;
  String? audio;

   Post(
      {required this.symptoms,
      required this.uid,
      required this.name,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.audio,
      required this.otherSymptom
      });

  Map<String, dynamic> toJson() => {
        'symptoms': symptoms,
        'uid': uid,
        'name': name,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        'audio': audio,
        'otherSymptom' : otherSymptom
      };

  static Post fromSnap(DocumentSnapshot snap) {
    // TODO: If there is any issue with user sign up functions refer to this "User instance" in this function definition
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        uid: snapshot['uid'],
        name: snapshot['name'],
        symptoms: snapshot['symptoms'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['following'],
        audio: snapshot['audio'],
        otherSymptom: snapshot['otherSymptom']
    );
  }
}
