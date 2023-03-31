import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/petition/petition_upload_img_4_.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:environment_app/petition/petition_3_.dart';

import '../components/primary_appbar.dart';

class Petition_form extends StatelessWidget {
  String? textNote;
  String textNote1 = 'Local';
  String textNote2 = 'Environment';
  String textNote3 = 'Polluted Drinking water supply in our area';

  Petition_form({this.textNote});
  //  CollectionReference user = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: PrimaryAppBar(
            page: 'petitions',
          ),
          preferredSize: const Size.fromHeight(110.0),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    "Write the scope of your petition:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        onChanged: (value) {
                          textNote1 = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Scope can be Local,National,Global",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.black54,
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.black54,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    "What's the topic that best fits your petition?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        onChanged: (value) {
                          textNote2 = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Eg: Environment ,Soil Pollution etc.",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.black54,
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.black54,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    "TELL YOUR STORY",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          onChanged: (value) {
                            textNote3 = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Elaborate on the situation",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 66.0, horizontal: 0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                color: Colors.black54,
                                width: 1.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                color: Colors.black54,
                                width: 1.5,
                              ),
                            ),
                          ),
                          maxLines: 5,
                          minLines: 1,
                        ),
                        SizedBox(height: 25),
                        TextButton(
                          onPressed: () async {
                            //   await user.add({
                            //  'Scope':textNote1,
                            //  'Topic_Relation':textNote2,
                            //  'story':textNote3,

                            //   }).then((value)=>print('User added'));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => ImagePickerExample(
                                        textNote: textNote,
                                        textNote1: textNote1,
                                        textNote2: textNote2,
                                        textNote3: textNote3,
                                      )),
                                ));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF96E072)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            )),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 52, vertical: 5)),
                          ),
                          child: const Text(
                            'NEXT',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        SizedBox(height: 0),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF96E072)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            )),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 10)),
                          ),
                          child: const Text(
                            'GO BACK',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}














































// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:environment_app/petition/petition_upload_img_4_.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:environment_app/petition/raise_petition_3.dart';

// class Petition_form extends StatelessWidget {
//   final TextEditingController textNote1Controller = TextEditingController();
//   final TextEditingController textNote2Controller = TextEditingController();
//   final TextEditingController textNote3Controller = TextEditingController();
//   final ValueNotifier<bool> _isValid1 = ValueNotifier<bool>(false);
//   final ValueNotifier<bool> _isValid2 = ValueNotifier<bool>(false);
//   final ValueNotifier<bool> _isValid3 = ValueNotifier<bool>(false);

//   Petition_form({
//     Key? key,
//   }) : super(key: key);
//   CollectionReference user = FirebaseFirestore.instance.collection('user');
//   String textNote1 = 'Local';
//   String textNote2 = 'Environment';
//   String textNote3 = 'Polluted Drinking water supply in our area';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             elevation: 0.0,
//             backgroundColor: Colors.transparent,
//             title: Text('NATURALEZA',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 )),
//             leading: Icon(
//               Icons.energy_savings_leaf_rounded,
//               color: Colors.black,
//               size: 35,
//             ),
//             actions: [
//               Icon(
//                 Icons.search,
//                 color: Colors.black,
//                 size: 30,
//               ),
//               SizedBox(width: 5),
//             ]),
//         body: Padding(
//           padding: EdgeInsets.symmetric(vertical: 25),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                         onTap: () => {Navigator.pushNamed(context, '')},
//                         child: Container(
//                           child: Text('Home',
//                               style: TextStyle(
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.bold,
//                               )),
//                         )),
//                     GestureDetector(
//                         onTap: () => {Navigator.pushNamed(context, '')},
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 13),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: LinearGradient(
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 stops: [
//                                   0.3,
//                                   0.75,
//                                   0.9
//                                 ],
//                                 colors: [
//                                   const Color(0xFF3DA35D),
//                                   const Color(0xFF96E072),
//                                   const Color(0xFFE8FCCF),
//                                 ]),
//                           ),
//                           child: Text('Petitions',
//                               style: TextStyle(
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               )),
//                         )),
//                     GestureDetector(
//                         onTap: () => {Navigator.pushNamed(context, '')},
//                         child: Container(
//                             child: Text('Connect',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.bold,
//                                 )))),
//                     GestureDetector(
//                         onTap: () => {Navigator.pushNamed(context, '')},
//                         child: Container(
//                             child: Text('News',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.bold,
//                                 )))),
//                   ],
//                 ),
//                 SizedBox(height: 5),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//                   child: Text(
//                     "Write the scope of your petition:",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       fontFamily: 'Inria',
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 300,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextField(
//                         controller: textNote1Controller,
//                         onChanged: (value) {
//                           textNote1 = value;
//                           _isValid1.value =
//                               textNote1Controller.text.isNotEmpty &&
//                                   textNote2Controller.text.isNotEmpty &&
//                                   textNote3Controller.text.isNotEmpty;
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Scope can be Local,National,Global",
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(11),
//                             borderSide: BorderSide(
//                               color: Colors.black54,
//                               width: 1.5,
//                             ),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(11),
//                             borderSide: BorderSide(
//                               color: Colors.black54,
//                               width: 1.5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//                   child: Text(
//                     ">>What's the topic that best fits your petition?<< ",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'Inria',
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 300,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextField(
//                         controller: textNote2Controller,
//                         onChanged: (value) {
//                           textNote2 = value;
//                           _isValid2.value =
//                               textNote1Controller.text.isNotEmpty &&
//                                   textNote2Controller.text.isNotEmpty &&
//                                   textNote3Controller.text.isNotEmpty;
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Ex- Environment , Education,Health",
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(11),
//                             borderSide: BorderSide(
//                               color: Colors.black54,
//                               width: 1.5,
//                             ),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(11),
//                             borderSide: BorderSide(
//                               color: Colors.black54,
//                               width: 1.5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//                   child: Text(
//                     ">>  TELL YOUR STORY << ",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'Inria',
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 300,
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         TextField(
//                           controller: textNote3Controller,
//                           onChanged: (value) {
//                             textNote3 = value;
//                             // _isValid.value = value.isNotEmpty;
//                             _isValid3.value =
//                                 textNote1Controller.text.isNotEmpty &&
//                                     textNote2Controller.text.isNotEmpty &&
//                                     textNote3Controller.text.isNotEmpty;
//                           },
//                           decoration: InputDecoration(
//                             hintText: "                   Start from scratch",
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 66.0, horizontal: 0),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(11),
//                               borderSide: BorderSide(
//                                 color: Colors.black54,
//                                 width: 1.5,
//                               ),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(11),
//                               borderSide: BorderSide(
//                                 color: Colors.black54,
//                                 width: 1.5,
//                               ),
//                             ),
//                           ),
//                           maxLines: 5,
//                           minLines: 1,
//                         ),
//                         SizedBox(height: 25),
//                         TextButton(
//                           onPressed: () async {
//                             //  if (_isValid.value) {

//                             //   await user.add({
//                             //  'Scope':textNote1,
//                             //  'Topic_Relation':textNote2,
//                             //  'story':textNote3,

//                             //   }).then((value)=>print('User added'));
//                             //  Navigator.push(context,
//                             // MaterialPageRoute(builder:((context) => ImagePickerExample()),
//                             // )
//                             // );
//                             //  }
//                             //  else {
//                             //     ScaffoldMessenger.of(context).showSnackBar(
//                             //     SnackBar(content: Text('Please fill all the fields.')),);
//                             //  }



//                             // bool isValid = true;

//                             // if (textNote1.isEmpty) {
//                             //   isValid = false;
//                             //   ScaffoldMessenger.of(context).showSnackBar(
//                             //     SnackBar(
//                             //         content: Text(
//                             //             'Please enter a value for Scope.')),
//                             //   );
//                             // }

//                             // if (textNote2.isEmpty) {
//                             //   isValid = false;
//                             //   ScaffoldMessenger.of(context).showSnackBar(
//                             //     SnackBar(
//                             //         content: Text(
//                             //             'Please enter a value for Topic_Relation.')),
//                             //   );
//                             // }

//                             // if (textNote3.isEmpty) {
//                             //   isValid = false;
//                             //   ScaffoldMessenger.of(context).showSnackBar(
//                             //     SnackBar(
//                             //         content: Text(
//                             //             'Please enter a value for story.')),
//                             //   );
//                             // }

//                             // if (isValid) {
//                             //   // add user to database
//                             //   await user.add({
//                             //     'Scope': textNote1,
//                             //     'Topic_Relation': textNote2,
//                             //     'story': textNote3,
//                             //   }).then((value) => print('User added'));

//                             //   // navigate to next screen
//                             //   Navigator.push(
//                             //       context,
//                             //       MaterialPageRoute(
//                             //         builder: ((context) =>
//                             //             ImagePickerExample()),
//                             //       ));
//                             // }






//                             onPressed:
//                             () async {
//                               if (
//                                   _isValid3.value) {
//                                 await user.add({
//                                   'Scope': textNote1,
//                                   'Topic_Relation': textNote2,
//                                   'story': textNote3,
//                                 }).then((value) => print('User added'));
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: ((context) =>
//                                           ImagePickerExample())),
//                                 );
//                               } 
//                               else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content:
//                                           Text('Please fill all the fields.')),
//                                 );
//                               }
//                             };





//                           },







//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Color(0xFF96E072)),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14.0),
//                             )),
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                                 EdgeInsets.symmetric(
//                                     horizontal: 52, vertical: 5)),
//                           ),
//                           child: const Text(
//                             'NEXT',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'Inter',
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 0),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Color(0xFF96E072)),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14.0),
//                             )),
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                                 EdgeInsets.symmetric(
//                                     horizontal: 80, vertical: 10)),
//                           ),
//                           child: const Text(
//                             'GO BACK',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'Inter',
//                             ),
//                           ),
//                         ),
//                       ]),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

