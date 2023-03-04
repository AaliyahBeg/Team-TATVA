import 'dart:io';
import 'package:environment_app/petition/my_petition.dart';
import 'package:environment_app/petition/user_detail_petition.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  late DatabaseReference dbRef;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Example',
      home: ImagePickerExample(),
     
    );
  }
}

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _pickedImage;
  File? _pickedVideo;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = File(pickedFile!.path);
    });
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      _pickedVideo = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NATURALEZA',
        ),
        backgroundColor: Color.fromARGB(255, 123, 187, 91),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_pickedImage != null) ...[
                Image.file(_pickedImage!),
                const SizedBox(height: 10),
                Text('Selected Image'),
              ],
              if (_pickedVideo != null) ...[
                Image.file(_pickedVideo!),
                SizedBox(height: 10),
                Text('Selected Video'),
              ],
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
                child: TextButton(
                  onPressed: _pickImage,
                  child: Text(
                    'Select Image',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color.fromARGB(255, 123, 187, 91),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),

              TextButton(
                onPressed: () async {
                  // save data to firebase
                  (
                    {
                      
                    }
                  )  ;   
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => MyPetition()),
                      ));
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
                  'SUBMIT',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                  ),
                ),
              ),

              SizedBox(height: 5),

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
                child: const Text('GO BACK',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                    )),
              ),

              // TextButton(
              //   onPressed: _pickVideo,
              //   child: Text('Select Video'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}






