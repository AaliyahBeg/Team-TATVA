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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Column(
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
      ),
    );
  }
}
