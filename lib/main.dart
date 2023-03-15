import 'package:environment_app/petitions.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/Land_Pollution/Product/Products.dart';
import 'package:environment_app/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Product/Project_detail.dart';
import 'Land_Pollution/Product/list_of_product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Land_Pollution/Product/sellProduct.dart';
import 'package:hive/hive.dart';




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
   await Hive.initFlutter();
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
