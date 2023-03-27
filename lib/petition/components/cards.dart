import 'package:flutter/material.dart';

import 'package:environment_app/petition/widgets/genral_button.dart';

Widget buildCard({
  // 'Title':textNote,
  // 'Scope':textNote1,
  // 'Topic':textNote2,
  // 'Story':textNote3,
  // 'imgTitle': imgTitle,
  // 'pathurl': imageUrl,
  // 'location': location,
  required String title,
  required String scope,
  required String topic,
  required String story,
  required String imgTitle,
  required String pathurl,
  required String location,
  // required int support,
  void Function()? onPressed,
}) =>
    Container(
      width: 400,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(pathurl), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inria',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          scope,
          style: const TextStyle(
            fontFamily: 'Inria',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          topic,
          style: const TextStyle(
            fontFamily: 'Inria',
              fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          location,
          style: const TextStyle(
            fontFamily: 'Inria',
               fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        //     const SizedBox(
        //   height: 5,
        // ),
        // Text(
        //   support as String,
        //   style: const TextStyle(
        //     fontFamily: 'Inria',
        //        fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),

        GeneralButton(
         child: const Text('VIEW',
              style: TextStyle(
                backgroundColor: Color.fromARGB(255, 34, 255, 74),
                color: Color.fromARGB(255, 21, 20, 20),
             
                fontFamily: 'Inter',
              )),   onPressed: onPressed,
        
        ),
      ]),
    );
