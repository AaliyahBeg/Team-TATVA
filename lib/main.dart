import 'package:environment_app/petitions.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/homepage.dart';

void main() {
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