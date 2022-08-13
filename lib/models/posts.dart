import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final DateTime datePublished;
  final String username;
  final String postId;
  final String postUrl;
  final String profImage;
  final String uid;
  final likes;

  const Post({
    required this.description,
    required this.datePublished,
    required this.username,
    required this.postId,
    required this.postUrl,
    required this.profImage,
    required this.uid,
    required this.likes,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'description': description,
      'datePublished': datePublished,
      'postId': postId,
      'postUrl': postUrl,
      'profImage': profImage,
      'uid': uid,
      'likes': likes,
    };
  }

  static Future<Post> fromSnap(DocumentSnapshot snap) async {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot['username'],
      description: snapshot['description'],
      datePublished: snapshot['datePublished'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      uid: snapshot['uid'],
      likes: snapshot['likes'],
    );
  }
}
