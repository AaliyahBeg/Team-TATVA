import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:environment_app/News/localnews.dart';
import 'package:environment_app/News/newscontent.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/primary_appbar.dart';
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

typedef MapTapCallback = void Function(Offset position);

class _CustomZoomPanBehavior extends MapZoomPanBehavior {
  _CustomZoomPanBehavior();
  late MapTapCallback onTap;

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) {
      onTap(event.localPosition);
    }
    super.handleEvent(event);
  }
}

class localnews_home extends StatefulWidget {
  const localnews_home({super.key});

  @override
  State<localnews_home> createState() => _localnews_homeState();
}

class _localnews_homeState extends State<localnews_home> {
  late MapShapeSource dataSource = MapShapeSource.asset(
    //"https://cdn.syncfusion.com/maps/map-data/world-map.json",
    'assets/world_map.json',
    shapeDataField: 'continent',
  );
  late double lat = 0, lng = 0;
  late MapLatLng _markerPosition;
  late _CustomZoomPanBehavior _mapZoomPanBehavior;
  late MapShapeLayerController _controller;
  @override
  void initState() {
    _controller = MapShapeLayerController();
    _mapZoomPanBehavior = _CustomZoomPanBehavior()..onTap = updateMarkerChange;
    dataSource = MapShapeSource.asset(
      //"https://cdn.syncfusion.com/maps/map-data/world-map.json",
      'assets/world_map.json',
      shapeDataField: 'continent',
    );

    super.initState();
  }

  void updateMarkerChange(Offset position) {
    _markerPosition = _controller.pixelToLatLng(position);
    setState(() {
      lat:
      _markerPosition.latitude;
      lng:
      _markerPosition.longitude;
      print(lat.toString() + lng.toString());
    });

    /// Removed [MapTileLayer.initialMarkersCount] property and updated
    /// markers only when the user taps.
    if (_controller.markersCount > 0) {
      _controller.clearMarkers();
    }
    _controller.insertMarker(0);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: PrimaryAppBar(
            page: 'news',
          ),
          preferredSize: const Size.fromHeight(110.0),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  zoomPanBehavior: _mapZoomPanBehavior,
                  controller: _controller,
                  markerBuilder: (BuildContext context, int index) {
                    return MapMarker(
                        latitude: _markerPosition.latitude,
                        longitude: _markerPosition.longitude,
                        child: Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 83, 139, 87),
                          size: 20,
                        ));
                  },
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
              height: 5,
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
        ));
  }
}
