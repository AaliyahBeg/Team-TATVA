import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'bio': '',
      'followers': [],
      'following': [],
      'photourl': ''
    });
  }

  static saveOrganization(String name, email, uid) async {
    await FirebaseFirestore.instance.collection('organizations').doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'mission': '',
      'followers': [],
      'following': [],
      'photourl': ''
    });
  }
}
