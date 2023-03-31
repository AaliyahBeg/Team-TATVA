import 'package:flutter/material.dart';

import '../components/primary_appbar.dart';
import '../widgets/expandable_text.dart';
import 'data.dart';
import 'water_card.dart';

class Water extends StatefulWidget {
  const Water({super.key});

  @override
  State<Water> createState() => _WaterState();
}

class _WaterState extends State<Water> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: waterData
            .map(
              (ele) => WaterCard(
                  title: ele['title'],
                  imgUrl: ele['imgUrl'],
                  text: ele['text']),
            )
            .toList(),
      ),
    );
  }
}
