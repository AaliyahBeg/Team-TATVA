import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:environment_app/petition/petition_2_.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/petition/Petiton_5_Explore_.dart';
// import 'package:environment_app/petition/';
import 'package:environment_app/petition/components/cards.dart';

// final List<String> imgs = [
//   'images/pet1.png',
//   'images/pet1.png',
//   'images/pet1.png'
// ];

class Petitions extends StatelessWidget {
  const Petitions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text('TATV',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
          leading: Icon(
            Icons.energy_savings_leaf_rounded,
            color: Colors.black,
            size: 35,
          ),
          actions: [
            Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(width: 15),
          ]),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, 'homepage')},
                  child: Container(
                    child: Text('Home',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        )),
                  )),
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 13),
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
                    child: Text('Petitions',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'ONGOING PETITIONS',
              style: TextStyle(
                fontFamily: 'Inria',
                fontSize: 22,
              ),
            ),
          ),

         
          Container(
            height: 190,
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('Petition').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return CarouselSlider(
                      items: (snapshot.data! as dynamic)
                          .docs
                          .map<Widget>((item) => buildCard(
                                title: item['Title'],
                                scope: item['Scope'],
                                topic: item['Topic'],
                                story: item['Story'],
                                imgTitle: item['Story'],
                                pathurl: item['pathurl'],
                                location: item['location'],
                                // support:item['support'],
                                onPressed: () {
                                  print(item);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => Profile(
                                        docid: item.reference.id.toString(),
                                      ),
                                    ),
                                  );
                                },
                              )
                              )
                          .toList(),
                      options: CarouselOptions(
                        // padEnds: true,
                        aspectRatio: 16 / 9,
                        // aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        autoPlay: true,
                      )
                      );
                }),
          ),

          SizedBox(height: 15),

          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => RaisePetition()),
                  ));
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF96E072)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
            ),
            child: const Text('RAISE PETITIONS',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                )),
          ),
           SizedBox(height: 15),
                      Container(
                        width: 350,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 215, 236, 187),
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 360.0,
                          height: 250.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'https://thumbs.dreamstime.com/b/petition-concept-vector-businessman-holding-clipboard-hand-writes-isolated-icon-white-background-illustration-flat-97659357.jpg',
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                       ),
          // SizedBox(height: 25),
          // CircleAvatar(
          //   radius: 76,
          //   backgroundImage: NetworkImage(
          //       'https://images.unsplash.com/photo-1534294228306-bd54eb9a7ba8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
          // ),
          // SizedBox(height: 5),
          // Container(
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          //   child: Text(
          //     'SOME ONGOING  STORIES',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontFamily: 'Inria',
          //       fontSize: 28,
          //     ),
          //   ),
          // ),

          // SizedBox(height: 15),

          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: ((context) => Addpost()),
          //         ));
          //   },
          //   style: ButtonStyle(
          //     backgroundColor:
          //         MaterialStateProperty.all<Color>(Color(0xFF96E072)),
          //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(18.0),
          //     )),
          //     padding: MaterialStateProperty.all<EdgeInsets>(
          //         EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
          //   ),
          //   child: const Text('ONGOING PETITIONS',
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontFamily: 'Inter',
          //       )),
          // ),
        ])),
      ),
    );
  }
}







































