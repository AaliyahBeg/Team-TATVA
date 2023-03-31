import 'package:environment_app/Connect/feed_screen.dart';
import 'package:flutter/material.dart';

import '../Land_Pollution/Product/copy_Products.dart';
import '../components/primary_appbar.dart';
import 'components/recommendations.dart';

class Connect extends StatefulWidget {
  String collection;
  Connect({super.key, required this.collection});

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> with TickerProviderStateMixin {
  int _currentIndex = 0;
  // late TabController tabController;

  // @override
  // void initState() {
  //   tabController = TabController(length: 2, vsync: this);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: PrimaryAppBar(
            page: 'connect',
          ),
          preferredSize: const Size.fromHeight(110.0),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    _currentIndex = 0;
                  }),
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: _currentIndex == 0
                        ? BoxDecoration(
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
                              ]))
                        : BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(
                          color: Colors.white,
                          child: Text('My Feed',
                              style: TextStyle(
                                fontFamily: 'Inria',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ))),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => setState(() {
                    _currentIndex = 1;
                  }),
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: _currentIndex == 1
                        ? BoxDecoration(
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
                              ]))
                        : BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(
                          color: Colors.white,
                          child: Text('Recommendations',
                              style: TextStyle(
                                fontFamily: 'Inria',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ))),
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: _getPage(_currentIndex),
            ),
          ]),
        ));
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0: //Land_Pollution
        return FeedScreen(
          collection: widget.collection,
        );
      case 1: //Water_Pollution
        return Recommendations();
      default:
        return Container();
    }
  }
}



/*ListView(
        children: [
          TabBar(
              isScrollable: true,
              controller: tabController,
              labelColor: Colors.black,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
              unselectedLabelColor: Color(0xff3c4046),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 5.0, color: Colors.green),
                insets: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              padding: EdgeInsets.all(8),
              tabs: [
                Tab(
                  text: "My Feed",
                ),
                Tab(
                  text: "Recommendations",
                ),
              ]),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final availableHeight = 700;
              print('maxheight' + availableHeight.toString());
              final tabBarViewHeight = availableHeight *
                  0.8; // set the tabBarView height to 80% of the available height
              return SizedBox(
                height: tabBarViewHeight,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    FeedScreen(collection: widget.collection),
                    Recommendations(),
                  ],
                ),
              );
            },
          ),
        ],
      ),*/
