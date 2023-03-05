import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DataDetail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DataSetInputScreen extends StatefulWidget {

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
  late io.File _image;
  late String imageUrl;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add DataSet'),
        backgroundColor: Colors.green,
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
              (imageUrl != null)
                ? Image.network(imageUrl)
                : Placeholder(fallbackHeight: 200.0 , fallbackWidth: double.infinity),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder(),
                backgroundColor: Colors.green,
                side: BorderSide(color: Color(0xff33691E),width: 2),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    DataSet dataSet = DataSet(
                      Name: _nameController.text,
                      Image: _imageController.text,
                      Price: _priceController.text,
                      Short_desc: _shortDescController.text,
                      Desc: _descController.text,
                      Categorie: _categorieController.text,
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
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          MaterialButton(
            child: Text("Gallery"),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
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
      'Short_desc': dataSet.Short_desc,
      'Desc': dataSet.Desc,
      'Categorie': dataSet.Categorie,
    });
  }

  uploadImage() async{
    final _picker = ImagePicker();
    PickedFile image;
    //check permissions
    await Permission.photos.request();

    // var permissionStatus = await
  }
}


