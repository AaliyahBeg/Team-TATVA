// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';

// import 'data/air_quaity_provider.dart';
import 'data/AQI/air_quality.dart';
import 'data/AQI/app_images.dart';
// import 'data/search_data.dart';
import 'search_screen.dart';
import 'package:location/location.dart';

class AirFirstPage extends StatefulWidget {
  const AirFirstPage({
    Key? key,
    this.fromValue = 1,
    required this.toValue,
    required this.airQuality,
    this.duration = const Duration(milliseconds: 1500),
  })  : assert(fromValue <= toValue),
        super(key: key);

  final double fromValue;
  final double toValue;
  final Duration duration;
  final AirQuality airQuality;

  @override
  State<StatefulWidget> createState() => _AirFirstPageState();
}

Location location = Location();
bool? _serviceEnabled;
PermissionStatus? _permissionGranted;
LocationData? _locationData;

Future<dynamic> getLocation() async {
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled!) _serviceEnabled = await location.requestService();

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  _locationData = await location.getLocation();
}

class _AirFirstPageState extends State<AirFirstPage>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation_;
  AnimationController? controller_;

  String? number_;
  Color? aqiColor_;
  String? aqiStatus_;
  String? aqiImage_;
  double? screenWidth, screenHeight;

  _AirFirstPageState(
      {this.animation_,
      this.controller_,
      this.number_,
      this.aqiColor_,
      this.aqiStatus_,
      this.aqiImage_,
      this.screenWidth,
      this.screenHeight});
  @override
  void initState() {
    super.initState();
    controller_ = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    animation_ = Tween<double>(begin: widget.fromValue, end: widget.toValue)
        .animate(controller_!)
      ..addListener(() {
        setState(() {
          number_ = animation_?.value.toStringAsFixed(0);
        });
      });
    controller_?.forward();
    aqiColor_ = getAQIUpdate(widget.toValue);
  }

  @override
  Future<void> dispose() async {
    controller_?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: getNewHome(),
      ),
    );
  }

  Widget getNewHome() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30.0,
        ),
        getTopLocationRow(),
        getMainAQIInfo(),
        ElevatedButton(
          onPressed: () {
            getLocation().then((value){
              print(value);
            });
          }, 
          child: Text("My Location")
        ),
        getTemperatureRow(),
        const SizedBox(
          height: 30.0,
        ),
        getBottomDetailsRow(),
      ],
    );
  }

  Widget getBottomDetailsRow() {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: <Widget>[
        getDetailsRowItem(
            color: aqiColor_,
            num: widget.airQuality.data?.iaqi!.pm25.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data!.iaqi!.pm25.v.toString(),
            label: "PM 2.5"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.airQuality.data?.iaqi!.o3.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data!.iaqi!.o3.v.toString(),
            label: "O3"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.airQuality.data?.iaqi?.no2.toString() == null
                ? 'N/A'
                : widget.airQuality.data!.iaqi!.no2.v.toString(),
            label: "NO2"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.airQuality.data?.iaqi!.so2.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data!.iaqi!.so2.v.toString(),
            label: "SO2"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.airQuality.data?.iaqi!.co.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data!.iaqi!.co.v.toString(),
            label: "CO"),
      ],
    );
  }

  Widget getDetailsRowItem({Color? color, required String num, String? label}) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            offset: const Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: const Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(50.0),
      ),
      width: screenWidth! / 6,
      height: screenHeight! / 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: color,
            child: Text(
              num,
              style: GoogleFonts.saira(
                  color: Colors.black54,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(label!)
        ],
      ),
    );
  }

  Widget getTemperatureRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        tempRowItem(
            iconData: WeatherIcons.cloud,
            num: widget.airQuality.data!.iaqi!.t.v.toString(),
            unit: "°C"),
        tempRowItem(
            iconData: WeatherIcons.humidity,
            num: widget.airQuality.data!.iaqi!.h.v!.toStringAsFixed(2),
            unit: "%"),
        tempRowItem(
            iconData: WeatherIcons.wind,
            num: widget.airQuality.data!.iaqi!.w.v!.toStringAsFixed(2),
            unit: "km/h"),
      ],
    );
  }

  Widget tempRowItem({IconData? iconData, String? num, String? unit}) {
    return Container(
      width: screenWidth! / 4,
      height: screenWidth! / 8,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            offset: const Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: const Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BoxedIcon(
            iconData!,
            size: 20.0,
            color: Colors.black38,
          ),
          Text(
            num!.substring(0, 4),
            style: GoogleFonts.openSans(),
          ),
          Text(
            unit!,
            style: GoogleFonts.openSans(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget getMainAQIInfo() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(20.0),
          width: screenWidth,
          height: screenHeight! / 8,
//          decoration: BoxDecoration(
//            color: aqiColor_,
//            shape: BoxShape.rectangle,
//            borderRadius: BorderRadius.all(
//              Radius.circular(10.0),
//            ),
//          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: aqiColor_!.withOpacity(0.3),
                offset: const Offset(-6.0, -6.0),
                blurRadius: 16.0,
              ),
              BoxShadow(
                color: aqiColor_!.withOpacity(0.2),
                offset: const Offset(6.0, 6.0),
                blurRadius: 16.0,
              ),
            ],
            color: aqiColor_,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                aqiImage_!,
                width: screenWidth! / 5,
              ),
              Column(
                children: <Widget>[
                  Text(
                    '$number_',
                    style: GoogleFonts.saira(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'AQI',
                    style: GoogleFonts.saira(fontSize: 12.0),
                  )
                ],
              ),
              Text(
                aqiStatus_!,
                textAlign: TextAlign.center,
                style: GoogleFonts.saira(
                    fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getTopLocationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: Container()),
        Expanded(child: Container()),
        const Icon(Icons.location_on),
        Text(widget.airQuality.data?.city?.name ?? "NA"),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.searchPlus,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SearchScreen()),
            ),
          ),
        ),
      ],
    );
  }

  Color getAQIUpdate(double aqi) {
    Color color = Colors.white;

    if (aqi < 50) {
      color = Colors.green;
      aqiStatus_ = "Good";
      aqiImage_ = aqi_1;
    }

    if (aqi >= 50 && aqi < 100) {
      color = Colors.yellow;
      aqiStatus_ = "Moderate";
      aqiImage_ = aqi_2;
    }

    if (aqi >= 100 && aqi < 150) {
      color = Colors.deepOrangeAccent;
      aqiStatus_ = "Unhealthy\nfor\nSensitive Groups";
      aqiImage_ = aqi_3;
    }

    if (aqi >= 150 && aqi < 200) {
      color = Colors.red;
      aqiStatus_ = "Unhealthy";
      aqiImage_ = aqi_4;
    }

    if (aqi >= 200 && aqi < 300) {
      color = Colors.deepPurpleAccent;
      aqiStatus_ = "Very Unhealthy";
      aqiImage_ = aqi_5;
    }
    if (aqi >= 300) {
      color = Colors.brown;
      aqiStatus_ = "Hazardous";
      aqiImage_ = aqi_6;
    }

    return color;
  }
}
