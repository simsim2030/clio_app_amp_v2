import 'package:flutter/material.dart';

class TapButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color textColor;

  const TapButton({
    Key key,
    this.text,
    this.press,
    this.textColor = Colors.blueGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}