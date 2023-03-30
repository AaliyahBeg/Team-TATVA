import 'dart:async';
import 'package:environment_app/Welcome_Screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  int? duration = 0;
  Splash({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: this.duration!),
        {Navigator.pushNamed(context, 'welcomescreen')} as FutureOr
            Function()?);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/lock.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
