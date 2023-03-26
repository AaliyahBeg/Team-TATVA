import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Air_Pollution/aqi.dart';
import 'package:environment_app/Air_Pollution/aqiGraph.dart';
import 'package:environment_app/Connect/connect.dart';
import 'package:environment_app/Connect/feed_screen.dart';

import 'package:environment_app/News/news_home.dart';
import 'package:environment_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Land_Pollution/models/product_model.dart';
import 'package:environment_app/petition/petitions_1_.dart';

import 'package:environment_app/Welcome_Screen.dart';
import 'package:environment_app/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart'; // state management
// import 'package:google_sign_in/google_sign_in.dart';

import 'Connect/components/providers/user_provider.dart';
import 'components/profile.dart';

import 'package:environment_app/News/datenews.dart';
import 'package:environment_app/News/headlines.dart';
import 'package:environment_app/News/localnews.dart';
import 'package:environment_app/News/savednews.dart';
import 'package:environment_app/News/newscontent.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: 'homepage',
//       routes: {
//         'petitions': (context) => const Petitions(),
//         'homepage': (context) => const Home(),
//       },
//     );
//   }
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('production');
  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.phone.request();
  await Permission.activityRecognition.request();
  await Permission.location.request();
  await Permission.sms.request();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String uid = '';
  String collection='users';

  setCollection() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (documentSnapshot.data() == null) {
      collection = 'organizations';
    }
    else collection = 'users';
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tatv',
        home: StreamBuilder(
          //This code is using the Flutter StreamBuilder widget
          // to determine the UI to display. It listens to the stream of authentication
          // state changes from FirebaseAuth. If the snapshot of the stream has data,
          // it returns a Home widget, otherwise it returns a WelcomeScreen widget.
          // This is likely used to determine if the user is logged in or not.
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              uid = FirebaseAuth.instance.currentUser!.uid;
              setCollection();
              return Home();
            } else {
              return WelcomeScreen();
            }
          },
        ),
      routes: {
        'petitions': (context) => const Petitions(),
        'news': (context) => News_home(),
        'homepage': (context) => const Home(),
        'login': (context) => const LoginPage(),
        'signup': (context) => const SignupPage(),
        'aqiGraph': (context) => const aqiGraph(),
        'connect': (context) => Connect(collection: collection,),
        'aqi': (context) => const aqiStatus(),
        'profile': (context) => Profile(uid: uid, collection: collection),
        'news_page1': (context) => const headlines(),
        'news_page2': (context) => const localnews(),
        'news_page3': (context) => const datenews(),
        'saved_news': (context) => const savednews(),
      },
    ));
  }
}


// class GoogleSignInProvider {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//     ],
//   );
//
//   Future<GoogleSignInAccount?> signInWithGoogle() async {
//     try {
//       await _googleSignIn.signIn();
//       return _googleSignIn.currentUser;
//     } catch (error) {
//       print(error);
//       return null;
//     }
//   }
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//     create: (context) => GoogleSignInProvider(),
//     child: GetMaterialApp(
//       title: 'Tatv',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         // TODO: change the color schemes
//         primarySwatch: Colors.grey,
//         scaffoldBackgroundColor: const Color(0xFFffffff),
//         fontFamily: 'Montserrat',
//       ),
//       initialRoute: '/',
//       routes: <String, WidgetBuilder>{
//         '/': (context) => const Home(),
//         '/login': (BuildContext context) => const LoginPage(),
//
//       },
//     ),
//   );
// }
