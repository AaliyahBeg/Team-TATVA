import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Air_Pollution/aqi.dart';
import 'package:environment_app/Air_Pollution/aqiGraph.dart';
import 'package:environment_app/Connect/connect.dart';
import 'package:environment_app/Connect/feed_screen.dart';
import 'package:environment_app/News/datenews_home.dart';
import 'package:environment_app/News/localnews_home.dart';

import 'package:environment_app/News/news_home.dart';
import 'package:environment_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Land_Pollution/Cart_Add/CartSystem.dart';
import 'Land_Pollution/Product/Products.dart';
import 'Air_Pollution/components/getLocation.dart';
import 'Land_Pollution/models/product_model.dart';
import 'package:environment_app/petition/petitions_1_.dart';

import 'package:environment_app/welcome_screen.dart';
import 'package:environment_app/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';



import 'Connect/components/providers/user_provider.dart';
import 'components/profile.dart';

import 'package:environment_app/News/datenews.dart';
import 'package:environment_app/News/headlines.dart';
import 'package:environment_app/News/localnews.dart';
import 'package:environment_app/News/savednews.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('production');
  await Hive.openBox<Product>('cart');
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
            'currAQIGraph': (context) => const curraqiGraph(),
            'connect': (context) => Connect(
                  collection: collection,
                ),
            'aqi': (context) => const aqiStatus(),
            'profile': (context) => Profile(uid: uid, collection: collection),
            'news_page1': (context) => const headlines(),
            'news_page2': (context) => const localnews_home(),
            'news_page3': (context) => const datenews_home(),
            'saved_news': (context) => const savednews(),
          },
        ));
  }
}














































