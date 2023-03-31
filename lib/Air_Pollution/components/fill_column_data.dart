import 'dart:math';

import 'package:unixtime/unixtime.dart';

import '../data/historicalAQI/historical_aqi_model.dart';
import '../aqiGraph.dart';

String chartTitle = "";
var yValueMapper;
List<AQIValues> columnData = <AQIValues>[];
void fillColumnData(historicalAqiModel hAQIdata, String value, String type) {
  for (ComponentList data in hAQIdata.list!) {
    columnData.add(AQIValues(
        type=='day' ? data.dt!.toUnixTime(isUtc: false).toString().substring(11, 16) : data.dt!.toUnixTime(isUtc: false).toString().substring(8, 10),
        data.main?.aqi,
        data.components?.co,
        data.components?.no,
        data.components?.no2,
        data.components?.o3,
        data.components?.so2,
        data.components?.pm25,
        data.components?.pm10,
        data.components?.nh3));
  }
  chartTitle = "$value Graph";
  switch (value) {
    case "AQI":
      yValueMapper = (AQIValues aqiv, _) => max(aqiv.pm25!.toInt(),aqiv.pm10!.toInt());
      break;
    case "PM 2.5":
      yValueMapper = (AQIValues aqiv, _) => aqiv.pm25;
      break;
    case "PM 10":
      yValueMapper = (AQIValues aqiv, _) => aqiv.pm10;
      break;
    case "CO":
      yValueMapper = (AQIValues aqiv, _) => aqiv.co;
      break;
    case "NO":
      yValueMapper = (AQIValues aqiv, _) => aqiv.no;
      break;
    case "NO\u2082":
      yValueMapper = (AQIValues aqiv, _) => aqiv.no2;
      break;
    case "O\u2083":
      yValueMapper = (AQIValues aqiv, _) => aqiv.o3;
      break;
    case "SO\u2082":
      yValueMapper = (AQIValues aqiv, _) => aqiv.so2;
      break;
    case "NH\u2083":
      yValueMapper = (AQIValues aqiv, _) => aqiv.nh3;
      break;
  }
}

void clearColumnData() {
  columnData.clear();
}
