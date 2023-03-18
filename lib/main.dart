import 'package:environment_app/Air_Pollution/aqi.dart';
import 'package:environment_app/Air_Pollution/aqiGraph.dart';
import 'package:environment_app/Connect/connect.dart';
import 'package:environment_app/petitions.dart';
import 'package:environment_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/homepage.dart';
import 'Welcome_Screen.dart';
import 'components/profile.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String uid = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            uid = FirebaseAuth.instance.currentUser!.uid;
            return Home();
          } else {
            return WelcomeScreen();
          }
        },
      ),
      routes: {
        'petitions': (context) => const Petitions(),
        'homepage': (context) => const Home(),
        'aqiGraph': (context) => const aqiGraph(),
        'connect': (context) => const Connect(),
        'login': (context) => const LoginPage(),
        'signup': (context) => const SignupPage(),
        'aqi': (context) => const aqiStatus(),
        'profile': (context) => Profile(uid: uid, collection: 'users'),
      },
    );
  }
}
