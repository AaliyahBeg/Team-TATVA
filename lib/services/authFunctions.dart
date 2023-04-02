import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/services/firebaseFunctions.dart';
import 'package:environment_app/Connect/components/models/user.dart' as model;

late String uid;

class AuthServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      uid = _auth.currentUser!.uid;
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.updateEmail(email);
      await FirestoreServices.saveUser(name, email, userCredential.user!.uid);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static signupOrganization(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      uid = _auth.currentUser!.uid;
      // await DatabaseServices(uid: _auth.currentUser!.uid)
      //     .updateUserData('', '', '', '', '', '', '');
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.updateEmail(email);
      await FirestoreServices.saveOrganization(
          name, email, userCredential.user!.uid);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static Future<bool> signinUser(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged in')));
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
      }
    }
    return false;
  }

  static signOut() async {
    await _auth.signOut();
  }

  Future<model.User> getUserDetails() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    if (documentSnapshot.data() == null) {
      print("Getting data from organizations.....");
      documentSnapshot = await _firestore
          .collection('organizations')
          .doc(_auth.currentUser!.uid)
          .get();
    }
    if (documentSnapshot.data() == null) {
      print("Didn't get data from organizations.....");
    }

    return model.User.fromSnap(documentSnapshot);
  }
}
