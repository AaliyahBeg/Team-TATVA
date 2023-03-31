import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Welcome_Screen.dart';
import 'package:environment_app/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  int? duration = 0;
  Splash({Key? key, required this.duration}) : super(key: key);
  String uid = '';
  String collection = 'users';
  setCollection() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (documentSnapshot.data() == null) {
      collection = 'organizations';
    } else
      collection = 'users';
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration!), () {
      //Navigator.pushNamed(context, 'welcomescreen');
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            uid = FirebaseAuth.instance.currentUser!.uid;
            setCollection();
            return Home();
          } else {
            //return Splash(duration: 5);
            return WelcomeScreen();
          }
        },
      );
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/lock.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              'images/birds.png',
            ),
          ]),
          Center(
            child: Text('TATV',
                style: TextStyle(
                  fontSize: 90,
                  fontFamily: 'Inria',
                  fontWeight: FontWeight.bold,
                  color: Colors.white60,
                )),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
