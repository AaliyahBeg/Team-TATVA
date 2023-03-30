import 'dart:async';
import 'dart:convert';
import 'package:environment_app/Air_Pollution/air_quality.dart';
import 'package:environment_app/Air_Pollution/components/fill_column_data.dart';
import 'package:environment_app/Air_Pollution/data/historicalAQI/geo_coder_model.dart';
import 'package:environment_app/utils/chartGradient.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:unixtime/unixtime.dart';
import '../components/primary_appbar.dart';
import 'components/create_dropdown_list.dart';
import 'components/string_to_unix.dart';
import 'data/confidential.dart';
import 'data/historicalAQI/historical_aqi_model.dart';
import 'package:http/http.dart' as http;
import 'package:environment_app/Air_Pollution/components/getLocation.dart';

class aqiGraph extends StatefulWidget {
  const aqiGraph({super.key});

  @override
  State<aqiGraph> createState() => _aqiGraphState();
}

class _aqiGraphState extends State<aqiGraph> {
  double? lat;
  double? lon;
  int? start, monthStart;
  int? end, monthEnd;
  late historicalAqiModel dayData, monthData = historicalAqiModel();
  late GeoCoderModel latlong;
  String? address;
  String dayDropdownValue = dayDropdownValues.last;
  String aqiDropdownValue = aqiDropdownValues.first;
  String monthDropdownValue = findMonth(DateTime.now());
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
  StreamController? _streamController, monthController;
  Stream? _stream, monthStream;

  Timer? _debounce;
  List<AQIValues>? graphData;
  bool gotLocation = false;

  final TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _streamController = StreamController.broadcast();
    monthController = StreamController.broadcast();
    _stream = _streamController!.stream;
    monthStream = monthController!.stream;
    _getCurrentPosition();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == gl.LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      print("Permission not provided");
      return;
    }
    await gl.Geolocator.getCurrentPosition(
            desiredAccuracy: gl.LocationAccuracy.high)
        .then((gl.Position position) {
      setState(() {
        print("setting lat and lon values....");
        lat = position.latitude;
        lon = position.longitude;
        gotLocation = true;
      });
    }).catchError((e) {
      debugPrint(e);
    });
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
    print("Latitude = ${lat}");
    print("Longitude = ${lon}");
    print("Start time is = ${start}");
    print("End time is = ${end}");

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
    // return dayData;
  }

  getMonthAPI() async {
    print("Calling getMonthAPI...");
    if (myController.text == null || myController.text.isEmpty) {
      monthController!.add(null);
      return;
    }

    monthController!.add("Loading...");

    List<int> start_end = getMonthUnix(monthDropdownValue);
    monthStart = start_end[0];
    monthEnd = start_end[1];

    print("Start=${monthStart}");
    print("End=${monthEnd}");
    print(lat);
    print(lon);
    final monthResponse = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution/history?lat=${lat}&lon=${lon}&start=${monthStart}&end=${monthEnd}&appid=${historicalDataAPIKey}'));

    var data = jsonDecode(monthResponse.body.toString());
    print(data);
    monthController!.add(data);
    historicalAqiModel monData = historicalAqiModel.fromJson(data);
    monthData.coord = Coord(lon: monData.coord!.lon, lat: monData.coord!.lat);
    print("Month Data Lon: ${monthData.coord!.lon}");
    print("Month Data Lat: ${monthData.coord!.lat}");
    monthData.list = <ComponentList>[];
    for (int i = 0; i < monData.list!.length; i += 24) {
      int avgAQI = 0;
      num avgco = 0;
      num avgno = 0;
      num avgno2 = 0;
      num avgo3 = 0;
      num avgso2 = 0;
      num avgpm25 = 0;
      num avgpm10 = 0;
      num avgnh3 = 0;
      int date = monData.list![i].dt!;
      for (int j = i; j < i + 24 && i < monData.list!.length; j++) {
        avgAQI += monData.list![i].main!.aqi!;
        avgco += monData.list![i].components!.co!;
        avgno += monData.list![i].components!.no!;
        avgno2 += monData.list![i].components!.no2!;
        avgo3 += monData.list![i].components!.o3!;
        avgso2 += monData.list![i].components!.so2!;
        avgpm25 += monData.list![i].components!.pm25!;
        avgpm10 += monData.list![i].components!.pm10!;
        avgnh3 += monData.list![i].components!.nh3!;
      }
      avgAQI = (avgAQI / 24).floor();
      avgco /= 24;
      avgno /= 24;
      avgno2 /= 24;
      avgo3 /= 24;
      avgso2 /= 24;
      avgpm25 /= 24;
      avgpm10 /= 24;
      avgnh3 /= 24;
      // print("Average AQI ${i + 1} = ${avgAQI}");
      monthData.list!.add(ComponentList(
          main: Main(aqi: avgAQI),
          components: Components(
              co: avgco,
              no: avgno,
              no2: avgno2,
              o3: avgo3,
              so2: avgso2,
              pm25: avgpm25,
              pm10: avgpm10,
              nh3: avgnh3),
          dt: date));
    }
    print("Month Data first AQI : ${monthData.list![0].main!.aqi}");
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
              'AQI GRAPHS',
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
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton<String>(
                  value: aqiDropdownValue.isNotEmpty ? aqiDropdownValue : null,
                  icon: const Icon(Icons.expand_more),
                  elevation: 16,
                  style: const TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 17,
                      fontWeight: FontWeight.w200,
                      color: Colors.black54),
                  onChanged: (String? value) {
                    setState(() {
                      aqiDropdownValue = value!;
                    });
                    // getAPI();
                  },
                  items: aqiDropdownValues
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ]),
          ),

          //By Day
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
            child: const Text(
              'By Day',
              style: TextStyle(
                fontFamily: 'Inria',
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width/3,
            margin: const EdgeInsets.fromLTRB(10, 5, 220, 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              value: dayDropdownValue.isNotEmpty ? dayDropdownValue : null,
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
                  print("Before column data");
                  fillColumnData(dayData, aqiDropdownValue, 'day');
                  graphData = [...columnData];
                  clearColumnData();
                  print("After column data");
                  return Container(
                    child: SfCartesianChart(
                      title: ChartTitle(text: chartTitle),
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                      ),
                      series: <ChartSeries>[
                        AreaSeries<AQIValues, String>(
                          dataSource: graphData!,
                          xValueMapper: (AQIValues aqiv, _) => aqiv.date,
                          yValueMapper: yValueMapper,
                          gradient: linearGradient,
                        )
                      ],
                      // enableAxisAnimation: true,
                      margin: const EdgeInsets.all(6),
                    ),
                  );
                }
                return Container();
              }),

          // By Month
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
            child: const Text(
              'By Month',
              style: TextStyle(
                fontFamily: 'Inria',
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 200, 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<String>(
                value:
                    monthDropdownValue.isNotEmpty ? monthDropdownValue : null,
                icon: const Icon(Icons.expand_more),
                elevation: 16,
                style: const TextStyle(
                    fontFamily: 'Inria',
                    fontSize: 17,
                    fontWeight: FontWeight.w200,
                    color: Colors.black54),
                onChanged: (String? value) {
                  setState(() {
                    monthDropdownValue = value!;
                  });
                  getMonthAPI();
                },
                items: monthDropdownValues
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          StreamBuilder(
              stream: monthStream,
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
                  print("Before column data");
                  fillColumnData(monthData, aqiDropdownValue, 'month');
                  print("After column data");
                  graphData = [...columnData];
                  clearColumnData();
                  return Container(
                    child: SfCartesianChart(
                      title: ChartTitle(text: chartTitle),
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                      ),
                      series: <ChartSeries>[
                        AreaSeries<AQIValues, String>(
                          dataSource: graphData!,
                          xValueMapper: (AQIValues aqiv, _) => aqiv.date,
                          yValueMapper: yValueMapper,
                          gradient: linearGradient,
                        )
                      ],
                      enableAxisAnimation: true,
                      margin: const EdgeInsets.all(6),
                    ),
                  );
                }
                return Container();
              }),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors[0],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/1.png', width: 30),
                  Container(
                    width: 250,
                    child: Text(
                      'Toxins are absent, and the air is clean. There are no health risks for people.',
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors[1],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/2.png', width: 30),
                  Container(
                    width: 250,
                    child: Text(
                      'Those in good health can breathe the air,but those who are very sensitive may be at risk.',
                      // maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors[2],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/3.png', width: 30),
                  Container(
                    width: 250,
                    child: Text(
                      'Such air might make breathing a little uncomfortable and difficult.',
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors[3],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/4.png', width: 30),
                  Container(
                    width: 250,
                    child: Text(
                      'Children, pregnant women, and the elderly may particularly struggle with this.',
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors[4],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/5.png', width: 30),
                  Container(
                    width: 250,
                    child: Text(
                      'Chronic morbidities or even organ damage might result from air exposure.',
                    ),
                  ),
                ],
              )),
              Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors[5],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/6.png', width: 40),
                  Container(
                    width: 250,
                    child: Text(
                      'Beware! Your life is at risk. Prolonged exposure can result in death.',
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class AQIDangerCard extends StatelessWidget {
  String text = "Text";
  String emoji = "assets/images/1.png";
  Color color = Colors.white;

  AQIDangerCard({
    super.key,
    required text,
    required emoji,
    required color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(emoji, width: 20),
            Container(
              width: 250,
              child: Text(
                text,
              ),
            ),
          ],
        ));
  }
}

class AQIValues {
  String? date;
  int? aqi;
  num? co;
  num? no;
  num? no2;
  num? o3;
  num? so2;
  num? pm25;
  num? pm10;
  num? nh3;

  AQIValues(this.date, this.aqi, this.co, this.no, this.no2, this.o3, this.so2,
      this.pm25, this.pm10, this.nh3);
}
