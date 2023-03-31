import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  print("Picking Image...");
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  print("Picked something....");
  if (_file != null) {
    print("Image Picked...");
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
