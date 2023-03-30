import 'package:flutter/material.dart';

import '../widgets/expandable_text.dart';

class LightCard extends StatelessWidget {
  String title;
  String imgUrl;
  String text;
  LightCard(
      {super.key,
      required this.title,
      required this.imgUrl,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 181, 229, 157),
      ),
      child: Column(children: [
        Text(title,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Container(
          height: 200,
          width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover), 
            ),),
        SizedBox(height: 15),
        Container(child: ExpandableText(text)),
      ]),
    );
  }
}
