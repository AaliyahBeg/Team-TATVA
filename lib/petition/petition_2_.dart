import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/petition/petition_3_.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:environment_app/petition/petition_2_.dart';


class RaisePetition extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(false);
  RaisePetition({Key? key}) : super(key: key);
  // final CollectionReference user = FirebaseFirestore.instance.collection('user');
  String textNote = 'Pollution';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(width: 5),
          ]),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: SingleChildScrollView(
       
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 13),
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

            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                "LET'S TAKE FIRST STEP TOWARDS CHANGE :)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inria',
                  fontSize: 22,
                ),
              ),
            ),

            Center(
              child: Container(
                child: Image.asset("images/petition.png"),
                width: 300,
                height: 200,
              ), //Column
            ), //Center

            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                "Write your petition title",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Inria',
                  fontSize: 22,
                ),
              ),
            ),

            SizedBox(height: 0),
            Container(
              margin: EdgeInsets.only(right: 20, top: 20),
              alignment: Alignment.topCenter,
              child: Text(
                "Petition Title ",
                style: TextStyle(
                  fontSize: 15,
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
                      controller: _textEditingController,
                      onChanged: (value) {
                        textNote = value;
                        _isValid.value = value.isNotEmpty;
                      },
                      decoration: InputDecoration(
                        hintText: "Title must be short ",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.black54,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.black54,
                            width: 1.5,
                          ),
                        ),
                      )),
                ],
              ),
            ),

            SizedBox(height: 25),
            TextButton(
              onPressed: () async {
                if (_isValid.value) {
                  // await user.add({
                  //   'Title': textNote,
                  // }).then((value) => print('User added'));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => Petition_form(textNote: textNote,)),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a title.')),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF96E072)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                )),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 52, vertical: 5)),
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF96E072)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
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
      ),
    );
  }
}
