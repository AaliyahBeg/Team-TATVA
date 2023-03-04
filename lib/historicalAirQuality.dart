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

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<historicalAqiModel> getAPI() async {
    await getlatlong();
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution/history?lat=${lat}&lon=${lon}&start=1676851200&end=1676937600&appid=2605f9bd1c792199087da6e81aa65a25'));

    var data = jsonDecode(response.body.toString());
    print(data);

    hAQIdata = historicalAqiModel.fromJson(data);

    return hAQIdata;
  }

  Future<void> getlatlong() async {
    String url =
        'http://api.positionstack.com/v1/forward?access_key=d372fd73f07cfa7cc920756fb204ec7d&query=${address}';
    print(url);
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    print(data);

    latlong = GeoCoderModel.fromJson(data);
    lat = latlong.data![0].latitude;
    lon = latlong.data![0].longitude;
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
              controller: myController,
              decoration: const InputDecoration(
                hintText: "Kolkata",
                contentPadding: EdgeInsets.only(left: 24.0),
                border: InputBorder.none,
              ),
            ),
            FloatingActionButton(onPressed: () {
              address = myController.text.replaceAll(' ', '+');
            }),
            Expanded(
              child: FutureBuilder(
                  future: getAPI(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Loading...');
                    } else {
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
                                xValueMapper: (AQIValues aqiv, _) => aqiv.date,
                                yValueMapper: (AQIValues aqiv, _) => aqiv.pm2_5,
                              )
                            ]),
                      );
                    }
                  })),
            )
          ],
        ));
  }
}

class AQIValues {
  String? date;
  num? pm2_5;

  AQIValues(this.date, this.pm2_5);
}
