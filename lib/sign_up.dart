import 'dart:core';
import 'package:flutter/material.dart';
import 'package:environment_app/services/authFunctions.dart';
import 'package:get/get.dart';
import 'package:environment_app/homepage.dart';
import 'package:environment_app/sign_up.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey=GlobalKey<FormState>(); 
  String email='';
  String password='';
  String fullname='';
  bool login=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                
                
              ],
            ),
          ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 70,),
                  Image.asset(

                    'images/R.png',
                    width: 200,
                  ),
                  const SizedBox(height: 70,),
                  
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          login
                              ? Container()
                              : TextFormField(
                            key: ValueKey('fullname'),
                            decoration: InputDecoration(
                              hintText: 'Enter Full Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Full Name';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                fullname = value!;
                              });
                            },
                          ),

                          
                          TextFormField(
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              hintText: 'Enter Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please Enter valid Email';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                email = value!;
                              });
                            },
                          ),
                          
                          TextFormField(
                            key: ValueKey('password'),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                            ),
                            validator: (value) {
                              if (value!.length < 6) {
                                return 'Please Enter Password of min length 6';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                password = value!;
                              });
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            color: Colors.teal,
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    login
                                        ? AuthServices.signinUser(email, password, context)
                                        : AuthServices.signupUser(
                                        email, password, fullname, context);
                                  }
                                },
                                child: Text(login ? 'Login' : 'Signup')),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                login = !login;
                              });
                            },
                            
                            
                            
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    login
                                        ? "Don't have an account? "
                                        : "Already have an account? ",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Inria',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white70,
                                    )
                                ),
                                Text(
                                    login
                                        ? "Signup "
                                        : "Login ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Inria',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.blueGrey,
                                    )
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
      ),
    );
  }
}