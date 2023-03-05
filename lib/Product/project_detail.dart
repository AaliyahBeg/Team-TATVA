
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class thumb extends StatefulWidget {

  final id;
  thumb(this.id);

  @override
  State<StatefulWidget> createState()  { print (id); return CoffeeDetailsPage( id: id);}
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
class CoffeeDetailsPage extends State<thumb> {

  // static const routeName = '/project_detail';
  final String id;
  CoffeeDetailsPage( {required this.id}) ;

  @override
  Widget build(BuildContext context) {
    print (this.id);
    // final id = (ModalRoute.of(context)?.settings as RouteSettings).arguments as String;
    // print((ModalRoute.of(context)?.settings as RouteSettings).arguments);
    final id = this.id;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child : FutureBuilder(
            future: firestore.collection('product').doc(id).get(),
            builder: (context,AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>> snapshot) {
              var s = snapshot;
              var d = (s as AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>>).data?.data();
              print (snapshot.runtimeType);
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 440,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image:  DecorationImage(
                                  image: NetworkImage((d as Map<String, dynamic>)['image']?.toString() ?? ''),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          top: 320,
                          child:Center(
                            child: buildBlur(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(25)),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                height: 140,
                                width: 377,
                                color: Colors.black.withOpacity(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (d as Map<String, dynamic>)['Name']?.toString() ?? 'not found',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          (d as Map<String, dynamic>)['short_desc']?.toString() ?? 'not found',
                                          style: TextStyle(
                                            color: Color(0xff919296),
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "images/star.svg",
                                              height: 20,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              (d as Map<String, dynamic>)['Rating']?.toString() ?? 'not found',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 42,
                                              width: 42,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    "images/coffee-beans.svg",
                                                    color: Colors.green,
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "Like",
                                                    style: TextStyle(
                                                        color: Color(0xff919296),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color(0xF6F3F3E4),
                                                  borderRadius: BorderRadius.circular(8)),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              height: 42,
                                              width: 42,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    "images/water-drop.svg",
                                                    color: Colors.green,
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "+ Cart",
                                                    style: TextStyle(
                                                        color: Color(0xff919296),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color(0xF6F3F3E4),
                                                  borderRadius: BorderRadius.circular(8)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                color: Color(0xff919296),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            (d as Map<String, dynamic>)["desc"]?.toString() ?? 'not found',
                            style: TextStyle(color: Color(0xff919296), fontSize: 15),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Size",
                            style: TextStyle(
                                color: Color(0xff919296),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 37,
                                width: 110,
                                child: Center(
                                    child: Text(
                                      "S",
                                      style: TextStyle(
                                        color: Color(0xff919296),
                                        fontSize: 18,
                                      ),
                                    )),
                                decoration: BoxDecoration(
                                    color: Color(0xF6F3F3E4),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.green)),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Container(
                                height: 37,
                                width: 110,
                                child: Center(
                                    child: Text(
                                      "M",
                                      style: TextStyle(
                                        color: Color(0xff919296),
                                        fontSize: 18,
                                      ),
                                    )),
                                decoration: BoxDecoration(
                                    color: Color(0xF6F3F3E4),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Container(
                                height: 37,
                                width: 110,
                                child: Center(
                                    child: Text(
                                      "L",
                                      style: TextStyle(
                                        color: Color(0xff919296),
                                        fontSize: 18,
                                      ),
                                    )),
                                decoration: BoxDecoration(
                                    color: Color(0xF6F3F3E4),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        color: Color(0xff919296),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        r'Rs.',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 21),
                                      ),
                                      Text(
                                        (d as Map<String, dynamic>)['Price']?.toString() ?? 'not found',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 21),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              // ignore: deprecated_member_use
                              ButtonTheme(
                                minWidth: 200,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    print("Button Pressed!");
                                  },
                                  child: Text(
                                    "Buy Now",
                                    style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

 Widget buildBlur({
   required Widget child,
   required BorderRadius borderRadius,
   double sigmaX= 5,
   double sigmaY= 5,
  
  }) =>
 ClipRRect(
  borderRadius: borderRadius ?? BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(25)),
     child: BackdropFilter(
         filter: ImageFilter.blur(sigmaX: sigmaX,sigmaY: sigmaY),
         child: child,
     ),
     );
}