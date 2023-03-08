import 'dart:async';
import 'dart:convert';
import 'package:environment_app/data/historicalAQI/geo_coder_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'data/confidential.dart';
import 'data/historicalAQI/historical_aqi_model.dart';
import 'package:http/http.dart' as http;
import 'package:unixtime/unixtime.dart';

class historicalAirQuality extends StatefulWidget {
  const historicalAirQuality({super.key});

  @override
  State<historicalAirQuality> createState() => _historicalAirQualityState();
}

class _historicalAirQualityState extends State<historicalAirQuality> {
  double? lat;
  double? lon;
  int? start;
  int? end;
  late historicalAqiModel hAQIdata;
  late GeoCoderModel latlong;
  String? address;

  final latlongurl =
      'http://api.positionstack.com/v1/forward?access_key=d372fd73f07cfa7cc920756fb204ec7d&query=';

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

    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution/history?lat=${lat}&lon=${lon}&start=1676851200&end=1676937600&appid=2605f9bd1c792199087da6e81aa65a25'));

    
    var data = jsonDecode(response.body.toString());
    print(data);
    _streamController!.add(data);
    hAQIdata = historicalAqiModel.fromJson(data);

    return hAQIdata;
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController!.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Historical AQI Data"),
        ),
        body: Column(
          children: [
            TextFormField(
              onChanged: (String text) async {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  getAPI();
                });
              },
              controller: myController,
              decoration: const InputDecoration(
                hintText: "New Delhi",
                contentPadding: EdgeInsets.only(left: 24.0),
                border: InputBorder.none,
              ),
            ),
            Expanded(
                child: StreamBuilder(
                    stream: _stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text(
                              "Enter a search word preferably a district."),
                        );
                      }

                      if (snapshot.data == "Loading...") {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        if (data["list"].length == 0) {
                          return const Text('Type a nearby place');
                        }
                        List<AQIValues> columnData = <AQIValues>[];
                        for (ComponentList pm in hAQIdata.list!) {
                          columnData.add(new AQIValues(
                              pm.dt!
                                  .toUnixTime(isUtc: true)
                                  .toString()
                                  .substring(11, 19),
                              pm.components?.pm25));
                        }
                        return Container(
                          height: 550,
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              primaryYAxis: NumericAxis(),
                              series: <ChartSeries>[
                                ColumnSeries<AQIValues, String>(
                                  dataSource: columnData,
                                  xValueMapper: (AQIValues aqiv, _) =>
                                      aqiv.date,
                                  yValueMapper: (AQIValues aqiv, _) =>
                                      aqiv.pm2_5,
                                )
                              ]),
                        );
                      }
                      return Container();
                    }))
          ],
        ));
  }
}

class AQIValues {
  String? date;
  num? pm2_5;

  AQIValues(this.date, this.pm2_5);
}
