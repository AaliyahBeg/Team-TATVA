import 'dart:async';
import 'dart:convert';
import 'package:environment_app/Air_Pollution/air_quality.dart';
import 'package:environment_app/Air_Pollution/data/historicalAQI/geo_coder_model.dart';
import 'package:flutter/material.dart';
import '../components/primary_appbar.dart';
import 'components/create_dropdown_list.dart';
import 'components/string_to_unix.dart';
import 'data/confidential.dart';
import 'data/historicalAQI/historical_aqi_model.dart';
import 'package:http/http.dart' as http;

class aqiStatus extends StatefulWidget {
  const aqiStatus({super.key});

  @override
  State<aqiStatus> createState() => _aqiStatusState();
}

class _aqiStatusState extends State<aqiStatus> {
  double? lat;
  double? lon;
  int? start, monthStart;
  int? end, monthEnd;
  late historicalAqiModel dayData, monthData = historicalAqiModel();
  late GeoCoderModel latlong;
  String? address;
  String dayDropdownValue = dayDropdownValues.last;
  String aqiDropdownValue = aqiDropdownValues.first;
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
    lat = latlong.data![0].latitude;
    lon = latlong.data![0].longitude;
    start = getUnix(dayDropdownValue, "00:00:00.000");
    end = getUnix(dayDropdownValue, "23:59:59.000");
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution/history?lat=${lat}&lon=${lon}&start=${start}&end=${end}&appid=${historicalDataAPIKey}'));

    var data = jsonDecode(response.body.toString());
    print(data);
    _streamController!.add(data);
    dayData = historicalAqiModel.fromJson(data);
    for (int i = 0; i < dayData.list!.length; i++) {
      avgAQI += dayData.list![i].main!.aqi!;
      avgco += dayData.list![i].components!.co!;
      avgno += dayData.list![i].components!.no!;
      avgno2 += dayData.list![i].components!.no2!;
      avgo3 += dayData.list![i].components!.o3!;
      avgso2 += dayData.list![i].components!.so2!;
      avgpm25 += dayData.list![i].components!.pm25!;
      avgpm10 += dayData.list![i].components!.pm10!;
      avgnh3 += dayData.list![i].components!.nh3!;
    }
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
        child: PrimaryAppBar(),
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
                    _debounce =
                        Timer(const Duration(milliseconds: 1000), () {
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
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                child: const Text(
                  'Select Date',
                  style: TextStyle(
                    fontFamily: 'Inria',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton<String>(
                  value:
                      dayDropdownValue.isNotEmpty ? dayDropdownValue : null,
                  icon: const Icon(Icons.expand_more),
                  elevation: 16,
                  style: const TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 17,
                      fontWeight: FontWeight.w200,
                      color: Colors.black54),
                  onChanged: (String? value) {
                    setState(() {
                      dayDropdownValue = value!;
                    });
                    getAPI();
                  },
                  items: dayDropdownValues
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
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
                    avgAQI: avgAQI,
                    avgco: avgco,
                    avgnh3: avgnh3,
                    avgno2: avgno2,
                    avgno: avgno,
                    avgo3: avgo3,
                    avgpm10: avgpm10,
                    avgpm25: avgpm25,
                    avgso2: avgso2,
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
