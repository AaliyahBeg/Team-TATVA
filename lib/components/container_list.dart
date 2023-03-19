import 'package:environment_app/services/authFunctions.dart';
import 'package:environment_app/widgets/general_button.dart';
import 'package:flutter/material.dart';

import '../Connect/dbResources/auth_methods.dart';
import '../login.dart';

List<GeneralButton> accountDropdown = [];
void fillAccountList(BuildContext context) {
  accountDropdown = [
    GeneralButton(
        onPressed: () => {Navigator.pushNamed(context, 'profile')},
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.black,
              size: 30,
            ),
            const SizedBox(height: 5),
            const Text("My Profile")
          ],
        )),
    GeneralButton(
        onPressed: () => {Navigator.pushNamed(context, 'settings')},
        child: Row(
          children: [
            const Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
            const SizedBox(height: 5),
            const Text("Settings")
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
              size: 30,
            ),
            const SizedBox(height: 5),
            const Text("Logout")
          ],
        )),
  ];
}
