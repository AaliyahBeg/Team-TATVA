import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/petition/petitions_1_.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/homepage.dart';
import 'package:environment_app/petition/user_detail_petition.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'homepage',
      routes: {
         'petitions': (context) => const Petitions(),
        'homepage': (context) => const Home(),
      },
    );

    // final databaseReference= FirebaseFirestore.instance;
    
    

  }
}