import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  static const routeName = '/history_page';
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Games'),
      ),
      body: Center(
        child: Text(
          'TODO: History List',
        ),
      ),
    );
  }
}
