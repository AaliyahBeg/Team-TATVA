import 'package:environment_app/petitions.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/homepage.dart';
import 'package:environment_app/Welcome_Screen.dart';
import 'package:environment_app/login.dart';
import 'package:environment_app/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart'; // state management
import 'package:google_sign_in/google_sign_in.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.phone.request();
  await Permission.activityRecognition.request();
  await Permission.location.request();
  await Permission.sms.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tatv',
      home: StreamBuilder( //This code is using the Flutter StreamBuilder widget
        // to determine the UI to display. It listens to the stream of authentication
        // state changes from FirebaseAuth. If the snapshot of the stream has data,
        // it returns a Home widget, otherwise it returns a WelcomeScreen widget.
        // This is likely used to determine if the user is logged in or not.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Home();
          }else{
            return WelcomeScreen();
          }
        },
      ),
      theme: ThemeData(
        primaryColor:Colors.grey,
        backgroundColor: Colors.white,
      ),
      routes: {
        'petitions': (context) => const Petitions(),
        'homepage': (context) => const Home(),
        'login': (context) => const LoginPage(),
        'signup': (context) => const SignupPage(),
      },
    );
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