import 'package:flutter/material.dart';

final LinearGradient linearGradient = LinearGradient(
  colors: <Color>[
    Colors.green[600]!,
    Colors.yellow[500]!,
    Colors.orange[800]!,
    Colors.red[900]!,
    Colors.purple[900]!,
  ],
  stops: <double>[0.1, 0.3, 0.5, 0.7, 0.9],
  // Setting alignment for the series gradient
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);
