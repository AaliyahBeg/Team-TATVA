import 'package:environment_app/Land_Pollution/Product/sellProduct.dart';
import 'package:environment_app/Land_Pollution/Wishlist/Wishlist_item.dart';
import 'package:flutter/material.dart';
import 'list_of_product.dart';
import 'package:environment_app/Land_Pollution/Product/copy_Products.dart';


import 'project_detail.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    wishItem(),
    DataSetInputScreen(),
  ];

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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          // selectedItemColor: Color(0x95DE71FF),
          selectedItemColor: Colors.green,
          unselectedItemColor: Color(0xff4d4f52),
          showSelectedLabels: true,
          showUnselectedLabels: true,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "WisList"),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: "Cart"),
          ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,

        ),
      ),

    );
  }
}
