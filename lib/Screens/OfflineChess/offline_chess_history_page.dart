import 'dart:math';
import 'package:clio_chess_amp_v2/chess/utils.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

import '../../components/Drawer/main_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart'
    as cb;

class OfflineChessPageHistory extends StatefulWidget {
  static const routeName = '/Offline_chess_page_history';
  @override
  _OfflineChessHistoryState createState() => _OfflineChessHistoryState();
}

class _OfflineChessHistoryState extends State<OfflineChessPageHistory> {
  String _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    final size = min(viewport.height, viewport.width);

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Chessboard"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: cb.Chessboard(
          fen: _fen,
          size: size,
          orientation: cb.BoardColor.WHITE,
          onMove: (move) {
            final nextFen = makeMove(_fen, {
              'from': move.from,
              'to': move.to,
              'promotion': 'q',
            });
          },
        ),
      ),
    );
  }
}
