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
}
