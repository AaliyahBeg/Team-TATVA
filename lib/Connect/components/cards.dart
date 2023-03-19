import 'package:flutter/material.dart';

import '../../widgets/general_button.dart';

Widget buildCard({
  required String profileImage,
  required String username,
  required int followers,
  void Function()? onPressed,
  Color color = const Color.fromARGB(255, 218, 242, 206),
  Color borderColor = const Color.fromARGB(0, 218, 242, 206),
}) =>
    Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: borderColor),
      ),
      width: 150,
      // height: 200,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(profileImage),
            radius: 30,
            backgroundColor: const Color.fromARGB(106, 0, 0, 0),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            username,
            style: const TextStyle(
              fontFamily: 'Inria',
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person),
              const SizedBox(
                height: 10,
              ),
              Text(
                followers.toString(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 50, 45, 45),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          GeneralButton(
            onPressed: onPressed,
            child: const Text('More',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                )),
          ),
        ],
      ),
    );
