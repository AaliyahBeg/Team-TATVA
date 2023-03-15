// import 'package:environment_app/air_quality.dart';
import 'package:environment_app/Air_Pollution/aqi.dart';
import 'package:environment_app/Air_Pollution/historicalAirQuality.dart';
import 'package:environment_app/Air_Pollution/map.dart';
import 'package:environment_app/petitions.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/homepage.dart';
import 'package:provider/provider.dart';

import 'Air_Pollution/data/AQI/air_quaity_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AirQualityProvider(),
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'homepage',
      routes: {
        'petitions': (context) => const Petitions(),
        'homepage': (context) => const Home(),
        'aqi': (context) => const AQI(),
        'map': (context) => const MapPage(title: 'Map',),
        'historicalAQI': (context) => const historicalAirQuality(),
      },
    )
    );
  }
}