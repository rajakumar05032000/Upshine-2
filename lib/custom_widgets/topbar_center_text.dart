import 'package:flutter/material.dart';

class topbar_center_text extends StatelessWidget {
  var givenText;
  topbar_center_text(text1) {
    givenText = text1;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      givenText,
      style: TextStyle(
          fontSize: 22.0,
          fontFamily: "Varela",
          color: Color.fromARGB(255, 129, 126, 126),
          fontWeight: FontWeight.w700),
    );
  }
}
