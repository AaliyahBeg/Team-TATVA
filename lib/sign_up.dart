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
  final _formKey=GlobalKey<FormState>(); //to save the form
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
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(30),
                  //   child:
                  //
                  //   TextButton.icon(
                  //     icon: Icon(Icons.person),
                  //     style: TextButton.styleFrom(
                  //       foregroundColor: Colors.white,
                  //       backgroundColor: Colors.blueGrey,
                  //
                  //       padding: const EdgeInsets.all(16.0),
                  //       textStyle: const TextStyle(fontSize: 15),
                  //       minimumSize: Size(350, 50),
                  //
                  //       elevation: 200,
                  //     ),
                  //     onPressed: ()  => {Navigator.pushNamed(context, 'login')},
                  //     label: const Text('Enter Email'),
                  //   ),
                  //
                  // ),
                  // const SizedBox(height: 15,),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(30),
                  //   child:
                  //
                  //   TextButton.icon(
                  //     icon: Icon(Icons.lock),
                  //     style: TextButton.styleFrom(
                  //       foregroundColor: Colors.white,
                  //       backgroundColor: Colors.blueGrey,
                  //
                  //       padding: const EdgeInsets.all(16.0),
                  //       textStyle: const TextStyle(fontSize: 15),
                  //       minimumSize: Size(350, 50),
                  //       elevation: 200,
                  //     ),
                  //     onPressed: ()  => {Navigator.pushNamed(context, 'login')},
                  //     label: const Text('Password'),
                  //   ),
                  //
                  // ),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ======== Full Name ========
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

                          // ======== Email ========
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
                          // ======== Password ========
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
                            // child: Text(login
                            //     ? "Don't have an account? Signup"
                            //     : "Already have an account? Login")
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
                  // const SizedBox(height: 15,),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(4),
                  //   child:
                  //
                  //   TextButton.icon(
                  //     icon: Icon(Icons.login),
                  //     style: TextButton.styleFrom(
                  //       foregroundColor: Colors.white,
                  //       backgroundColor: Colors.teal,
                  //       side: BorderSide(color: Colors.white60,width:2),
                  //       padding: const EdgeInsets.all(16.0),
                  //       textStyle: const TextStyle(fontSize: 20),
                  //       minimumSize: Size(150, 50),
                  //       elevation: 200,
                  //     ),
                  //     onPressed: ()  => {Navigator.pushNamed(context, 'login')},
                  //     label: const Text('Login'),
                  //   ),
                  //
                  // ),
                  // const SizedBox(height: 15,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Don't have an account? ",
                  //         style: TextStyle(
                  //           fontSize: 17,
                  //           fontFamily: 'Inria',
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.white70,
                  //         )
                  //     ),
                  //     TextButton(
                  //         onPressed: () =>{Navigator.pushNamed(context, 'signup')},
                  //         child: Text('Sign up',
                  //             style: TextStyle(
                  //               fontSize: 14,
                  //               fontFamily: 'Inria',
                  //               fontWeight: FontWeight.normal,
                  //               color: Colors.blueGrey,
                  //             )),
                  //     )
                  //   ],
                  // ),


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
