// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:environment_app/petition/final_petition.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:environment_app/petition/raise_petition_two.dart';



// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   final GoogleSignIn _googleSignIn = GoogleSignIn();



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Colors.transparent,
//           title: const Text('NATURALEZA',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black,
//               )),
//           leading: const Icon(
//             Icons.energy_savings_leaf_rounded,
//             color: Colors.black,
//             size: 35,
//           ),
//           actions: [
//             const Icon(
//               Icons.search,
//               color: Colors.black,
//               size: 30,
//             ),
//             const SizedBox(width: 5),
//           ]),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 25),
//         child: SingleChildScrollView(
//           child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                     onTap: () => {Navigator.pushNamed(context, '')},
//                     child: Container(
//                       child: const Text('Home',
//                           style: TextStyle(
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.bold,
//                           )),
//                     )),
//                 GestureDetector(
//                     onTap: () => {Navigator.pushNamed(context, '')},
//                     child: Container(
//                       padding:
//                           const EdgeInsets.symmetric(vertical: 12, horizontal: 13),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: const LinearGradient(
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                             stops: [
//                               0.3,
//                               0.75,
//                               0.9
//                             ],
//                             colors: [
//                               Color(0xFF3DA35D),
//                               Color(0xFF96E072),
//                               Color(0xFFE8FCCF),
//                             ]),
//                       ),
//                       child: const Text('Petitions',
//                           style: TextStyle(
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           )),
//                     )),
//                 GestureDetector(
//                     onTap: () => {Navigator.pushNamed(context, '')},
//                     child: Container(
//                         child: const Text('Connect',
//                             style: TextStyle(
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.bold,
//                             )))),
//                 GestureDetector(
//                     onTap: () => {Navigator.pushNamed(context, '')},
//                     child: Container(
//                         child: const Text('News',
//                             style: TextStyle(
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.bold,
//                             )))),
              
//             // child: Form(
//             //   key: _formKey,
//             //   child: Column(
//             //     children: <Widget>[
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: "Email",
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please enter email";
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: const InputDecoration(
//                       labelText: "Password",
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please enter password";
//                       }
//                       return null;
//                     },
                
//              const SizedBox(height: 10),
//              TextButton(
//               child: const Text("Sign in with Email"),
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Code to handle email sign-in
//                 }
//               },
//             ),
//             ),
//             const SizedBox(height: 10),
//             TextButton(
//               child: const Text("Sign in with Google"),
//               onPressed: () async {
//                 try {
//                   await _googleSignIn.signIn();
//                 } catch (error) {
//                   // Handle error
//                 }
                
//               },
//             ),
//                   ),
//               ],
               

             
      

//             TextButton(
//               onPressed: () {
//                  Navigator.push(context,
//                 MaterialPageRoute(builder:((context) => ImagePickerExample()),
//                 )
//                 );
//               },
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(Color(0xFF96E072)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14.0),
//                 )),
//                 padding: MaterialStateProperty.all<EdgeInsets>(
//                     EdgeInsets.symmetric(horizontal: 52, vertical: 5)),
//               ),
//               child: const Text(
//                 'NEXT',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Inter',
//                 ),
//               ),
//             ),

//             SizedBox(height: 0),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(Color(0xFF96E072)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14.0),
//                 )),
//                 padding: MaterialStateProperty.all<EdgeInsets>(
//                     EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
//               ),
//               child: const Text(
//                 'GO BACK',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Inter',
//                 ),
//               ),
//             ),
          
//           ),
//           ],
//        ),
//         ),
//       )
//     )

//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please enter email";
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please enter password";
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             TextButton(
//               child: Text("Sign in with Email"),
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Code to handle email sign-in
//                 }
//               },
//             ),
//             SizedBox(height: 10),
//             TextButton(
//               child: Text("Sign in with Google"),
//               onPressed: () async {
//                 try {
//                   await _googleSignIn.signIn();
//                 } catch (error) {
//                   // Handle error
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
