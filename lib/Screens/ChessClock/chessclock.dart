import 'package:clio_chess_amp_v2/Screens/ChessClock/components/chessclock_body.dart';
import 'package:flutter/material.dart';

class ChessClockPage extends StatelessWidget {
  static const routeName = '/chessclock_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: ChessClockBody(),
    );
  }
}
