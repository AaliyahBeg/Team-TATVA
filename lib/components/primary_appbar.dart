import 'package:environment_app/components/hamburger_menu.dart';
import 'package:environment_app/components/profile.dart';
import 'package:environment_app/components/secondary_appbar.dart';
import 'package:environment_app/widgets/general_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrimaryAppBar extends StatefulWidget {
  String page;
  PrimaryAppBar({super.key, required this.page});

  @override
  State<PrimaryAppBar> createState() => _PrimaryAppBarState();
}

class _PrimaryAppBarState extends State<PrimaryAppBar> {
  String userDP =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';

  @override
  Widget build(BuildContext context) {
    fillAccountList(context);
    GeneralButton dropdownValue = accountDropdown[0];
    return AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('TATVA',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: Colors.black,
            )),
        leading: Icon(
          Icons.energy_savings_leaf_rounded,
          color: Colors.black,
          size: 35,
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(width: 15),
          DropdownButtonHideUnderline(
            child: ButtonTheme(
              child: PopupMenuButton<GeneralButton>(
                icon: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(userDP),
                  radius: 30,
                ),
                onSelected: (GeneralButton? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                  // getAPI();
                },
                itemBuilder: (BuildContext context) => accountDropdown
                    .map<PopupMenuItem<GeneralButton>>((GeneralButton value) {
                  return PopupMenuItem<GeneralButton>(
                    value: value,
                    child: value,
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
        bottom: PreferredSize(
          child: SecondaryAppbar(
            page: widget.page,
          ),
          preferredSize: const Size.fromHeight(48.0),
        ));
  }
}
