import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/Land_Pollution/Wishlist/wishlist_block.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class WishlistProvider with ChangeNotifier{
  Map<String , WishlistModel> _wishlistItems ={};

  Map<String , WishlistModel> get getWishlistItems{
    return _wishlistItems;
  }
}

final userCollection = FirebaseFirestore.instance.collection('uers');
Future<void> fetchWishlist() async{
  final User? user
}