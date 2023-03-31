import 'package:flutter/material.dart';

import 'components/create_dropdown_list.dart';
class AirPollutionMain extends StatefulWidget {
  const AirPollutionMain({super.key});

  @override
  State<AirPollutionMain> createState() => _AirPollutionMainState();
}

class _AirPollutionMainState extends State<AirPollutionMain> {
  @override
  void initState() {
    super.initState();
    createDayDropdownList();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(255, 218, 242, 206),
            ),
            child: GestureDetector(
                onTap: () => {Navigator.pushNamed(context, 'aqi')},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.bar_chart),
                    SizedBox(height: 10),
                    Text(
                      'Air Quality and \nHazard Probability',
                      style: TextStyle(
                        fontFamily: 'Inria',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.chevron_right)
                  ],
                ))),
        Container(
          padding: EdgeInsets.all(35),
          margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(255, 218, 242, 206),
            ),
            child: GestureDetector(
                onTap: () => {Navigator.pushNamed(context, 'aqiGraph')},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.bar_chart),
                    SizedBox(height: 10),
                    Text(
                      'AQI Graphs',
                      style: TextStyle(
                        fontFamily: 'Inria',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.chevron_right)
                  ],
                ))),
      ],
    );
  }
}
