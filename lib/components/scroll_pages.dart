import 'package:environment_app/Air_Pollution/air_pollution_main.dart';
import 'package:flutter/material.dart';

import '../Air_Pollution/aqiGraph.dart';
import '../Land_Pollution/Product/Products.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Content of page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AirPollutionMain();
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Content of page 5'),
    );
  }
}
