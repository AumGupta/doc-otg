import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final List<String> description; // Post Description entered by the user
  final String uid; // UID that made the post
  final String name; // Name of the user that made the post
  final String postId; // Unique post ID
  final datePublished; // Date the post was published
//TODO: Add timeline ID
  final String postUrl; //
  final String profImage; //
  String? otherSymptom;

  // TODO: Add A Challenge ID

   Post(
      {required this.description,
      required this.uid,
      required this.name,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.otherSymptom
      });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'name': name,
        'postId': postId,
        'datePublished': datePublished,
        //List of UID's of different people that follow the user
        'postUrl': postUrl,
        //List of the challenges the user has participated in
        'profImage': profImage,
        'otherSymptom' : otherSymptom
        //A List of other users' UIDs that this user follows

      };

  static Post fromSnap(DocumentSnapshot snap) {
    // TODO: If there is any issue with user sign up functions refer to this "User instance" in this function definition
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        uid: snapshot['uid'],
        name: snapshot['name'],
        description: snapshot['description'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['following'],
        otherSymptom: snapshot['otherSymptom']
    );
  }
}
