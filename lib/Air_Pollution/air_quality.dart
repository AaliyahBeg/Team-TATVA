import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:water_bottle/water_bottle.dart';
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
  Color? aqiColor;
  String? aqiStatus_;
  String? aqiImage_;
  double? screenWidth, screenHeight;

  _AirFirstPageState(
      {this.animation_,
      this.controller_,
      this.number_,
      this.aqiColor,
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
    animation_ =
        Tween<double>(begin: widget.fromValue, end: widget.avgAQI.toDouble())
            .animate(controller_!)
          ..addListener(() {
            setState(() {
              number_ = animation_?.value.toStringAsFixed(0);
            });
          });
    controller_?.forward();
    aqiColor = getAQIUpdate(widget.avgAQI);
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
            color: aqiColor,
            num: widget.avgpm25.toInt().toString(),
            label: "PM 2.5",
            max: 600),
        getDetailsRowItem(
            color: aqiColor,
            num: widget.avgpm10.toInt().toString(),
            label: "PM 10",
            max: 250),
        getDetailsRowItem(
            color: aqiColor,
            num: widget.avgo3.toInt().toString(),
            label: "O3", 
            max: 200),
        getDetailsRowItem(
            color: aqiColor,
            num: widget.avgno.toInt().toString(),
            label: "NO",
            max: 250),
        getDetailsRowItem(
            color: aqiColor,
            num: widget.avgno2.toInt().toString(),
            label: "NO2",
            max: 250),
        getDetailsRowItem(
            color: aqiColor,
            num: widget.avgso2.toInt().toString(),
            label: "SO2",
            max: 400),
        getDetailsRowItem(
            color: aqiColor,
            num: widget.avgco.toInt().toString(),
            label: "CO",
            max: 16000),
        getDetailsRowItem(
            color: aqiColor,
            num: widget.avgnh3.toInt().toString(),
            label: "NH3",
            max: 200),
      ],
    );
  }

  Widget getDetailsRowItem({Color? color, required String num, required double max, String? label}) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        width: screenWidth! / 3,
        height: screenHeight! / 6,
        child: LiquidCircularProgressIndicator(
          value: double.parse(num) / max,
          valueColor: AlwaysStoppedAnimation(color!),
          backgroundColor: Colors.white,
          borderWidth: 1.0,
          borderColor: Color.fromARGB(0, 244, 67, 54),
          direction: Axis.vertical,
          center: Text(label! + "\n" + num, textAlign: TextAlign.center,),
        ));
  }

  Widget getMainAQIInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("AQI", style: TextStyle(fontFamily: 'Inria', fontSize: 22)),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 250,
          height: 250,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 600,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.3,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: max(widget.avgpm25,widget.avgpm10).toDouble(),
                    cornerStyle: CornerStyle.bothCurve,
                    color: aqiColor,
                    width: 0.3,
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.1,
                      angle: 90,
                      widget: Container(
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              child: Image.asset(aqiImage_ ?? 'assets/images/2.png') ,
                            ),
                            SizedBox(height: 10),
                            Text(max(widget.avgpm25,widget.avgpm10).floor().toString(),
                                style: TextStyle(
                                    fontFamily: 'Inria', fontSize: 17))
                          ],
                        ),
                      ))
                ])
          ]),
        ),
        SizedBox(height: 20),
        
        Text(aqiStatus_?? 'Fair', style: TextStyle(fontFamily: 'Inria', fontSize: 22)),
      ],
    );
  }

  Color getAQIUpdate(num aqi) {
    Color color = Colors.white;

    // if (aqi < 50) {
    //   color = Color.fromARGB(255, 138, 227, 141);
    //   aqiStatus_ = "Good";
    //   aqiImage_ = aqi_1;
    // }

    // if (aqi >= 50 && aqi < 100) {
    //   color = Color.fromARGB(255, 236, 224, 113);
    //   aqiStatus_ = "Moderate";
    //   aqiImage_ = aqi_2;
    // }

    // if (aqi >= 100 && aqi < 150) {
    //   color = Color.fromARGB(255, 247, 157, 106);
    //   aqiStatus_ = "Unhealthy\nfor\nSensitive Groups";
    //   aqiImage_ = aqi_3;
    // }

    // if (aqi >= 150 && aqi < 200) {
    //   color = Color.fromARGB(255, 252, 72, 72);
    //   aqiStatus_ = "Unhealthy";
    //   aqiImage_ = aqi_4;
    // }

    // if (aqi >= 200 && aqi < 300) {
    //   color = Color.fromARGB(255, 136, 92, 255);
    //   aqiStatus_ = "Very Unhealthy";
    //   aqiImage_ = aqi_5;
    // }
    // if (aqi >= 300) {
    //   color = Color.fromARGB(255, 91, 139, 0);
    //   aqiStatus_ = "Hazardous";
    //   aqiImage_ = aqi_6;
    // }

    if (aqi == 1) {
      color = Color.fromARGB(255, 138, 227, 141);
      aqiStatus_ = "Good";
      aqiImage_ = aqi_1;
    }

    if (aqi == 2) {
      color = Color.fromARGB(255, 236, 224, 113);
      aqiStatus_ = "Moderate";
      aqiImage_ = aqi_2;
    }

    if (aqi == 3) {
      color = Color.fromARGB(255, 247, 157, 106);
      aqiStatus_ = "Unhealthy\nfor\nSensitive Groups";
      aqiImage_ = aqi_3;
    }

    if (aqi == 4) {
      color = Color.fromARGB(255, 252, 72, 72);
      aqiStatus_ = "Unhealthy";
      aqiImage_ = aqi_4;
    }

    if (aqi == 5) {
      color = Color.fromARGB(255, 136, 92, 255);
      aqiStatus_ = "Very Unhealthy";
      aqiImage_ = aqi_5;
    }

    return color;
  }
}
