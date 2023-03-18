import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/petition/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:environment_app/petition/petition_3_.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController=TextEditingController();

  void postImage(
    String textNote,  // Title
    String textNote1, //Scope
    String textNote2, // Topic
    String textNote3, // Story 
    String location, // Location

  )
  
  async{
    try{
    }
      
      catch(e)
      {

      }
    

  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Raise Petition '),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // ImagePicker imagePicker = ImagePicker();
                  //   XFile? file =
                  //       await imagePicker.pickImage(source: ImageSource.gallery);
                  // ImagePicker imagePicker = ImagePicker();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );

                  setState(() {
                    _file = file;
                  });
                 
                },
              ),


                   SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // ImagePicker imagePicker = ImagePicker();
                  //   XFile? file =
                  //       await imagePicker.pickImage(source: ImageSource.gallery);
                  // ImagePicker imagePicker = ImagePicker();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );

                  setState(() {
                    _file = file;
                  });
                 
                },
              ),
                SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
                ),
            ],
          );
        });
  }


@override
void dispose(){
  super.dispose();
  _descriptionController.dispose();
}
  @override
  Widget build(BuildContext context) {

   
 // final User user=Provider.of<UserProvider>(context).getUser;
    return _file==null?
    Center(
      child: IconButton(
        icon:Icon(Icons.upload),
        onPressed:()=> _selectImage(context),

    ),
    ):

 Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text("Raise Petition"),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: (){},
            //PostImage,
            child: const Text(
              "Select",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1619895862022-09114b41f16f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Write a caption...",
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                )),
            SizedBox(
              height: 45,
              width: 45,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: MemoryImage(_file!),
                    fit: BoxFit.fill,
                    alignment: FractionalOffset.topCenter,
                  )),
                ),
              ),
            ),
            const Divider(),
          ],
        )
      ]),
    );
  }
}
