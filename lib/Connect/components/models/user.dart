import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photourl;
  final String name;
  final String? bio;
  final String? mission;
  final List followers;
  final List following;
  // final int followers;
  // final int following;
  const User(
      {required this.name,
      required this.uid,
      required this.photourl,
      required this.email,
      this.bio,
      this.mission,
      required this.followers,
      required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photourl: snapshot["photourl"],
      bio: snapshot["bio"] ?? '',
      mission: snapshot["mission"] ?? '',
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "email": email,
        "photourl": photourl,
        "bio": bio,
        "mission": mission,
        "followers": followers,
        "following": following,
      };
}
