import 'package:flutter/material.dart';


class Petitions extends StatelessWidget {
  const Petitions({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('NATURALEZA',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: Colors.black,
            )
        ),
        leading: Icon(Icons.energy_savings_leaf_rounded, color: Colors.black, size: 35,),
        actions: [
          Icon(Icons.search, color: Colors.black, size: 30,),
          SizedBox(width: 15),
        ]
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '')},
                child: Container(
                  child: Text(
                      'Home',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    )
                  ),
                )
              ),

              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.3, 0.75, 0.9],
                          colors: [
                            const Color(0xFF3DA35D),
                            const Color(0xFF96E072),
                            const Color(0xFFE8FCCF),
                          ]
                        ),
                      ),
                    child: Text('Petitions',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  )
              ),
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                      child: Text('Connect',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      )))
              ),
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                      child: Text('News',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      )))
              ),
            ],
          )
        ]
      )
      )
    );
  }
}

