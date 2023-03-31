import 'package:environment_app/components/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class main_page extends StatefulWidget {
  @override
  _main_page createState() => new _main_page();
}

class _main_page extends State<main_page> {
  bool _isRecording = false;
  //bool _isRecording = true;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  List<String> values = [];
  double sum = 0.0;
  double avg = 0.0;
  int i = 0;
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
    sum += double.parse(plot_value);
    i++;
    avg = sum / i;

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

  Widget getGraph() {
    // List<ChartData> chartData = values
    //     .asMap()
    //     .entries
    //     .map((e) => ChartData(x: e.key, y: double.parse(e.value)))
    //     .toList();
    List<ChartData> chartData = [];
    for (int i = 0; i < values.length; i++) {
      chartData.add(ChartData(i, double.parse(values[i])));
    }
    if (values.length >= 20) {
      values.removeAt(0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: PrimaryAppBar(
          page: 'homepage',
        ),
        preferredSize: const Size.fromHeight(110.0),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.lightbulb),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Click the button at buttom to check the current noise levels in your surroundings',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color.fromARGB(255, 29, 71, 31),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            getGraph(),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF96E072),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Average Noise Level:',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 71, 31),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                    child: Text(
                      avg.toStringAsPrecision(5),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color.fromARGB(255, 29, 71, 31),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'dB',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color.fromARGB(255, 29, 71, 31),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: _isRecording ? Colors.red : Colors.green,
          onPressed: _isRecording ? stop : start,
          child: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic)),
    );
  }
}
