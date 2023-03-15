import 'package:flutter/material.dart';

class SecondaryAppbar extends StatelessWidget {
  const SecondaryAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () => {Navigator.pushNamed(context, 'homepage')},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
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
              ),
              child: Text('Home',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            )),
        GestureDetector(
            onTap: () => {Navigator.pushNamed(context, 'petitions')},
            child: Container(
              child: Text('Petitions',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  )),
            )),
        GestureDetector(
            onTap: () => {Navigator.pushNamed(context, '')},
            child: Container(
                child: Text('Connect',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    )))),
        GestureDetector(
            onTap: () => {Navigator.pushNamed(context, '')},
            child: Container(
                child: Text('News',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    )))),
      ],
    );
  }
}
