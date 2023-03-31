import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();

  static void show(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoadingScreen()));
  }

  static void close(BuildContext context) {
    Navigator.pop(context);
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
