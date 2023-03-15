import 'package:environment_app/components/secondary_appbar.dart';
import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget {
  const PrimaryAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('TATV',
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
          SizedBox(width: 15),
        ],
        bottom: PreferredSize(
          child: SecondaryAppbar(),
          preferredSize: const Size.fromHeight(48.0),
        ));
  }
}
