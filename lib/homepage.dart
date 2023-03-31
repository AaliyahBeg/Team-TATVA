import 'dart:core';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:environment_app/components/scroll_pages.dart';

import 'components/card_items.dart';
import 'components/primary_appbar.dart';
import 'Noise_Pollution/main.dart';
import 'components/card_items.dart';
import 'components/primary_appbar.dart';
import 'components/scroll_pages.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        child: PrimaryAppBar(
          page: 'homepage',
        ),
        preferredSize: const Size.fromHeight(110.0),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 12),
          Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "CONTROL",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
                Container(
                  height: 256,
                  child: ScrollSnapList(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                    scrollDirection: Axis.horizontal,
                    onItemFocus: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemSize: 200,
                    dynamicItemSize: true,
                    // itemBuilder: (context,_)=> SizedBox(width:12),
                    itemBuilder: (context, index) =>
                        buildCard(item: items[index]),
                    itemCount: 5,
                    initialIndex: 0,
                    onReachEnd: () => {},
                  ),
                  // CarouselSlider(
                  //     items:
                  //         items.map((item) => buildCard(item: item)).toList(),
                  //     options: CarouselOptions(
                  //       aspectRatio: 16 / 9,
                  //       viewportFraction: 0.5,
                  //       onPageChanged: (index, reason) {
                  //         setState(() {
                  //           _currentIndex = index;
                  //         });
                  //       },
                  //       enlargeCenterPage: true,
                  //     )),
                ),
              ],
            ),
          ),
          Container(
            child: _getPage(_currentIndex),
          ),
        ]),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0: //Land_Pollution
        return Page1();
      case 1: //Water_Pollution
        return Page2();
      case 2: //Air Pollution
        return Page3();
      // case 3: //Noise_Pollution
      //   return Page4();
      case 4: //Light_Pollution
        return Page5();
      default:
        return Container();
    }
  }
}
