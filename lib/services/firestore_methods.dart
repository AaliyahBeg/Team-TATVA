import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Connect/components/models/post.dart';
import 'package:environment_app/services/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List? file, String uid,
      String username, String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file!, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        supports: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> supportPost(String postId, String uid, List supports) async {
    String res = "Some error occurred";
    try {
      if (supports.contains(uid)) {
        // if the supports list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'supports': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the supports array
        _firestore.collection('posts').doc(postId).update({
          'supports': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> supportPetition(String docId, String uid, List supports) async {
    String res = "Some error occurred";
    try {
      if (supports.contains(uid)) {
        // if the supports list contains the user uid, we need to remove it
        _firestore.collection('Petition').doc(docId).update({
          'support': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the supports array
        _firestore.collection('Petition').doc(docId).update({
          'support': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the supports list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(
    String uid,
    String followId,
    String collection1,
    String collection2
  ) async {
    try {
      DocumentSnapshot snap = await _firestore.collection(collection1).doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if(following.contains(followId)) {
        await _firestore.collection(collection2).doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection(collection1).doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection(collection2).doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection(collection1).doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }

    } catch(e) {
      print(e.toString());
    }
  }
}