import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:environment_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:environment_app/petition/petition_2_.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/petition/utils/utils.dart';
import 'package:environment_app/petition/screen/add_post_screen.dart';
import 'package:environment_app/petition/utils/dimensions.dart';
class Addpost extends StatefulWidget {
  Addpost({Key? key}) : super(key: key);

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {


    



  @override
  State<Addpost> createState() => _AddpostState();
    int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

   



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
        children:
         homeScreenItems ,

        

        physics: NeverScrollableScrollPhysics(),

        controller: pageController,
        // onPageChanged: onPageChanged,
      ),
 



      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _page == 0 ? Colors.green : Colors.black),
            label: '',
            backgroundColor: Colors.black,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search,
          //       color: _page == 1 ? Colors.green : Colors.black),
          //   label: '',
          //   backgroundColor: Colors.black,
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
                color: _page == 2 ? Colors.green : Colors.black),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: _page == 3 ? Colors.green : Colors.black),
            label: '',
            backgroundColor: Colors.black,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person,
          //       color: _page == 4 ? Colors.green : Colors.black),
          //   label: '',
          //   backgroundColor: Colors.black,
          // ),
        ],

         onTap:navigationTapped,
      ),
    );
  }
}





























