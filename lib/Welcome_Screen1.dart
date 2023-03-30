import 'dart:core';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(255, 212, 243, 228),
              Color.fromARGB(255, 151, 196, 184),
              Color.fromARGB(240, 151, 196, 184),

              Color.fromARGB(220, 28, 69, 59),
              // Color.fromARGB(200, 151, 196, 184),
              // Color.fromARGB(160, 151, 196, 184),
            ],
          ),
        ),
        //color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Image(
                  width: double.infinity, //media query otherwise
                  image: AssetImage('images/lock.jpg'),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'images/birds.png',
                    ),
                    Text('TATV',
                        style: TextStyle(
                          fontSize: 90,
                          fontFamily: 'Inria',
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: TextButton.icon(
                        icon: Icon(Icons.login),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 8, 43, 40),
                          side: BorderSide(color: Colors.white60, width: 2),
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize: Size(150, 50),
                          elevation: 200,
                        ),
                        onPressed: () =>
                            {Navigator.pushNamed(context, 'login')},
                        label: const Text('Login'),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: TextButton.icon(
                        icon: Icon(Icons.assignment_ind),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          //backgroundColor: Color.fromARGB(255, 20, 42, 30),
                          backgroundColor: Color.fromARGB(255, 8, 43, 40),
                          side: BorderSide(color: Colors.white60, width: 2),
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize: Size(150, 50),
                          elevation: 200,
                        ),
                        onPressed: () =>
                            {Navigator.pushNamed(context, 'signup')},
                        label: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
