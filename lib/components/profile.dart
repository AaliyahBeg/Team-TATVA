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

class Profile extends StatefulWidget {
  final String uid;
  final String collection;
  const Profile({Key? key, required this.uid, required this.collection})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  String imageUrl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';
  bool imageUploaded = false;
  late Uint8List file;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection(widget.collection)
          .doc(widget.uid)
          .get();

      // get post lENGTH
      // var postSnap = await FirebaseFirestore.instance
      //     .collection('posts')
      //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      //     .get();

      // postLen = postSnap.docs.length;
      print("Error in next line");
      userData = userSnap.data()!;
      print("Userdata for uid=${widget.uid} = ${userData}");
      followers = userSnap.data()!['followers'];
      following = userSnap.data()!['following'];
      // isFollowing = userSnap
      //     .data()!['followers']
      //     .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        imageUrl = userSnap.data()!['photourl'];
        if (imageUrl.isNotEmpty) imageUploaded = true;
      });
    } catch (e) {
      showSnackBar(
        context,
        "The Error in Profile is" + e.toString(),
      );
    }
    if (userData != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  selectImage() async {
    file = await pickImage(ImageSource.gallery);
    String photoUrl =
        await StorageMethods().uploadImageToStorage('profilePics', file, false);
    setState(() {
      imageUrl = photoUrl;
      imageUploaded = true;
    });
    await FirebaseFirestore.instance
        .collection(widget.collection)
        .doc(widget.uid)
        .update({'photourl': photoUrl});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(110.0),
              child: PrimaryAppBar(page: 'homepage',),
            ),
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(110.0),
              child: PrimaryAppBar(page: 'homepage',),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(imageUrl),
                            radius: 40,
                          ),
                          GeneralButton(
                              onPressed: selectImage,
                              child: Text(
                                  imageUploaded ? 'Edit Image' : 'Upload Image',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                  )))
                        ],
                      ),
                      SizedBox(height: 15),
                      //UserName
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text(
                          userData['name'] == null ? 'User' : userData['name'],
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
                          buildStatColumn(following, "following"),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatColumn(postLen, "posts"),
                          buildStatColumn(followers, "petitions")
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
                                          userData['uid'],
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
                                          userData['uid'],
                                        );

                                        setState(() {
                                          isFollowing = true;
                                          followers++;
                                        });
                                      },
                                    )
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 1,
                        ),
                        child: Text(widget.collection == 'users'
                            ? userData['bio'] == null
                                ? 'Your Bio'
                                : userData['bio']
                            : userData['mission'] == null
                                ? 'Your Mission'
                                : userData['mission']),
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