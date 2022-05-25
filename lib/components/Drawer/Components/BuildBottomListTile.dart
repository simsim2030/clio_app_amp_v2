import 'package:flutter/material.dart';

Widget buildBottomListTile(
  String title,
  IconData icon,
  VoidCallback tapHandler,
) {
  return ListTile(
    leading: Icon(
      icon,
      size: 25,
    ),
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    onTap: tapHandler,
  );
}
