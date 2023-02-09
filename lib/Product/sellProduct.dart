import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DataDetail.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
// class FormsPage extends StatefulWidget {
//   const FormsPage({Key? key}) : super(key: key);
//
//   @override
//   State<FormsPage> createState() => _FormsPageState();
// }
//
// class _FormsPageState extends State<FormsPage> {
//   final formKey = GlobalKey<FormState>();
//   final controller = TextEditingController();
//   String category = 'Category1';
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sell Now '),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: controller,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   maxLines: null,
//                   decoration: InputDecoration(
//                     labelText: 'Full Name',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.black),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.blue),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.lightGreen),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.red),
//                     ),
//                     labelStyle: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.blue,
//                     ),
//                     isDense: true,
//                   ),
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Unfilled field';
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   // controller: controller,
//                   // autovalidateMode: AutovalidateMode.onUserInteraction,
//                   decoration: InputDecoration(
//                     labelText: 'Address',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.green),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.blue),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.yellow),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.red),
//                     ),
//                     labelStyle: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.blue,
//                     ),
//                     isDense: true,
//                   ),
//                   obscureText: true,
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Unfilled field';
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   value: category,
//                   elevation: 16,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   isDense: true,
//                   decoration: InputDecoration(
//                     labelText: 'Category',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.green),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.blue),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.yellow),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: Colors.red),
//                     ),
//                   ),
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Unfilled Category';
//                     }
//                   },
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       setState(() {
//                         category = newValue;
//                       });
//                     }
//                   },
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'Category1',
//                       child: Text('Books'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Category2',
//                       child: Text('plastic'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Category3',
//                       child: Text('wood item'),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                   child: const Text('Save'),
//                   onPressed: () {
//                     var formValid = formKey.currentState?.validate() ?? false;
//                     var message = 'Form isn\'t valid';
//                     if (formValid) {
//                       message = 'Form is valid: ${controller.text}';
//                     }
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(message),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add DataSet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _shortDescController,
                decoration: InputDecoration(labelText: 'Short Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a short description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categorieController,
                decoration: InputDecoration(labelText: 'Categorie'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a categorie';
                  }
                  return null;
                },
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


              ),
            ],
          ),
        ),
      ),
    );
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
}


