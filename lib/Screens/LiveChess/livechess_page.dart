import 'package:clio_chess_amp_v2/Screens/Home/home_page.dart';
import 'package:flutter/material.dart';

class LiveChess extends StatefulWidget {
  static const routeName = '/livechess_page';

  @override
  State<LiveChess> createState() => _LiveChessState();
}

class _LiveChessState extends State<LiveChess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chess'),
      ),
      body: Center(
        child: Text(
          'TODO: Live Chess',
        ),
      ),
    );
  }
}
