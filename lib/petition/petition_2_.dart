import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/petition/petition_3_.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:environment_app/petition/petition_2_.dart';

import '../components/primary_appbar.dart';


class RaisePetition extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(false);
  RaisePetition({Key? key}) : super(key: key);
  // final CollectionReference user = FirebaseFirestore.instance.collection('user');
  String textNote = 'Pollution';

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
       
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            

            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                "LET'S TAKE THE FIRST STEP TOWARDS CHANGE",
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
