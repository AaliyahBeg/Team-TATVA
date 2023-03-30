import 'dart:ui';
import 'package:environment_app/Land_Pollution/Cart_Add//CartBoxes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Land_Pollution/Product/Products.dart';
import 'package:environment_app/components/card_items.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/Land_Pollution/models/product_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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

  void _increment(String index, Product product) {
    final cart_box = cart_Item.getCart();
    cart_box.put(index, product);
  }

  int TotalPrice = 0;

  late List<Product> item;

  int total() {
    int TPrice = 0;
    for (int i = 0; i < item.length; i++) {
      TPrice += (int.parse(item[i].Price) * (int.parse(item[i].Size)));
    }
    return TPrice;
  }

  @override
  Widget build(BuildContext context) {
    final box = cart_Item.getCart();
    item = box.values.toList();
    var count = item.length;

    TotalPrice = total();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            fontFamily: 'Inria',
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
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
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
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
                String Size = item[index].Size;
                String id = item[index].id;

                return Column(
                  children: [
                    Container(
                      color: Color(0xF6F3F3E4),
                      // decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20.0),
                      // ),
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
                                    image:

                                        /// image from data
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
                                    style: TextStyle(
                                        fontFamily: 'Inria',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            final Cart = Product()
                                              ..id = id
                                              ..Name = name
                                              ..Category = ''
                                              ..Price = item[index].Price

                                              ///(int.parse()/(int.parse(item[index].Size))).toString()
                                              ..Desc = ''
                                              ..ImageUrl = imageUrl
                                              ..Short_Desc = ''
                                              ..Size =
                                                  (int.parse(item[index].Size) -
                                                          1)
                                                      .toString();
                                            _increment(id, Cart);
                                            item = box.values.toList();
                                            print('size of remove' +
                                                item[index].Size);
                                            TotalPrice = total();

                                            if (int.parse(item[index].Size) >
                                                0) {
                                              // Check if Size is greater than 1
                                              _increment(id, Cart);
                                            } else {
                                              deleteCart(id);
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.remove)),
                                    Text(
                                      item[index].Size,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                        icon: new Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            final Cart = Product()
                                              ..id = id
                                              ..Name = name
                                              ..Category = ''
                                              ..Price = item[index].Price

                                              ///(int.parse(item[index].Price)
                                              ..Desc = ''
                                              ..ImageUrl = imageUrl
                                              ..Short_Desc = ''
                                              ..Size =
                                                  (int.parse(item[index].Size) +
                                                          1)
                                                      .toString();
                                            _increment(id, Cart);
                                            item = box.values.toList();
                                            print('size of add' +
                                                item[index].Size);
                                            print('size of price' +
                                                item[index].Price);
                                            TotalPrice = total();
                                          });
                                        }),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Text(
                                      /// price data from backend,
                                      "\u20b9" +
                                          (int.parse(item[index].Price) *
                                                  (int.parse(item[index].Size)))
                                              .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Inria',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    SizedBox(height: 21.0),
                                    Divider(),
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
            ),
          ),
          SizedBox(
              height: 10.0,

          ),
          Text(
            'Total Amount' +"\u20b9"+ TotalPrice.toString(),
            style: TextStyle(
                fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          MaterialButton(
            onPressed: () {
              var options = {
                'key': 'rzp_test_UScfYQh4DskA20',
                'amount': (TotalPrice * 100)?.toString() ?? 'not found',
                'name': ('Total Cart Amount'),
                'description': '',
                'timeout': 300,
                'prefill': {
                  'contact': '',
                  'email': '',
                },
              };
              _razorpay.open(options);
            },
            height: 50.0,
            minWidth: 300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.green[500],
            child: Text(
              'Buy Now',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  void deleteCart(String id) {
    final cart_box = cart_Item.getCart();
    cart_box.delete(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
}
