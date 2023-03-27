import 'dart:core';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DataDetail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DataSetInputScreen extends StatefulWidget {
  const DataSetInputScreen({Key? key }) : super(key: key);

  @override
  _DataSetInputScreenState createState() => _DataSetInputScreenState();
}

class _DataSetInputScreenState extends State<DataSetInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _priceController = TextEditingController();
  final _shortDescController = TextEditingController();
  final _descController = TextEditingController();
  final _categorieController = TextEditingController();
  final _sizeController = TextEditingController();
  late io.File _image;
  late String imageUrl ='';
  late String imagePath ='';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Sell Your Own',
          style: TextStyle(
            fontFamily: 'Inria',
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black26,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price',
                    border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _shortDescController,
                decoration: InputDecoration(labelText: 'Short Description',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a short description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _categorieController,
                decoration: InputDecoration(labelText: 'Categorie',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a categorie';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _sizeController,
                decoration: InputDecoration(labelText: 'size',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Size';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder(),
                backgroundColor: Colors.green,
                side: BorderSide(color: Color(0xff33691E),width: 2),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && imagePath != "") {
                    await uploadImage();

                    DataSet dataSet = DataSet(
                      Name: _nameController.text,
                      Image: imageUrl,
                      Price: _priceController.text,
                      short_desc: _shortDescController.text,
                      desc: _descController.text,
                      Categorie: _categorieController.text,
                      size: _sizeController.text,
                    );
                    _formKey.currentState!.reset();
                    _nameController.clear();
                    _imageController.clear();
                    _priceController.clear();
                    _shortDescController.clear();
                    _descController.clear();
                    _categorieController.clear();
                    setDataInFirestore(dataSet);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('DataSet saved successfully!'),
                      ),
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Few feilds are missing!'),
                      ),
                    );
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder(),
                  backgroundColor: Colors.green,
                  side: BorderSide(color: Color(0xff33691E),width: 2),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
  final picker = ImagePicker();

  Future _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select the image source"),
        actions: <Widget>[
          MaterialButton(
            child: Text("Camera"),
            onPressed: () async{
              ImagePicker imagePicker = ImagePicker();
              PickedFile? file = await imagePicker.getImage(source: ImageSource.camera );
              print('${file?.path}');
              imagePath = file!.path;
            },
          ),
          MaterialButton(
            child: Text("Gallery"),
            onPressed: () async{
              ImagePicker imagePicker = ImagePicker();
              PickedFile? file = await imagePicker.getImage(source: ImageSource.gallery );
              print('${file?.path}');

              if(file == null ) return;
              imagePath = file.path;

              //to get unique url

            },
          ),
        ],
      ),
    );

    if (imageSource != null) {
      final file = await picker.getImage(source: imageSource);

      if (file != null) {
        setState(() {
          _image = file as io.File;
        });
      }
    }
  }

  void setDataInFirestore(DataSet dataSet) async {
    await _firestore.collection('product').add({
      'Name': dataSet.Name,
      'Image': dataSet.Image,
      'Price': dataSet.Price,
      'short_desc': dataSet.short_desc,
      'desc': dataSet.desc,
      'Categorie': dataSet.Categorie,
      'size' : dataSet.size,
    });
  }

  uploadImage() async{
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //get reference to storage root
    Reference referenceRoot  = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('static_image');

    //create a reference for the image to be stroge
    Reference referenceImageToUplaod = referenceDirImages.child(uniqueFileName);

    try {
      //store the file
      await referenceImageToUplaod.putFile(io.File(imagePath));
      imageUrl = await referenceImageToUplaod.getDownloadURL();
      print(imageUrl);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image upload successfully'),
        ),
      );
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );

    }
  }
}


