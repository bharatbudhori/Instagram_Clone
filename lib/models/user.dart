import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String bio;
  final String photoUrl;
  final List following;
  final List followers;
  final String uid;

  const User({
    required this.username,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.following,
    required this.followers,
    required this.uid,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'bio': bio,
      'photoUrl': photoUrl,
      'following': following,
      'followers': followers,
      'uid': uid,
    };
  }

  static Future<User> fromSnap(DocumentSnapshot snap) async {
    var snapshot = await snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      following: snapshot['following'],
      followers: snapshot['followers'],
      uid: snapshot['uid'],
    );
  }
}
