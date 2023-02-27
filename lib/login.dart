import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:environment_app/homepage.dart';
import 'package:environment_app/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[

              Colors.white,
              Color.fromARGB(255, 151, 196, 184),
              Color.fromARGB(240, 151, 196, 184),
              Color.fromARGB(220, 151, 196, 184),
              // Color.fromARGB(200, 151, 196, 184),
              // Color.fromARGB(160, 151, 196, 184),
            ],
          ),
        ),
        //color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image.asset(
                //
                //   'images/birds.png',
                // ),
                const SizedBox(height: 70,),
                Image.asset(

                  'images/R.png',
                  width: 200,
                ),
                const SizedBox(height: 70,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child:

                  TextButton.icon(
                    icon: Icon(Icons.person),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey,

                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 15),
                      minimumSize: Size(350, 50),

                      elevation: 200,
                    ),
                    onPressed: ()  => {Navigator.pushNamed(context, 'login')},
                    label: const Text('Enter Email'),
                  ),

                ),
                const SizedBox(height: 15,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child:

                  TextButton.icon(
                    icon: Icon(Icons.lock),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey,

                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 15),
                      minimumSize: Size(350, 50),
                      elevation: 200,
                    ),
                    onPressed: ()  => {Navigator.pushNamed(context, 'login')},
                    label: const Text('Password'),
                  ),

                ),
                const SizedBox(height: 15,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child:

                  TextButton.icon(
                    icon: Icon(Icons.login),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      side: BorderSide(color: Colors.white60,width:2),
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20),
                      minimumSize: Size(150, 50),
                      elevation: 200,
                    ),
                    onPressed: ()  => {Navigator.pushNamed(context, 'login')},
                    label: const Text('Login'),
                  ),

                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Inria',
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        )
                    ),
                    TextButton(
                        onPressed: () =>{Navigator.pushNamed(context, 'signup')},
                        child: Text('Sign up',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inria',
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey,
                            )),
                    )
                  ],
                ),


              ],
            ),
            const SizedBox(height: 50,),
            Image.asset(

              'images/earthf.png',
            ),

          ],
        ),
      ),
    );
  }
}
