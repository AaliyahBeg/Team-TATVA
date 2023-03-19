import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/components/primary_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/Connect/dbResources/firestore_methods.dart';
import 'package:environment_app/login.dart';
import 'package:environment_app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../Connect/dbResources/storage_methods.dart';
import '../services/authFunctions.dart';
import '../widgets/general_button.dart';

class OrganizationProfile extends StatefulWidget {
  final String uid;
  final String collection;
  int followers;
  int following;
  String imageUrl;
  String name;
  String? mission;
  OrganizationProfile(
      {Key? key,
      required this.uid,
      required this.collection,
      this.imageUrl =
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
      required this.followers,
      required this.following,
      required this.name,
      this.mission})
      : super(key: key);

  @override
  _OrganizationProfileState createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int petitions = 0;
  bool isFollowing = false;
  bool isLoading = false;
  late Uint8List file;
  @override
  void initState() {
    super.initState();
    setState(() {
      followers = widget.followers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(110.0),
              child: PrimaryAppBar(page: 'connect',),
            ),
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(110.0),
              child: PrimaryAppBar(page: 'connect',),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(widget.imageUrl),
                        radius: 40,
                      ),
                      SizedBox(height: 15),
                      //UserName
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text(
                          widget.name == null ? 'User' : widget.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15),

                      //Followers, Following, Posts
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatColumn(followers, "followers"),
                          buildStatColumn(widget.following, "following"),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatColumn(postLen, "posts"),
                          buildStatColumn(petitions, "petitions")
                        ],
                      ),
                      SizedBox(height: 15),

                      //Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              ? GeneralButton(
                                  child: Text('Sign Out',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inter',
                                      )),
                                  onPressed: () async {
                                    await AuthServices.signOut();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  },
                                )
                              : isFollowing
                                  ? GeneralButton(
                                      child: Text('Unfollow',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                          )),
                                      onPressed: () async {
                                        await FireStoreMethods().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          widget.uid,
                                        );

                                        setState(() {
                                          isFollowing = false;
                                          followers--;
                                        });
                                      },
                                    )
                                  : GeneralButton(
                                      child: Text('Follow',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                          )),
                                      onPressed: () async {
                                        await FireStoreMethods().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          widget.uid,
                                        );

                                        setState(() {
                                          isFollowing = true;
                                          followers++;
                                        });
                                      },
                                    )
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("OUR MISSION",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inria',
                          )),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 1,
                        ),
                        child: Text(
                          widget.mission == null
                              ? 'Your Mission'
                              : widget.mission!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // FutureBuilder(
                //   future: FirebaseFirestore.instance
                //       .collection('posts')
                //       .where('uid', isEqualTo: widget.uid)
                //       .get(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }

                //     return GridView.builder(
                //       shrinkWrap: true,
                //       itemCount: (snapshot.data! as dynamic).docs.length,
                //       gridDelegate:
                //           const SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 3,
                //         crossAxisSpacing: 5,
                //         mainAxisSpacing: 1.5,
                //         childAspectRatio: 1,
                //       ),
                //       itemBuilder: (context, index) {
                //         DocumentSnapshot snap =
                //             (snapshot.data! as dynamic).docs[index];

                //         return Container(
                //           child: Image(
                //             image: NetworkImage(snap['postUrl']),
                //             fit: BoxFit.cover,
                //           ),
                //         );
                //       },
                //     );
                //   },
                // )
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inria'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontFamily: 'Inria'),
          ),
        ),
      ],
    );
  }
}
