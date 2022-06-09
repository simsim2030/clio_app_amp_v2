import 'dart:math';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

import '../../components/Drawer/main_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart'
    as cb;

import '../../chess/utils.dart';

class OfflineChessPage extends StatefulWidget {
  static const routeName = '/Offline_chess_page';
  @override
  _OfflineChessState createState() => _OfflineChessState();
}

class _OfflineChessState extends State<OfflineChessPage> {
  String _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    final size = min(viewport.height, viewport.width);

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text("Chessboard"),
      ),
      body: Center(
        child: cb.Chessboard(
          fen: _fen,
          size: size,
          onMove: (move) {
            final nextFen = makeMove(_fen, {
              'from': move.from,
              'to': move.to,
              'promotion': 'b',
            });

            if (nextFen != null) {
              setState(() {
                _fen = nextFen;
              });
            }
          },
          onPromote: () {
            return showDialog<PieceType>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Promotion'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text("Queen"),
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          title: Text("Rook"),
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          title: Text("Bishop"),
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          title: Text("Knight"),
                          onTap: () => Navigator.pop(context, PieceType.KNIGHT),
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
