import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgs = [
  'images/pet1.png',
  'images/pet1.png',
  'images/pet1.png'
];

class Petitions extends StatelessWidget {
  const Petitions({Key? key}) : super(key: key);


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
              'ONGOING PETITIONS',
              style: TextStyle(
                fontFamily: 'Inria',
                fontSize: 22,
              ),
            ),
          ),

          CarouselSlider(
              items: imgs.map((item) => Container(
                child: Center(
                  child: Image.asset(
                    item,
                    width: 4000,
                  )
                )
              )
              ).toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 3.5,
                enlargeCenterPage: true,
              )
          ),

          SizedBox(height: 15),

          TextButton(
              onPressed: () {},
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
              child: Text(
                  'RAISE PETITIONS',
                style: TextStyle(
                    color: Colors.black,
                  fontFamily: 'Inter',
                )
              ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'SOME SUCCESS STORIES',
              style: TextStyle(
                fontFamily: 'Inria',
                fontSize: 22,
              ),
            ),
          ),
        ]
      )
      )
    );
  }
}

