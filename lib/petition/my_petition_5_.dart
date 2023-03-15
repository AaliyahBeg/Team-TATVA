import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:environment_app/petition/petition_2_.dart';




class MyPetition extends StatelessWidget {
  const MyPetition({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('NATURALEZA',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: Colors.black,
            )
        ),
        leading: Icon(Icons.energy_savings_leaf_rounded, color: Colors.black, size: 35,),
        actions: [
          Icon(Icons.search, color: Colors.black, size: 30,),
          SizedBox(width: 15),
        ]
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, 'homepage')},
                child: Container(
                  child: Text(
                      'Home',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    )
                  ),
                )
              ),

              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.3, 0.75, 0.9],
                          colors: [
                            const Color(0xFF3DA35D),
                            const Color(0xFF96E072),
                            const Color(0xFFE8FCCF),
                          ]
                        ),
                      ),
                    child: Text('Petitions',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  )
              ),
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                      child: Text('Connect',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      )))
              ),
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                      child: Text('News',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      )))
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'MY PETITIONS',
              style: TextStyle(
                fontFamily: 'Inria',
                fontSize: 22,
              ),
            ),
          ),
         
  




          SizedBox(height: 435),
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF96E072)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                  )
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
            ),
              child: const Text(
                  'GO BACK',
                style: TextStyle(
                    color: Colors.black,
                  fontFamily: 'Inter',
                )
              ),
          ),

     
        ]
      )
      )
    );
  }
}

