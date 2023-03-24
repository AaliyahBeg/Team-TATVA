import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Connect/components/cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/profile.dart';
import '../../components/primary_appbar.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "ORGANIZATIONS",
                    style: TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 190,
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('organizations')
                          .orderBy('followers')
                          .get(),
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
                                      profileImage: item['photourl'],
                                      username: item['name'],
                                      followers: item['followers'].length,
                                      onPressed: () {
                                        print(item['uid']);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) {
                                            return Profile(
                                                uid: item['uid'],
                                                collection: 'organizations');
                                          }),
                                        );
                                      },
                                    ))
                                .toList(),
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.5,
                            ));
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "ENVIRONMENTALISTS",
                    style: TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 190,
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('organizations')
                          .orderBy('followers')
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
            
                        return CarouselSlider(
                            items: (snapshot.data! as dynamic)
                                .docs
                                .map<Widget>((item) => item['uid']!=FirebaseAuth.instance.currentUser!.uid ? buildCard(
                                      profileImage: item['photourl'],
                                      username: item['name'],
                                      followers: item['followers'].length,
                                      color: Color.fromARGB(255, 221, 223, 221),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => Profile(
                                                    uid: item['uid'],
                                                    collection:
                                                        'organizations')));
                                      },
                                    ): SizedBox(width: 0))
                                .toList(),
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.5,
                            ));
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "RECOMMENDATIONS",
                    style: TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 190,
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('organizations')
                          .orderBy('followers')
                          .get(),
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
                                      profileImage: item['photourl'],
                                      username: item['name'],
                                      followers: item['followers'].length,
                                      color: Color.fromARGB(0, 218, 242, 206),
                                      borderColor:
                                          Color.fromARGB(255, 51, 51, 50),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => Profile(
                                                  uid: item['uid'],
                                                  collection: 'organizations')),
                                        );
                                      },
                                    ))
                                .toList(),
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.5,
                            ));
                      }),
                ),
              ],
            ),
          ),
    );
  }
}
