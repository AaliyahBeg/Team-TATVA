import 'dart:async';
import 'package:environment_app/Welcome_Screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  int? duration = 0;
  Splash({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration!), () {
      Navigator.pushNamed(context, 'welcomescreen');
    });
    return Scaffold(
      body: Stack(
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
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              'images/birds.png',
            ),
          ]),
          Center(
            child: Text('TATV',
                style: TextStyle(
                  fontSize: 90,
                  fontFamily: 'Inria',
                  fontWeight: FontWeight.bold,
                  color: Colors.white60,
                )),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
