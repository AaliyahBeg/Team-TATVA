import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/petition/utils/utils.dart';
// import 'package:environment_app/components/primary_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:environment_app/services/firestore_methods.dart';
import 'package:environment_app/login.dart';
// import 'package:environment_app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:environment_app/petition/petitions_1_.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

// import '../services/storage_methods.dart';
import '../services/authFunctions.dart';
// import '../widgets/general_button.dart';

class Profile extends StatefulWidget {
  final String docid;
  Profile({Key? key, required this.docid}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? desc;
  var petitionData = {};
  bool isLoading = true;
  String Title = 'Title',
      Scope = 'Scope',
      Topic = 'Topic',
      Story = 'Story',
      location = 'location';
  String pathurl =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";
  late Uint8List file;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var petitionSnap = await FirebaseFirestore.instance
          .collection('Petition')
          .doc(widget.docid)
          .get();
      petitionData = petitionSnap.data()!;
      Title = petitionSnap.data()!['Title'];
      Scope = petitionSnap.data()!['Scope'];
      Story = petitionSnap.data()!['Story'];
      location = petitionSnap.data()!['location'];
      pathurl = petitionSnap.data()!['pathurl'];
    } catch (e) {
      showSnackBar(
        context,
        "The Error in Profile is: " + e.toString(),
      );
    }
    if (petitionData != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: SingleChildScrollView(
                child: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    title: Text('TATV',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                    leading: Icon(
                      Icons.energy_savings_leaf_rounded,
                      color: Colors.black,
                      size: 35,
                    ),
                    actions: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(width: 15),
                    ]),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () => {Navigator.pushNamed(context, 'homepage')},
                        child: Container(
                          child: Text('Home',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              )),
                        )),
                    GestureDetector(
                        onTap: () => {Navigator.pushNamed(context, '')},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [
                                  0.3,
                                  0.75,
                                  0.9
                                ],
                                colors: [
                                  const Color(0xFF3DA35D),
                                  const Color(0xFF96E072),
                                  const Color(0xFFE8FCCF),
                                ]),
                          ),
                          child: Text('Petitions',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        )),
                    GestureDetector(
                        onTap: () => {Navigator.pushNamed(context, '')},
                        child: Container(
                            child: Text('Connect',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                )))),
                    GestureDetector(
                        onTap: () => {Navigator.pushNamed(context, '')},
                        child: Container(
                            child: Text('News',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                )))),
                  ],
                ),
              ]),
            ),
          )

        // child:const Center(child: CircularProgressIndicator()),

        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  title: Text('TATV',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      )),
                  leading: Icon(
                    Icons.energy_savings_leaf_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  actions: [
                    Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(width: 15),
                  ]),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () =>
                                  {Navigator.pushNamed(context, 'homepage')},
                              child: Container(
                                child: Text('Home',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                    )),
                              )),
                          GestureDetector(
                              onTap: () => {Navigator.pushNamed(context, '')},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 13),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [
                                        0.3,
                                        0.75,
                                        0.9
                                      ],
                                      colors: [
                                        const Color(0xFF3DA35D),
                                        const Color(0xFF96E072),
                                        const Color(0xFFE8FCCF),
                                      ]),
                                ),
                                child: Text('Petitions',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              )),
                          GestureDetector(
                              onTap: () => {Navigator.pushNamed(context, '')},
                              child: Container(
                                  child: Text('Connect',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                      )))),
                          GestureDetector(
                              onTap: () => {Navigator.pushNamed(context, '')},
                              child: Container(
                                  child: Text('News',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                      )))),
                        ],
                      ),
//
                    SizedBox(height: 5),
                   Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'ONGOING PETITIONS',
              style: TextStyle(
                fontFamily: 'Inria',
                fontSize: 22,
              ),
            ),
          ),

                      SizedBox(height: 1),
                      Container(
                        width: 350,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 215, 236, 187),
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 360.0,
                          height: 250.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              
                              image: DecorationImage(
                                  image: NetworkImage(
                                    pathurl,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),

                      SizedBox(height: 25),
                      Container(
                        width: 340,
                        height: 400,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 212, 244, 206),
                          borderRadius: BorderRadius.circular(41),
                          border: Border.all(
                            width: 0,
                            color: Colors.lightGreen,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 23,
                              color: Colors.green,
                              // spreadRadius: 11,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text("TITLE",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inria',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),
                            Text(Title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inria',
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 20),
                            Text("SCOPE",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inria',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),
                            Text(Scope,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inria',
                                )),
                            SizedBox(height: 20),
                            Text("LOCATION",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inria',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),
                            Text(location,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inria',
                                )),
                            SizedBox(height: 20),
                            Text("STORY",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inria',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),
                            Text(Story,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inria',
                                )),
                          ],
                        ),
                      ) //
                    ]),
              ),
            ),
          );
  }
}
