import 'dart:io';
import 'package:environment_app/petition/petitions_1_.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../components/primary_appbar.dart';

void main() => runApp(ImagePickerExample());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
  String? textNote;
  String? textNote1;
  String? textNote2;
  String? textNote3;
  int ? support;
 

  ImagePickerExample(
      {this.textNote, this.textNote1, this.textNote2, this.textNote3});

  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState(
        textNote: textNote,
        textNote1: textNote1,
        textNote2: textNote2,
        textNote3: textNote3,
      );
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  GlobalKey<FormState> key = GlobalKey();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String imageUrl = '';
  String? textNote;
  String? textNote1;
  String? textNote2;
  String? textNote3;
  String imgTitle = ""; // title_of_img
  String pathUrl = ""; // pathurl
  String location = '-'; //location
  int support = 0;

  _ImagePickerExampleState(
      {this.textNote, this.textNote1, this.textNote2, this.textNote3});
  CollectionReference user = FirebaseFirestore.instance.collection('Petition');

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: PrimaryAppBar(
            page: 'petitions',
          ),
          preferredSize: const Size.fromHeight(110.0),
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text(
                  "ADD AN IMAGE",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Inria',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text(
                  "Select the image by clicking camera icon",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Inria',
                    fontSize: 14,
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
                        imgTitle = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Give some title to your image",
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

              SizedBox(height: 15),
              Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (value) {
                        location = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter location of image",
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

              IconButton(
                onPressed: () async {
                  //1.(Pick Image ) Installing the image picker and import the corresponding library
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  // print(`${file.path}`);
                  print('${file?.path}');

                  if (file == null) return;

                  //import dart:core
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();

                  //2. Get a reference to storage root
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirimages = referenceRoot.child('images');

                  //3.Create a reference for the image to be stored
                  Reference referenceImageToUpload =
                      referenceDirimages.child(uniqueFileName);

                  //Handle errors/success
                  try {
                    //Store the file
                    await referenceImageToUpload.putFile(File(file.path));
                    //Success:get the download URL
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    print("Image URL ${imageUrl}");
                    pathUrl = imageUrl;
                    print("Path URL: ${pathUrl}");
                  } catch (error) {}
                  //Store the file

                  // pathUrl = referenceImageToUpload.putFile(File(file!.path)) as String;
                  print("Path URL after : ${pathUrl}");
                },
                icon: Icon(Icons.camera_alt),
              ),
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

              SizedBox(height: 5),

              TextButton(
                onPressed: () async {
                  if (imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please upload an image')));
                  }
                  var userSnap = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .get();
                  print("Path URL in onPressed: ${pathUrl}");
                  await user.add({
                    'uid': uid,
                    'Title': textNote,
                    'Scope': textNote1,
                    'Topic': textNote2,
                    'Story': textNote3,
                    'imgTitle': imgTitle,
                    'pathurl': imageUrl,
                    'location': location,
                    'username': userSnap["name"],
                    'profilePic': userSnap["photourl"],
                    'support': [],
                    'datePublished': DateTime.now(),
                  }).then((value) => print('User added'));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => Petitions()),
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