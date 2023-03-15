import 'dart:async';
import 'dart:convert';
import 'package:environment_app/Air_Pollution/components/fill_column_data.dart';
import 'package:environment_app/Air_Pollution/data/historicalAQI/geo_coder_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:unixtime/unixtime.dart';
import 'components/create_dropdown_list.dart';
import 'components/string_to_unix.dart';
import 'data/confidential.dart';
import 'data/historicalAQI/historical_aqi_model.dart';
import 'package:http/http.dart' as http;

class historicalAirQuality extends StatefulWidget {
  const historicalAirQuality({super.key});

  @override
  State<historicalAirQuality> createState() => _historicalAirQualityState();
}

class _historicalAirQualityState extends State<historicalAirQuality> {
  double? lat;
  double? lon;
  int? start, monthStart;
  int? end, monthEnd;
  late historicalAqiModel dayData, monthData=historicalAqiModel();
  late GeoCoderModel latlong;
  String? address;
  String dayDropdownValue = dayDropdownValues.last;
  String aqiDropdownValue = aqiDropdownValues.first;
  String monthDropdownValue = findMonth(DateTime.now());
  final latlongurl =
      'http://api.positionstack.com/v1/forward?access_key=${addressLatLongKey}&query=';

  StreamController? _streamController, monthController;
  Stream? _stream, monthStream;

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

    // return dayData;
  }

  getMonthAPI() async {
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
    print("Month Data ${monData.coord!.lon}");
    monthData.coord = monData.coord;
    print("Month Data ${monthData.coord!.lon}");
    List<ComponentList> avg = [];
    for (int i = 0; i < monData.list!.length; i += 24) {
      num avgAQI = 0;
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
      avgAQI /= 24;
      avgco /= 24;
      avgno /= 24;
      avgno2 /= 24;
      avgo3 /= 24;
      avgso2 /= 24;
      avgpm25 /= 24;
      avgpm10 /= 24;
      avgnh3 /= 24;
      avg.add(ComponentList(
          main: Main(avgAQI),
          components: Components(
              avgco, avgno, avgno2, avgo3, avgso2, avgpm25, avgpm10, avgnh3),
          dt: date));
    }
    print(avg);
    monthData.list = avg;
  }

  @override
  void initState() {
    super.initState();
    createDayDropdownList();
    _streamController = StreamController();
    monthController = StreamController();
    _stream = _streamController!.stream;
    monthStream = monthController!.stream;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
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
          Container(
              child: StreamBuilder(
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
                      fillColumnData(dayData, aqiDropdownValue);
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
                              dataSource: columnData,
                              xValueMapper: (AQIValues aqiv, _) => aqiv.date,
                              yValueMapper: yValueMapper,
                            )
                          ],
                          enableAxisAnimation: true,
                          margin: const EdgeInsets.all(6),
                          palette: const [
                            Color.fromARGB(255, 255, 174, 243),
                            Color.fromARGB(255, 112, 226, 255),
                            Color.fromARGB(255, 255, 255, 79),
                          ],
                        ),
                      );
                    }
                    return Container();
                  })),

          //By Month
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
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
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
          Container(
              child: StreamBuilder(
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
                      fillColumnData(monthData, aqiDropdownValue);
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
                              dataSource: columnData,
                              xValueMapper: (AQIValues aqiv, _) => aqiv.date,
                              yValueMapper: yValueMapper,
                            )
                          ],
                          enableAxisAnimation: true,
                          margin: const EdgeInsets.all(6),
                          palette: const [
                            Color.fromARGB(255, 255, 174, 243),
                            Color.fromARGB(255, 112, 226, 255),
                            Color.fromARGB(255, 255, 255, 79),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }))
        ],
      ),
    );
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
