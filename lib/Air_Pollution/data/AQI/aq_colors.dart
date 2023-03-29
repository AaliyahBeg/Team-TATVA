import 'package:flutter/material.dart';

Color getpm25Update(num pm25) {
    Color color = Colors.white;

    if (pm25 <= 30)color = Color.fromARGB(255, 138, 227, 141);

    if (pm25 > 30 && pm25 <= 60)color = Color.fromARGB(255, 236, 224, 113);

    if (pm25 > 60 && pm25 <= 90)color = Color.fromARGB(255, 247, 157, 106);

    if (pm25 > 90 && pm25 <= 120)color = Color.fromARGB(255, 252, 72, 72);

    if (pm25 > 120 && pm25 <= 250)color = Color.fromARGB(255, 136, 92, 255);

    if (pm25 > 250)color = Color.fromARGB(255, 91, 139, 0);

    return color;
  }

Color geto3Update(num o3) {
    Color color = Colors.white;

    if (o3 <= 50)color = Color.fromARGB(255, 138, 227, 141);

    if (o3 > 50 && o3 <= 100)color = Color.fromARGB(255, 236, 224, 113);

    if (o3 > 100 && o3 <= 168)color = Color.fromARGB(255, 247, 157, 106);

    if (o3 > 168 && o3 <= 208)color = Color.fromARGB(255, 252, 72, 72);

    if (o3 > 208 && o3 <= 748)color = Color.fromARGB(255, 136, 92, 255);

    if (o3 > 748)color = Color.fromARGB(255, 91, 139, 0);

    return color;
  }