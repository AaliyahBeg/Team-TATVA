import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => new _Page4State();
}

class _Page4State extends State<Page4> {
  //bool _isRecording = false;
  bool _isRecording = true;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  List<String> values = [];
  _Page4State() {
    // Start a timer that runs every 1 minutes
  }

  @override
  void initState() {
    super.initState();
    _noiseMeter = new NoiseMeter(onError);
    // Timer.periodic(Duration(minutes: 30), (timer) {
    //   //update the graph with the list values
    //   // Clear the list
    //   //getGraph(values);
    //   values.clear();
    //
    // });
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  void clear_vector() {
    values.clear();
  }

  void onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) {
        this._isRecording = true;
      }
    });
    String value = noiseReading.toString();
    String plot_value =
        value[28] + value[29] + value[30] + value[31] + value[32];

    values.add(plot_value);
    print(plot_value);
  }

  void onError(Object error) {
    print(error.toString());
    _isRecording = false;
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription!.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  Widget getGraph1() {
    start();
    List<ChartData> chartData = [];
    for (int i = 0; i < values.length; i++) {
      chartData.add(ChartData(i, double.parse(values[i])));
    }
    if (chartData.length >= 25) {
      chartData.removeAt(0);
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      child: SfCartesianChart(
        primaryXAxis: NumericAxis(),
        series: <LineSeries<ChartData, num>>[
          LineSeries<ChartData, num>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
      ),
    );
  }

  Widget getGraph() {
    // List<ChartData> chartData = values
    //     .asMap()
    //     .entries
    //     .map((e) => ChartData(x: e.key, y: double.parse(e.value)))
    //     .toList();
    start();
    List<ChartData> chartData = [];

    if (values.length == 10) {
      for (int i = 0; i < values.length; i++) {
        chartData.add(ChartData(i, double.parse(values[i])));
      }
      clear_vector();
      return Container(
        padding: EdgeInsets.all(16.0),
        child: SfCartesianChart(
          primaryXAxis: NumericAxis(),
          series: <LineSeries<ChartData, num>>[
            LineSeries<ChartData, num>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
            ),
          ],
        ),
      );
    } else
      return Container(
        padding: EdgeInsets.all(16.0),
        child: SfCartesianChart(
          primaryXAxis: NumericAxis(),
          series: <LineSeries<ChartData, num>>[
            LineSeries<ChartData, num>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
            ),
          ],
        ),
      );
  }

  List<Widget> getContent() => <Widget>[
        Container(
            margin: EdgeInsets.all(25),
            child: Column(children: [
              Container(
                child: Text(_isRecording ? "Mic: ON" : "Mic: OFF",
                    style: TextStyle(fontSize: 25, color: Colors.blue)),
                margin: EdgeInsets.only(top: 20),
              )
            ])),
      ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //children: getContent())),
                  children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 100,
                  //width: ,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(211, 222, 135, 100),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(3.0, 3.0),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 50,
                ),
                getGraph1(),
                const SizedBox(
                  height: 50,
                ),
              ])),
        ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: _isRecording ? Colors.red : Colors.green,
        //     onPressed: _isRecording ? stop : start,
        //     child: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic)),
      ),
    );
  }
}
