import 'dart:ffi';

import 'package:flutter/material.dart';

class TapButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color textColor;

  const TapButton({
    Key? key,
    required this.text,
    this.textColor = Colors.blueGrey,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
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
