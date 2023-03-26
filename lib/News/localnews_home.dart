import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:environment_app/News/localnews.dart';
import 'package:environment_app/News/newscontent.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/primary_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class localnews_home extends StatefulWidget {
  const localnews_home({super.key});

  @override
  State<localnews_home> createState() => _localnews_homeState();
}

class _localnews_homeState extends State<localnews_home> {
  late MapShapeSource dataSource = MapShapeSource.asset(
    "https://cdn.syncfusion.com/maps/map-data/world-map.json",
    shapeDataField: 'continent',
  );
  @override
  void initState() {
    dataSource = MapShapeSource.asset(
      //"https://cdn.syncfusion.com/maps/map-data/world-map.json",
      'assets/custom.geo.json',
      shapeDataField: 'continent',
    );

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: PrimaryAppBar(
            page: 'news',
          ),
          preferredSize: const Size.fromHeight(110.0),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Pick a Location',
              style: TextStyle(
                color: Color.fromARGB(255, 29, 71, 31),
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SfMaps(
              layers: [
                MapShapeLayer(
                  source: dataSource,
                  loadingBuilder: (BuildContext context) {
                    return Container(
                      height: 25,
                      width: 25,
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return localnews(location: "");
                }));
              },
              icon: Icon(Icons.arrow_forward),
            ),
            Image(
              width: double.infinity, //media query otherwise
              image: AssetImage('images/tree.png'),
            ),
          ],
        )));
  }
}
