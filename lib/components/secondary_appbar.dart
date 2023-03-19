import 'package:flutter/material.dart';

class SecondaryAppbar extends StatelessWidget {
  String page;
  SecondaryAppbar({
    required this.page,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'homepage'),
            child: Container(
              padding: page=='homepage' ? EdgeInsets.symmetric(vertical: 10, horizontal: 10): EdgeInsets.all(0),
              decoration: page=='homepage' ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [
                      0.3,
                      0.75,
                      0.9
                    ],
                    colors: [
                      const Color(0xFF3DA35D),
                      const Color(0xFF96E072),
                      const Color(0xFFE8FCCF),
                    ]),
              ): BoxDecoration(),
              child: Text('Home',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: page=='homepage' ? Colors.white: Colors.black,
                  )),
            )),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'petitions'),
            child: Container(
              padding: page=='petitions' ? EdgeInsets.symmetric(vertical: 10, horizontal: 10): EdgeInsets.all(0),
              decoration: page=='petitions' ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [
                      0.3,
                      0.75,
                      0.9
                    ],
                    colors: [
                      const Color(0xFF3DA35D),
                      const Color(0xFF96E072),
                      const Color(0xFFE8FCCF),
                    ]),
              ): BoxDecoration(),
              child: Text('Petitions',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: page=='petitions' ? Colors.white: Colors.black,
                  )),
            )),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'connect'),
            child: Container(
              padding: page=='connect' ? EdgeInsets.symmetric(vertical: 10, horizontal: 10): EdgeInsets.all(0),
              decoration: page=='connect' ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [
                      0.3,
                      0.75,
                      0.9
                    ],
                    colors: [
                      const Color(0xFF3DA35D),
                      const Color(0xFF96E072),
                      const Color(0xFFE8FCCF),
                    ]),
              ): BoxDecoration(),
                child: Text('Connect',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    color: page=='connect' ? Colors.white: Colors.black,
                    )))),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'news'),
            child: Container(
              padding: page=='news' ? EdgeInsets.symmetric(vertical: 10, horizontal: 10): EdgeInsets.all(0),
              decoration: page=='news' ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [
                      0.3,
                      0.75,
                      0.9
                    ],
                    colors: [
                      const Color(0xFF3DA35D),
                      const Color(0xFF96E072),
                      const Color(0xFFE8FCCF),
                    ]),
              ): BoxDecoration(),
                child: Text('News',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    color: page=='news' ? Colors.white: Colors.black,
                    )))),
      ],
    );
  }
}
