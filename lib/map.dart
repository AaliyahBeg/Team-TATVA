import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(          
          title: Text(widget.title),
        ),
        body: OpenStreetMapSearchAndPick(
            center: LatLong(23, 89),
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
            }));
  }
}