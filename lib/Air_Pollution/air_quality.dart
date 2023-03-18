import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/AQI/app_images.dart';

class AirFirstPage extends StatefulWidget {
  AirFirstPage({
    Key? key,
    required this.avgAQI,
    required this.avgco,
    required this.avgno,
    required this.avgno2,
    required this.avgo3,
    required this.avgso2,
    required this.avgpm25,
    required this.avgpm10,
    required this.avgnh3,
    required this.address,
    this.duration = const Duration(milliseconds: 1500),
    this.fromValue = 1,
  }) : super(key: key);

  num avgAQI = 0;
  num avgco = 0;
  num avgno = 0;
  num avgno2 = 0;
  num avgo3 = 0;
  num avgso2 = 0;
  num avgpm25 = 0;
  num avgpm10 = 0;
  num avgnh3 = 0;
  String? address = '';
  final Duration duration;
  final double fromValue;

  @override
  State<StatefulWidget> createState() => _AirFirstPageState();
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
    animation_ = Tween<double>(begin: widget.fromValue, end: widget.avgAQI.toDouble())
        .animate(controller_!)
      ..addListener(() {
        setState(() {
          number_ = animation_?.value.toStringAsFixed(0);
        });
      });
    controller_?.forward();
    aqiColor_ = getAQIUpdate(widget.avgAQI);
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
        child: getNewHome(widget.address),
      ),
    );
  }

  Widget getNewHome(String? address) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30.0,
        ),
        getMainAQIInfo(),
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
            color: aqiColor_, num: widget.avgpm25.toInt().toString(), label: "PM 2.5"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.avgpm10.toInt().toString(),
            label: "PM 10"),
        getDetailsRowItem(
            color: Colors.green, num: widget.avgo3.toInt().toString(), label: "O3"),
        getDetailsRowItem(
            color: Colors.green, num: widget.avgno.toInt().toString(), label: "NO"),
        getDetailsRowItem(
            color: Colors.green, num: widget.avgno2.toInt().toString(), label: "NO2"),
        getDetailsRowItem(
            color: Colors.green, num: widget.avgso2.toInt().toString(), label: "SO2"),
        getDetailsRowItem(
            color: Colors.green, num: widget.avgco.toInt().toString(), label: "CO"),
        getDetailsRowItem(
            color: Colors.green, num: widget.avgnh3.toInt().toString(), label: "NH3"),
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
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: screenWidth! / 3,
      height: screenHeight! / 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(255, 237, 226, 226),
            ),
            child: Text(
              num,
              style: TextStyle(
                fontFamily: 'Inria',
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

  Widget getMainAQIInfo() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(20.0),
          width: screenWidth,
          height: screenHeight! / 8,
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

  Color getAQIUpdate(num aqi) {
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
