import 'package:flutter/material.dart';

final LinearGradient linearGradient = LinearGradient(
  colors: colors,
  stops: <double>[0.1, 0.3, 0.5, 0.7, 0.9, 1],
  // Setting alignment for the series gradient
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

List<Color> colors = <Color>[
  Color.fromARGB(255, 131, 220, 135)!,
  Color.fromARGB(255, 247, 234, 122)!,
  Color.fromARGB(255, 239, 145, 68)!,
  Color.fromARGB(255, 254, 93, 93)!,
  Color.fromARGB(255, 180, 118, 255)!,
  Color.fromARGB(255, 165, 101, 69)!,
];
