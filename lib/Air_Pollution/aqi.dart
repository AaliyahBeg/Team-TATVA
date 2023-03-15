import 'package:environment_app/Air_Pollution/map.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'data/AQI/app_images.dart';
// import 'screens/chatbot.dart';
import 'data/AQI/air_quaity_provider.dart';
import 'air_quality.dart';
import 'search_screen.dart';

class AQI extends HookWidget {
  final address;

  const AQI({Key? key, this.address}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final airData = Provider.of<AirQualityProvider>(context);
    bool clicked = false;
    print(airData.items.length);
    final future = useMemoized(() => airData.fetchAndSetData());
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) => Scaffold(
              body: SafeArea(
                child: PageView.builder(
                  itemCount: airData.items.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => AirFirstPage(
                    toValue: airData.items[index].data!.aqi!.toDouble(),
                    airQuality: airData.items[index],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                child: Icon(Icons.search),
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     Navigator.of(context)
              //         .push(MaterialPageRoute(builder: (context) => ChatBot()));
              //   },
              //   backgroundColor: Colors.amber,
              //   heroTag: 'bot',
              //   child: const Icon(FontAwesomeIcons.robot),
              // ),
            ),
    );
  }

  Widget loadingScreen() {
    return Scaffold(
      body: Stack(
        // overflow: Overflow.visible,
        children: <Widget>[
          Image.asset(
            splash,
            fit: BoxFit.fill,
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  splash_title,
                  width: 300.0,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const CircularProgressIndicator()
              ],
            ),
          )
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:charts_flutter/flutter.dart' as charts;

// class AQIGraph extends StatefulWidget {
//   @override
//   _AQIGraphState createState() => _AQIGraphState();
// }

// class _AQIGraphState extends State<AQIGraph> {
//   List<charts.Series<AQIData, String>> _seriesData;

//   _generateData() async {
//     var data = await http.get("https://api.example.com/aqi");
//     var jsonData = json.decode(data.body);
//     List<AQIData> aqiData = [];
//     for(var i in jsonData){
//       aqiData.add(AQIData(i["date"], i["aqi"]));
//     }
//     _seriesData.add(
//       charts.Series(
//         data: aqiData,
//         domainFn: (AQIData aqiData, _) => aqiData.date,
//         measureFn: (AQIData aqiData, _) => aqiData.aqi,
//         id: 'AQI',
//         labelAccessorFn: (AQIData row, _) => '${row.aqi}',
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _seriesData = List<charts.Series<AQIData, String>>();
//     _generateData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AQI'),
//       ),
//       body: Container(
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Expanded(
//                 child: charts.LineChart(_seriesData,
//                     defaultRenderer: new charts.LineRendererConfig(
//                         includeArea: true, stacked: true),
//                     animate: true,
//                     animationDuration: Duration(seconds: 2),
//                     behaviors: [
//                       new charts.ChartTitle('Date',
//                           behaviorPosition: charts.BehaviorPosition.bottom,
//                           titleOutsideJustification:
//                               charts.OutsideJustification.middleDrawArea),
//                       new charts.ChartTitle('AQI',
//                           behaviorPosition: charts.BehaviorPosition.start,
//                           titleOutsideJustification:
//                               charts.OutsideJustification.middleDrawArea)
//                     ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AQIData {
//   final String date;
//   final int aqi;

//   AQIData(this.date, this.aqi);
// }
