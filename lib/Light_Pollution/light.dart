import 'package:flutter/material.dart';

import '../components/primary_appbar.dart';
import '../widgets/expandable_text.dart';
import 'data.dart';
import 'light_card.dart';

class Light extends StatefulWidget {
  const Light({super.key});

  @override
  State<Light> createState() => _LightState();
}

class _LightState extends State<Light> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: data
            .map(
              (ele) => LightCard(
                  title: ele['title'],
                  imgUrl: ele['imgUrl'],
                  text: ele['text']),
            )
            .toList(),
      ),
    );
  }
}
