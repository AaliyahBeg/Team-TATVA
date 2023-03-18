import 'package:environment_app/Land_Pollution/models/product_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:environment_app/Land_Pollution/Wishlist//boxes.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';
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

  bool isLiked = true;

  // @override
  // void dispose() {
  //   Hive.close();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    print (this.id);
    final id = this.id;

    final box = Boxes.getTransactions();
    // box.add(production);
    // box.put(this.id, production);
    // final mybox = Boxes.getTransactions();
    final myTransaction = box.get(id);
    isLiked = (myTransaction != null);

    print(isLiked);
    
    print(myTransaction?.key);
    print (myTransaction);
    print (box.keys);
    print (box.values);

    // mybox.values;
    // mybox.keys;

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
                                  image: NetworkImage((d as Map<String, dynamic>)['Image']?.toString() ?? ''),
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
                                                  LikeButton(
                                                    size: 20,
                                                    isLiked: isLiked,
                                                    onTap: (isLiked) async{
                                                      if(isLiked == true){

                                                        deleteTransaction();
                                                        print('product deleted');
                                                      }
                                                      else {
                                                        addTransaction(
                                                          (d as Map<
                                                              String,
                                                              dynamic>)['Name']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)['Categories']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)['Image']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)['Price']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)['short_desc']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)['desc']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)['size']
                                                              ?.toString() ??
                                                              '',
                                                        );

                                                        print('data saved');
                                                      }
                                                      return !isLiked;
                                                    },

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

  Future addTransaction(String name,String categorie, String imagrUrl,String size ,String desc ,String short_desc, String price) async {
    final production = Product()
      ..id = this.id
      ..Name = name
      ..Category = categorie
      ..Price = price
      ..Desc = desc
      ..ImageUrl = imagrUrl
      ..Short_Desc = short_desc
      ..Size =  size;
      // ..createdDate = DateTime.now()
      // ..amount = amount
      // ..isExpense = isExpense;

    final box = Boxes.getTransactions();
    // box.add(production);
    box.put(this.id, production);
    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editTransaction(
      Product production,
      String name,String categorie, String imagrUrl,String size,String desc,String short_desc, String price
      ) {
    production.id = this.id;
    production.Name = name;
    production.Price = price ;
    production.Category = categorie;
    production.ImageUrl = imagrUrl;
    production.Desc = desc;
    production.Short_Desc = short_desc;
    production.Size = size;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    production.save();
  }

  void deleteTransaction() {
    final box = Boxes.getTransactions();
    box.delete(this.id);

    // print(transaction.key);

    // transaction.delete();
    //setState(() => transactions.remove(transaction));
  }
}