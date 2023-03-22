import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/Connect/add_post.dart';
import 'package:environment_app/Connect/feed_screen.dart';

import '../components/profile.dart';
// import 'package:environment_app/Connect/search_screen.dart';

const webScreenSize = 600;
String uid = FirebaseAuth.instance.currentUser!.uid;
List<Widget> homeScreenItems = [
  const FeedScreen(),
  // const SearchScreen(),
  AddPostScreen(),
  const Text('notifications'),
  Profile(
    uid: uid,
    collection: 'organizations',
  ),
];
