import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'components/primary_appbar.dart';

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
      appBar: const PreferredSize(child: PrimaryAppBar(), preferredSize: const Size.fromHeight(110.0),),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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

