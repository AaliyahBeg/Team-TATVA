import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final CollectionReference SavedNewsCollection =
      FirebaseFirestore.instance.collection('SavedNews');
  Future addNewsData(String author, String content, String desc, String img,
      String pubAt, String title, String uid, String url) async {
    return await SavedNewsCollection.doc().set({
      'author': author,
      'content': content,
      'desc': desc,
      'img': img,
      'pubAt': pubAt,
      'title': title,
      'uid': uid,
      'url': url,
    });
  }

  ///future cuz async
  List<Object> getNewsData(String given_uid) {
    List<Object> ans = [];
    SavedNewsCollection.snapshots().listen((snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc['uid'] == given_uid) ans.add(doc);
      });
    });
    return ans;
  }

  ///future cuz async
}
