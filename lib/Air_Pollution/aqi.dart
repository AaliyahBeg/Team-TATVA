import 'dart:async';
import 'dart:convert';
import 'package:environment_app/Air_Pollution/air_quality.dart';
import 'package:environment_app/Air_Pollution/data/historicalAQI/geo_coder_model.dart';
import 'package:flutter/material.dart';
import '../components/primary_appbar.dart';
import 'components/create_dropdown_list.dart';
import 'components/string_to_unix.dart';
import 'data/AQI/aqiData.dart';
import 'data/confidential.dart';
import 'package:http/http.dart' as http;

class aqiStatus extends StatefulWidget {
  const aqiStatus({super.key});

  @override
  State<aqiStatus> createState() => _aqiStatusState();
}

class _aqiStatusState extends State<aqiStatus> {
  double? lat;
  double? lon;
  int? start;
  int? end;
  late AQI_Data dayData;
  late GeoCoderModel latlong;
  String? address;
  String dayDropdownValue = dayDropdownValues.last;
  // String aqiDropdownValue = aqiDropdownValues.first;
  final latlongurl =
      'http://api.positionstack.com/v1/forward?access_key=${addressLatLongKey}&query=';

  num avgAQI = 0;
  num avgco = 0;
  num avgno = 0;
  num avgno2 = 0;
  num avgo3 = 0;
  num avgso2 = 0;
  num avgpm25 = 0;
  num avgpm10 = 0;
  num avgnh3 = 0;
  StreamController? _streamController;
  Stream? _stream;

  Timer? _debounce;

  final TextEditingController myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  getAPI() async {
    if (myController.text == null || myController.text.isEmpty) {
      _streamController!.add(null);
      return;
    }

    _streamController!.add("Loading...");

    final latlongresponse = await http
        .get(Uri.parse(latlongurl + myController.text.replaceAll(' ', '+')));

    var latlongdata = jsonDecode(latlongresponse.body.toString());
    print(latlongdata);

    latlong = GeoCoderModel.fromJson(latlongdata);
    if (latlong.data == null || latlong.data!.isEmpty) return;
    lat = latlong.data![0].latitude;
    lon = latlong.data![0].longitude;
    start = getUnix(dayDropdownValue, "00:00:00.000");
    end = getUnix(dayDropdownValue, "23:59:59.000");
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${lat}&lon=${lon}&appid=${historicalDataAPIKey}'));

    var data = jsonDecode(response.body.toString());
    print(data);
    _streamController!.add(data);
    dayData = AQI_Data.fromJson(data);
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController!.stream;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: PrimaryAppBar(
          page: 'homepage',
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 40, 10, 20),
            child: const Text(
              'AIR QUALITY STATUS',
              style: TextStyle(
                fontFamily: 'Inria',
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              const Icon(Icons.location_on),
              Flexible(
                child: TextFormField(
                  onChanged: (String text) async {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 1000), () {
                      getAPI();
                    });
                  },
                  controller: myController,
                  decoration: const InputDecoration(
                    hintText: "Enter an address..",
                    contentPadding: EdgeInsets.only(left: 24.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ]),
          ),

          //By Day
          Container(
            width: 200,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(Icons.calculate_outlined),
                SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    dayDropdownValue,
                    style: TextStyle(fontFamily: 'Inria', fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          StreamBuilder(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }

                if (snapshot.data == "Loading...") {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 300),
                      ],
                    ),
                  );
                }
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  if (data["list"].length == 0) {
                    return const Text('Type a nearby place');
                  }
                  return AirFirstPage(
                    address: address,
                    avgAQI: dayData.list![0].main!.aqi!,
                    avgco: dayData.list![0].components!.co!,
                    avgnh3: dayData.list![0].components!.nh3!,
                    avgno2: dayData.list![0].components!.no2!,
                    avgno: dayData.list![0].components!.no!,
                    avgo3: dayData.list![0].components!.o3!,
                    avgpm10: dayData.list![0].components!.pm10!,
                    avgpm25: dayData.list![0].components!.pm25!,
                    avgso2: dayData.list![0].components!.so2!,
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
