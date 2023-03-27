import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Land_Pollution/Product/sellProduct.dart';
import 'package:environment_app/Land_Pollution/Wishlist/Wishlist_item.dart';
import 'package:flutter/material.dart';
import 'list_of_product.dart';
import 'project_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  String _searchText = '';

  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('product');
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          _searchText = "";
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.95,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Second Hands",
                style: TextStyle(
                    fontFamily: 'Inria',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black26,
                  ),
              ),
              IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MySeach(),
                    );
                  },
                  icon: const Icon(Icons.search)),
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
                //             child: TextField(
                //               decoration: InputDecoration(
                //                   hintText: "Find your coffee...",
                //                   hintStyle: TextStyle(color: Color(0xff3c4046)),
                //                   border: InputBorder.none,
                //                   prefixIcon: Icon(
                //                     Icons.search,
                //                     color: Colors.grey[600],
                //                   )),
                //               onChanged: (text) {
                //                 setState(() {
                //                   _searchText = text;
                //                 });
                //               },
                //             ),
                //               /// try to do seach in it
                //  child:StreamBuilder<QuerySnapshot>(
                //     stream: _firebaseFirestore.snapshots().asBroadcastStream(),
                //     builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
                //       if(!snapshot.hasData){
                //         return Center(child: CircularProgressIndicator());
                //       }
                //       else{
                //         if(snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Name']
                //             .toString()
                //             .toLowerCase()
                //             .contains(_searchText.toLowerCase())).isEmpty){
                //           return Center(child: Text("No data"),);
                //         }
                //         else{
                //           ///fetch data here
                //           print(snapshot.data);
                //           return ListView(
                //             children:[
                //               ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Name']
                //                   .toString()
                //                   .toLowerCase()
                //                   .contains(_searchText.toLowerCase())).map((QueryDocumentSnapshot<Object?> data) {
                //                 final String Name = data.get('Name');
                //                 final String image = data['Image'];
                //                 final String short_desc = data['short_desc'];
                //
                //                 return ListTile(
                //
                //                   onTap: (){},
                //                   title: Text(Name),
                //                   leading: CircleAvatar(
                //                     backgroundImage: NetworkImage(image),
                //                   ),
                //                   subtitle: Text(short_desc),
                //                 );
                //               })
                //             ],
                //           );
                //         }
                //       }
                //     }
                // ),
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
                  indicator: CircleTabIndicator(color: Colors.green, radius: 4),
                  padding: EdgeInsets.all(8),
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
                  final availableHeight = 700;
                  print('maxheight' + availableHeight.toString());
                  final tabBarViewHeight = availableHeight *
                      0.8; // set the tabBarView height to 80% of the available height
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
      ),
    );
  }
}

class MySeach extends SearchDelegate {
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('product');

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            }
            query = '';
          },
          icon: Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),

        /// close seach bar
        icon: Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [];

    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['Name']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("No data"),
              );
            }
            else {
              ///fetch data here
              print(snapshot.data);
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['Name']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String Name = data['Name'];
                    final String image = data['Image'];
                    final String short_desc = data['short_desc'];

                    return ListTile(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CoffeeDetailsPage(id: ''))
                      },
                      title: Text(Name),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(image),
                      ),
                      subtitle: Text(short_desc),
                    );
                  })
                ],
              );
            }
          }
        });
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
