import 'package:environment_app/petitions.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  }
}