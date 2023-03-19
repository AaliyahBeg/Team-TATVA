import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  void Function()? onPressed;
  Widget child;
  GeneralButton({Key? key, this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(const BorderSide(
            width: 1.0, color: Color.fromARGB(133, 54, 61, 68))),
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF96E072)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 20)),
      ),
      child: child,
    );
  }
}
