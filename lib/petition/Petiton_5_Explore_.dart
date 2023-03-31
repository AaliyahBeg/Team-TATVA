import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:environment_app/petition/utils/utils.dart';
// import 'package:environment_app/components/primary_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:environment_app/services/firestore_methods.dart';
import 'package:environment_app/login.dart';
// import 'package:environment_app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:environment_app/petition/petitions_1_.dart';
import 'package:like_button/like_button.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

// import '../services/storage_methods.dart';
import '../components/primary_appbar.dart';
import '../services/authFunctions.dart';
import '../services/firestore_methods.dart';
import '../widgets/support_animation.dart';
import 'package:intl/intl.dart';
// import '../widgets/general_button.dart';

class Profile extends StatefulWidget {
  final String docid;
  Profile({Key? key, required this.docid}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? desc;
  var petitionData = {};
  bool isLoading = true;
  String Title = 'Title',
      Scope = 'Scope',
      Topic = 'Topic',
      Story = 'Story',
      location = 'location',
      profilePic = '',
      username = 'user';
  var date;
  List<dynamic> Support = [];

  String pathurl =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";
  late Uint8List file;
  int? numberOflikes = 120;
  bool? isLiked = false;
  int? count;
  String? text;

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
      var petitionSnap = await FirebaseFirestore.instance
          .collection('Petition')
          .doc(widget.docid)
          .get();
      petitionData = petitionSnap.data()!;
      Title = petitionSnap.data()!['Title'];
      Scope = petitionSnap.data()!['Scope'];
      Story = petitionSnap.data()!['Story'];
      location = petitionSnap.data()!['location'];
      pathurl = petitionSnap.data()!['pathurl'];
      Support = petitionSnap.data()!['support'];
      profilePic = petitionSnap.data()!['profilePic'];
      username = petitionSnap.data()!['username'];
      date = petitionSnap.data()!['datePublished'];
    } catch (e) {
      showSnackBar(
        context,
        "The Error in Profile is: " + e.toString(),
      );
    }
    if (petitionData != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: PreferredSize(
              child: PrimaryAppBar(
                page: 'petitions',
              ),
              preferredSize: const Size.fromHeight(110.0),
            ),
            body: const Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: PreferredSize(
              child: PrimaryAppBar(
                page: 'petitions',
              ),
              preferredSize: const Size.fromHeight(110.0),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: ListView(children: [
//
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    'ONGOING PETITIONS',
                    style: TextStyle(
                      fontFamily: 'Inria',
                      fontSize: 22,
                    ),
                  ),
                ),

                SizedBox(height: 1),

                // LikeButton(
                //   size: 60,
                //   likeCount: numberOflikes,
                //   isLiked: isLiked,
                //   countPostion: CountPostion.bottom,
                //   likeBuilder: (isLiked) {
                //     final color = isLiked
                //         ? Colors.green
                //         : Color.fromARGB(255, 228, 221, 165);

                //     return Icon(Icons.favorite,
                //         color: color, size: 60);
                //   },
                //   likeCountPadding: EdgeInsets.only(left: 12),
                //   countBuilder: (count, isLiked, text) {
                //     final color =
                //         isLiked ? Colors.black : Colors.grey;

                //     return Text(
                //       text,
                //       style: TextStyle(
                //         color: color,
                //         fontSize: 34,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     );
                //   },
                //   onTap: (isLiked) async {
                //     numberOflikes =
                //         numberOflikes! + ((this.isLiked!) ? 1 : -1);

                //     this.isLiked = !isLiked;

                //     return !isLiked;
                //   },
                // ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(41),
                    border: Border.all(
                      width: 1,
                      color: Colors.black54,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 23,
                        color: Color.fromARGB(146, 0, 0, 0),
                        // spreadRadius: 11,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(profilePic),
                                  radius: 20,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  username,
                                  style: const TextStyle(
                                    fontFamily: 'Inria',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                    DateFormat.yMMMd()
                        .format(date.toDate()),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(Title,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inria',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(pathurl),
                                fit: BoxFit.cover)),
                        child: Container(width: 180, height: 180),
                      ),
                      SizedBox(height: 20),
                      Divider(
                        thickness: 1,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFF96E072)),
                              child: Text(Scope,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Inria',
                                    fontSize: 13,
                                  )),
                            ),
                            SizedBox(width: 20),
                            VerticalDivider(thickness: 1),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFF96E072)),
                              child: Text(location,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Inria',
                                    fontSize: 13,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(
                        thickness: 1,
                      ),
                      Text(Story,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inria',
                            fontSize: 13,
                          )),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SupportAnimation(
                            isAnimating: Support.contains(
                                FirebaseAuth.instance.currentUser!.uid),
                            smallSupport: true,
                            child: IconButton(
                                icon: Support.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? const Icon(
                                        Icons.thumb_up,
                                        color: Color.fromARGB(255, 13, 74, 4),
                                      )
                                    : const Icon(
                                        Icons.thumb_up_outlined,
                                      ),
                                onPressed: () {
                                  FireStoreMethods().supportPetition(
                                    widget.docid,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    Support,
                                  );
                                  if (Support.contains(FirebaseAuth
                                          .instance.currentUser!.uid) ==
                                      false)
                                    setState(() {
                                      Support.add(FirebaseAuth
                                          .instance.currentUser!.uid);
                                    });
                                  else {
                                    setState(() {
                                      Support.remove(FirebaseAuth
                                          .instance.currentUser!.uid);
                                    });
                                  }
                                  ;
                                }),
                          ),
                          DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontWeight: FontWeight.w800),
                              child: Text(
                                '${Support.length} supports',
                                style: Theme.of(context).textTheme.bodyText2,
                              )),
                        ],
                      ),
                    ],
                  ),
                ) //
              ]),
            ),
          );
  }
}
