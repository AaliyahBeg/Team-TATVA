import 'package:flutter/material.dart';
import 'list_of_product.dart';


import 'project_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20),

        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.height * 0.95,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //     padding: EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //       color: Colors.black,
                    //       borderRadius: BorderRadius.circular(10),
                    //
                    //     ),
                    //     // child: Icon(
                    //     //   Icons.menu,
                    //     //   color: Color(0xff4d4f52),
                    //     // )
                    //   ),
                    // Image.asset(
                    //   "images/timothy-dykes-yd4ubMUNTG0-unsplash-removebg-preview.png",
                    //   height: 50,
                    //   width: 50,
                    // ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Second Hands",
                  style: TextStyle(
                      color: Colors.green[400],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Find your coffee...",
                        hintStyle: TextStyle(color: Color(0xff3c4046)),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[600],
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TabBar(
                    isScrollable: true,
                    controller: tabController,
                    labelColor: Colors.green,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelColor: Color(0xff3c4046),
                    indicator:
                    CircleTabIndicator(color: Colors.green, radius: 4),
                    padding:EdgeInsets.all(8) ,
                    tabs: [
                      Tab(
                        text: "Dresses",
                      ),
                      Tab(
                        text: "Decoration",
                      ),
                      Tab(
                        text: "Tops",
                      ),
                      Tab(
                        text: "Pants",
                      ),
                      Tab(
                        text: "furniture",
                      ),
                      Tab(
                        text: "Toys",
                      ),
                    ]),


            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final availableHeight =   700;
                print('maxheight' + availableHeight.toString());
                final tabBarViewHeight = availableHeight * 0.8; // set the tabBarView height to 80% of the available height
                return SizedBox(
                  height: tabBarViewHeight,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      CoffeeCard(Categorie: "Dresses"),
                      CoffeeCard(Categorie: "Decoration"),
                      CoffeeCard(Categorie: "Tops"),
                      CoffeeCard(Categorie: "Pants"),
                      CoffeeCard(Categorie: "Furnitures"),
                      CoffeeCard(Categorie: "Toys")
                    ],
                  ),
                );
              },
            ),


            // CoffeeCard(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        // selectedItemColor: Color(0x95DE71FF),
        selectedItemColor: Colors.green,
        unselectedItemColor: Color(0xff4d4f52),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  get defaultValue => null;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
    ..color = color
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
      final Offset circleOffset =
          offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
      canvas.drawCircle(circleOffset, radius, _paint);
  }
}