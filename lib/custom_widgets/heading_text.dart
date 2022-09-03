import 'package:flutter/material.dart';



class headingtext extends StatelessWidget {
  var text1;
  headingtext(text) {
    text1 = text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Text(text1,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: "Varela",
                  fontSize: 28)),
        ),
      ],
    );
  }
}
