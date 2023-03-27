import 'dart:ui';
import 'package:environment_app/Land_Pollution/Cart_Add//CartBoxes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Land_Pollution/Product/Products.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/Land_Pollution/models/product_model.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final box = cart_Item.getCart();
    List<Product> item = box.values.toList();
    var count = item.length;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Shopping Cart',
            style: TextStyle(
              fontFamily: 'Inria',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.black26,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, //number of columns
            childAspectRatio: 3, // aspect ratio of the grid cells
            crossAxisSpacing: 0.5, // horizontal spacing between cells
            mainAxisSpacing: 2, // vertical spacing between cells
          ),
          shrinkWrap: true,
          itemCount: count,
          itemBuilder: (context, index) {
            String name = item[index].Name;
            String imageUrl = item[index].ImageUrl;
            String Price = item[index].Price;

            return Column(
              children: [
                Container(
                  color: Color(0xF6F3F3E4),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 80.0,
                        height: 80.0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[300],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:/// image from data
                                    NetworkImage(imageUrl),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              child: Text(
                                name,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.minimize,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[500],
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  /// price data from backend,
                                  "\u20b9" + Price,
                                  style: TextStyle(color: Colors.black),
                                ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //   ],
                // ),
              ],
            );
          },
        ));
  }
}
