import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final Map<String, String> symptoms; // Post Description entered by the user
  final String uid; // UID that made the post
  final String name; // Name of the user that made the post
  final String postId; // Unique post ID
  final DateTime datePublished; // Date the post was published
  final String imageUrl; //
  final String profImage;
  String? finalResult;
  String? otherSymptom;
  String? audio;
  String? video;

  Post(
      {required this.symptoms,
      required this.uid,
      required this.name,
      required this.postId,
      required this.datePublished,
      required this.imageUrl,
      required this.profImage,
      required this.audio,
      required this.video,
      required this.otherSymptom,
      required this.finalResult});

  Map<String, dynamic> toJson() => {
        'symptoms': symptoms,
        'uid': uid,
        'name': name,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': imageUrl,
        'profImage': profImage,
        'audio': audio,
        'video': video,
        'otherSymptom': otherSymptom,
        'finalResult': finalResult
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
      imageUrl: snapshot['postUrl'],
      profImage: snapshot['following'],
      audio: snapshot['audio'],
      video: snapshot['video'],
      otherSymptom: snapshot['otherSymptom'],
      finalResult: snapshot['finalResult'],
    );
  }
}
