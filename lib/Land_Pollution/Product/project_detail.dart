import 'package:environment_app/Land_Pollution/models/product_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:environment_app/Land_Pollution/Wishlist//boxes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:environment_app/Land_Pollution/Cart_Add//CartBoxes.dart';

class thumb extends StatefulWidget {
  final id;
  thumb(this.id);

  @override
  State<StatefulWidget> createState() {
    print(id);
    return ProductDetailsPage(id: id);
  }
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ProductDetailsPage extends State<thumb> {

  // void show(){
  // showDialog(
  //     context: context,
  //     builder: (context){
  //       return RatingDia
  //     }
  // );
  // }

  var _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Payment Successfully done');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment Fail');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  // static const routeName = '/project_detail';
  final String id;
  ProductDetailsPage({required this.id});

  bool isLiked = true;
  bool isCart = true;

  @override
  Widget build(BuildContext context) {
    print(this.id);
    final id = this.id;

    final box = Boxes.getTransactions();
    final myTransaction = box.get(id);
    isLiked = (myTransaction != null);

    print(isLiked);
    print(myTransaction?.key);
    print(myTransaction);
    print(box.keys);
    print(box.values);

      print(this.id);
      final cart_id = this.id;

      final cart_box = cart_Item.getCart();
      final myCart = cart_box.get(cart_id);
    isCart = (myCart != null);
    print(myCart?.key);
    print(myCart);
    print(cart_box.keys);
    print(cart_box.values);


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: firestore.collection('product').doc(id).get(),
            builder: (context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                snapshot) {
              var s = snapshot;
              var d =
              (s as AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>)
                  .data
                  ?.data();
              print(snapshot.runtimeType);
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/2,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      (d as Map<String, dynamic>)['Image']
                                          ?.toString() ??
                                          ''),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          top: 320,
                          child: Center(
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (d as Map<String, dynamic>)['Name']
                                              ?.toString() ??
                                              'not found',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          (d as Map<String, dynamic>)[
                                          'short_desc']
                                              ?.toString() ??
                                              'not found',
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
                                              (d as Map<String, dynamic>)[
                                              'Rating']
                                                  ?.toString() ??
                                                  '4.0',
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
                                                    onTap: (isLiked) async {
                                                      if (isLiked == true) {
                                                        deleteTransaction();
                                                        print(
                                                            'product deleted');
                                                      } else {
                                                        addTransaction(
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'Name']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'Categories']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'Image']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'Price']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'short_desc']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'desc']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'size']
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
                                                        color:
                                                        Color(0xff919296),
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color(0xF6F3F3E4),
                                                  borderRadius:
                                                  BorderRadius.circular(8)),
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
                                                  LikeButton(
                                                    size: 20,
                                                    isLiked: isCart,
                                                    likeBuilder: (isCart){
                                                      return Icon(
                                                        Icons.shopping_cart,
                                                        // color: Colors.green,
                                                      );
                                                    },
                                                    onTap: (isCart) async {
                                                      if (isCart == true) {
                                                        deleteCart();
                                                        print(
                                                            'product deleted');
                                                      } else {
                                                        addCart(
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'Name']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'Categories']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'Image']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'Price']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'short_desc']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'desc']
                                                              ?.toString() ??
                                                              '',
                                                          (d as Map<
                                                              String,
                                                              dynamic>)[
                                                          'size']
                                                              ?.toString() ??
                                                              '',
                                                        );

                                                        print('data saved');
                                                      }
                                                      return !isCart;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "Cart",
                                                    style: TextStyle(
                                                        color:
                                                        Color(0xff919296),
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color(0xF6F3F3E4),
                                                  borderRadius:
                                                  BorderRadius.circular(8)),
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
                            (d as Map<String, dynamic>)["desc"]?.toString() ??
                                'not found',
                            style: TextStyle(
                                color: Color(0xff919296), fontSize: 15),
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
                                        (d as Map<String, dynamic>)['Price']
                                            ?.toString() ??
                                            'not found',
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
                                    backgroundColor: Colors.green[500],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    /// Make payment
                                    var options = {
                                      'key': 'rzp_test_UScfYQh4DskA20',
                                      'amount': (int.parse((d as Map<String,
                                          dynamic>)['Price']) * 100)
                                          ?.toString() ??
                                          'not found',
                                      //in the smallest currency sub-unit.
                                      'name': (d as Map<String,
                                          dynamic>)['Name']?.toString() ??
                                          'not found',
                                      // 'order_id': 'order_EMBFqjDHEEn80l',
                                      'description': (d as Map<String,
                                          dynamic>)["desc"]?.toString() ??
                                          'not found',
                                      'timeout': 300,
                                      // in seconds
                                      'prefill': {
                                        'contact': '',
                                        'email': '',
                                      }
                                    };
                                    _razorpay.open(options);
                                  },
                                  child: Text(
                                    "Buy Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              ButtonTheme(
                                minWidth: 200,
                                height: 70,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    // show();
                                  },
                                  child: Text(
                                    "Rate Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),

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
    double sigmaX = 5,
    double sigmaY = 5,
  }) =>
      ClipRRect(
        borderRadius: borderRadius ??
            BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(25)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: child,
        ),
      );

  Future addTransaction(String name, String categorie, String imagrUrl,
      String price, String desc, String short_desc, String size) async {
    final production = Product()
      ..id = this.id
      ..Name = name
      ..Category = categorie
      ..Price = price
      ..Desc = desc
      ..ImageUrl = imagrUrl
      ..Short_Desc = short_desc
      ..Size = size;

    final box = Boxes.getTransactions();
    box.put(this.id, production);

  }


  Future addCart(String name, String categorie, String imagrUrl,
      String price, String desc, String short_desc, String size) async {
    final Cart = Product()
      ..id = this.id
      ..Name = name
      ..Category = categorie
      ..Price = price
      ..Desc = desc
      ..ImageUrl = imagrUrl
      ..Short_Desc = short_desc
      ..Size = '1';
    // ..createdDate = DateTime.now()
    // ..amount = amount
    // ..isExpense = isExpense;

    final cart_box = cart_Item.getCart();
    // box.add(production);
    cart_box.put(this.id, Cart);
    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editTransaction(
      Product production,
      String name,
      String categorie,
      String imagrUrl,
      String size,
      String desc,
      String short_desc,
      String price) {
    production.id = this.id;
    production.Name = name;
    production.Price = price;
    production.Category = categorie;
    production.ImageUrl = imagrUrl;
    production.Desc = desc;
    production.Short_Desc = short_desc;
    production.Size = size;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    production.save();
  }

  void editCart(
      Product cart,
      String name,
      String categorie,
      String imagrUrl,
      String size,
      String desc,
      String short_desc,
      String price
      ) {
    cart.id = this.id;
    cart.Name = name;
    cart.Price = price;
    cart.Category = categorie;
    cart.ImageUrl = imagrUrl;
    cart.Desc = desc;
    cart.Short_Desc = short_desc;
    cart.Size = size;


    cart.save();
  }

  void deleteTransaction() {
    final box = Boxes.getTransactions();
    box.delete(this.id);

  }

  void deleteCart(){
    final cart_box = cart_Item.getCart();
    cart_box.delete(this.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
}
