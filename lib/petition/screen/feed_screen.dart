import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:environment_app/petition/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.green,
     
        title: const Text("Ongoing Petition"),
        centerTitle: false,

        actions:[
          IconButton(
            onPressed: (){}, 
            icon: const Icon(
              Icons.messenger_outline,
            )
            )
        ],
    ),
    body:PostCard(),
    );
  }
}