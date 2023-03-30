import 'package:environment_app/Air_Pollution/air_pollution_main.dart';
import 'package:environment_app/Land_Pollution/Product/copy_Products.dart';
import 'package:flutter/material.dart';

import '../Air_Pollution/aqiGraph.dart';
import '../Land_Pollution/Product/Products.dart';
import '../Light_Pollution/light.dart';
import '../Water_Pollution/water.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Water();
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
    return Light();
  }
}
