import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:environment_app/Connect/components/models/user.dart' as model;
import 'package:environment_app/Connect/components/providers/user_provider.dart';
import 'package:environment_app/services/firestore_methods.dart';

import 'package:environment_app/utils/global_variables.dart';
import 'package:environment_app/utils/utils.dart';
import 'package:environment_app/widgets/support_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Connect/comments.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool issupportAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
          ),
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.3,
              0.75,
              0.9
            ],
            colors: [
              const Color(0xFFE8FCCF),
              Color.fromARGB(255, 181, 229, 157),
              Color.fromARGB(255, 154, 219, 175),
            ]),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                // User Profile Pic, Username and Date
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['username'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          ),

          //Description

          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: ' ${widget.snap['description']}',
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onDoubleTap: () {
              FireStoreMethods().supportPost(
                widget.snap['postId'].toString(),
                user!.uid,
                widget.snap['supports'],
              );
              setState(() {
                issupportAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black38),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image.network(
                      widget.snap['postUrl'].toString(),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: issupportAnimating ? 1 : 0,
                  child: SupportAnimation(
                    isAnimating: issupportAnimating,
                    child: const Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                      size: 100,
                    ),
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        issupportAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SupportAnimation(
                isAnimating: widget.snap['supports'].contains(user!.uid),
                smallSupport: true,
                child: IconButton(
                  icon: widget.snap['supports'].contains(user!.uid)
                      ? const Icon(
                          Icons.thumb_up,
                          color: Color.fromARGB(255, 13, 74, 4),
                        )
                      : const Icon(
                          Icons.thumb_up_outlined,
                        ),
                  onPressed: () => FireStoreMethods().supportPost(
                    widget.snap['postId'].toString(),
                    user.uid,
                    widget.snap['supports'],
                  ),
                ),
              ),
              DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snap['supports'].length} supports',
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                        ),
                        onPressed: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CommentsScreen(
                                    postId: widget.snap['postId'].toString(),
                                  ),
                                ),
                              ),
                            }),
                    InkWell(
                        child: Container(
                          child: Text(
                            '$commentLen comments',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                        ),
                        onTap: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CommentsScreen(
                                    postId: widget.snap['postId'].toString(),
                                  ),
                                ),
                              ),
                            }),
                            
                widget.snap['uid'].toString() == user!.uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      'Delete',
                                    ]
                                        .map(
                                          (e) => InkWell(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Text(e),
                                              ),
                                              onTap: () {
                                                deletePost(
                                                  widget.snap['postId']
                                                      .toString(),
                                                );

                                                Navigator.of(context).pop();
                                              }),
                                        )
                                        .toList()),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : Container(),
                  ],
                  
                ),
                
              )),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}
