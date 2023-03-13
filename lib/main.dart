import 'package:environment_app/petitions.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/Product/Products.dart';
import 'package:environment_app/homepage.dart';
import 'Product/Project_detail.dart';
import 'Product/list_of_product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Product/sellProduct.dart';




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

 void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp().then((value) => {runApp(const MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomeScreen(),
      home:  HomeScreen(),
      routes: {
        // CoffeeDetailsPage. : (ctx) =>  CoffeeDetailsPage(),
        // "list_of_product": (context) =>  CoffeeCard(),
      },
    );
  }
}
