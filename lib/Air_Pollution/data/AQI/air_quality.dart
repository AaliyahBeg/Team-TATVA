// To parse this JSON data, do
//
// final airQuality = airQualityFromJson(jsonString);

import 'dart:convert';

AirQuality airQualityFromJson(String str) =>
    AirQuality.fromJson(json.decode(str));

class AirQuality {
  AirQuality({
    this.status,
    this.data,
  });

  String? status;
  Data? data;

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    print("In AirQuality from Json");
    print(json['status']);
    print(json['data']);
    return (AirQuality(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    ));
  }
}

class Data {
  Data({
    this.aqi,
    this.idx,
    this.attributions,
    this.city,
    this.dominentpol,
    required this.iaqi,
    this.time,
    this.forecast,
    this.debug,
  });

  int? aqi;
  int? idx;
  List<Attribution>? attributions;
  City? city;
  String? dominentpol;
  Iaqi? iaqi;
  Time? time;
  Forecast? forecast;
  Debug? debug;

  factory Data.fromJson(Map<String, dynamic> json) {
    print(json['aqi']);
    return (Data(
      aqi: json["aqi"] == null ? null : json["aqi"],
      idx: json["idx"] == null ? null : json["idx"],
      attributions: json["attributions"] == null
          ? null
          : List<Attribution>.from(
              json["attributions"].map((x) => Attribution.fromJson(x))),
      city: json["city"] == null ? null : City.fromJson(json["city"]),
      dominentpol: json["dominentpol"] == null ? null : json["dominentpol"],
      iaqi: json["iaqi"] == null ? null : Iaqi.fromJson(json["iaqi"]),
      time: json["time"] == null ? null : Time.fromJson(json["time"]),
      forecast:
          json["forecast"] == null ? null : Forecast.fromJson(json["forecast"]),
      debug: json["debug"] == null ? null : Debug.fromJson(json["debug"]),
    ));
  }
}

class Attribution {
  Attribution({
    this.url,
    this.name,
    this.logo,
  });

  String? url;
  String? name;
  String? logo;

  factory Attribution.fromJson(Map<String, dynamic> json) => Attribution(
        url: json["url"] == null ? null : json["url"],
        name: json["name"] == null ? null : json["name"],
        logo: json["logo"] == null ? null : json["logo"],
      );
}

class City {
  City({
    this.geo,
    this.name,
    this.url,
  });

  List<double>? geo;
  String? name;
  String? url;

  factory City.fromJson(Map<String, dynamic> json) => City(
        geo: json["geo"] == null
            ? null
            : List<double>.from(json["geo"].map((x) => x.toDouble())),
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
      );
}

class Debug {
  Debug({
    this.sync,
  });

  DateTime? sync;

  factory Debug.fromJson(Map<String, dynamic> json) => Debug(
        sync: json["sync"] == null ? null : DateTime.parse(json["sync"]),
      );
}

class Forecast {
  Forecast({
    this.daily,
  });

  Daily? daily;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
      );
}

class Daily {
  Daily({
    this.o3,
    this.pm10,
    this.pm25,
    this.uvi,
  });

  List<O3>? o3;
  List<O3>? pm10;
  List<O3>? pm25;
  List<O3>? uvi;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        o3: json["o3"] == null
            ? null
            : List<O3>.from(json["o3"].map((x) => O3.fromJson(x))),
        pm10: json["pm10"] == null
            ? null
            : List<O3>.from(json["pm10"].map((x) => O3.fromJson(x))),
        pm25: json["pm25"] == null
            ? null
            : List<O3>.from(json["pm25"].map((x) => O3.fromJson(x))),
        uvi: json["uvi"] == null
            ? null
            : List<O3>.from(json["uvi"].map((x) => O3.fromJson(x))),
      );
}

class O3 {
  O3({
    this.avg,
    this.day,
    this.max,
    this.min,
  });

  int? avg;
  DateTime? day;
  int? max;
  int? min;

  factory O3.fromJson(Map<String, dynamic> json) => O3(
        avg: json["avg"] == null ? null : json["avg"],
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        max: json["max"] == null ? null : json["max"],
        min: json["min"] == null ? null : json["min"],
      );
}

class Iaqi {
  Iaqi({
    required this.co,
    required this.dew,
    required this.h,
    required this.no2,
    required this.o3,
    this.p,
    required this.pm10,
    required this.pm25,
    required this.so2,
    required this.t,
    required this.w,
  });

  Co co;
  Co dew;
  Co h;
  Co no2;
  Co o3;
  Co? p;
  Co pm10;
  Co pm25;
  Co so2;
  Co t;
  Co w;

  factory Iaqi.fromJson(Map<String, dynamic> json) => Iaqi(
        co: Co.fromJson(json["co"]),
        dew: Co.fromJson(json["dew"]),
        h: Co.fromJson(json["h"]),
        no2: Co.fromJson(json["no2"]),
        o3: Co.fromJson(json["o3"]),
        p: Co.fromJson(json["p"]),
        pm10: Co.fromJson(json["pm10"]),
        pm25: Co.fromJson(json["pm25"]),
        so2: Co.fromJson(json["so2"]),
        t: Co.fromJson(json["t"]),
        w: Co.fromJson(json["w"]),
      );
}

class Co {
  Co({
    this.v,
  });

  double? v;

  factory Co.fromJson(Map<String, dynamic> json) => Co(
        v: json["v"] == null ? null : json["v"].toDouble(),
      );
}

class Time {
  Time({
    this.s,
    this.tz,
    this.v,
  });

  DateTime? s;
  String? tz;
  int? v;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        s: json["s"] == null ? null : DateTime.parse(json["s"]),
        tz: json["tz"] == null ? null : json["tz"],
        v: json["v"] == null ? null : json["v"],
      );
}
