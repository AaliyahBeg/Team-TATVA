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
  required String profilePic,
  required String username,
  List<dynamic>? support,
  // required int support,
  void Function()? onPressed,
}) =>
    Container(
      width: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(pathurl),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.6), BlendMode.dstATop),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(122, 0, 0, 0)),
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inria',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF96E072)),
                    child: Text(
                      scope,
                      style: const TextStyle(
                        fontFamily: 'Inria',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF96E072)),
                    child: Text(
                      topic,
                      style: const TextStyle(
                        fontFamily: 'Inria',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                location,
                style: const TextStyle(
                  fontFamily: 'Inria',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        support==null ? '0' : support.length.toString(),
                        style: const TextStyle(
                          fontFamily: 'Inria',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: GeneralButton(
                  child: const Text('VIEW',
                      style: TextStyle(
                        color: Color.fromARGB(255, 21, 20, 20),
                        fontFamily: 'Inter',
                        fontSize: 10,
                      )),
                  onPressed: onPressed,
                ),
              ),
            ]),
      ),
    );
