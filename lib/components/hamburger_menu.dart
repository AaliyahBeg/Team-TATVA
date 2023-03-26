import 'package:environment_app/components/profile.dart';
import 'package:environment_app/services/authFunctions.dart';
import 'package:environment_app/widgets/general_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/authFunctions.dart';
import '../login.dart';

List<GeneralButton> accountDropdown = [];
void fillAccountList(BuildContext context) {
  accountDropdown = [
    GeneralButton(
        onPressed: () => Navigator.pushNamed(context, 'profile'),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(width: 5),
            const Text("My Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 10,
                ))
          ],
        )),
    GeneralButton(
        onPressed: () => {Navigator.pushNamed(context, 'settings')},
        child: Row(
          children: [
            const Icon(
              Icons.settings,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(width: 5),
            const Text("Settings",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 10,
                ))
          ],
        )),
    GeneralButton(
        onPressed: () => {
              () async {
                await AuthServices.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            },
        child: Row(
          children: [
            const Icon(
              Icons.logout,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(width: 5),
            const Text("Logout",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 10,
                ))
          ],
        )),
  ];
}
