import 'package:flutter/material.dart';

Widget buildMainListTile(
  String title,
  IconData icon,
  VoidCallback tapHandler,
) {
  return ListTile(
    leading: Icon(
      icon,
      size: 26,
      color: Colors.white,
    ),
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    onTap: tapHandler,
  );
}
