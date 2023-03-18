
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'components/card_item.dart';
import 'components/primary_appbar.dart';
import 'components/scroll_page.dart';

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
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: const PreferredSize(
        child: PrimaryAppBar(),
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
                  ),
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
      case 0:
        return Page1();
      case 1:
        return Page2();
      case 2:
        return Page3();
      case 3:
        return Page4();
      case 4:
        return Page5();
      default:
        return Container();
    }
  }
}
