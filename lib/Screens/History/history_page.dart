import 'package:clio_chess_amp_v2/models/ClioMove.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:clio_chess_amp_v2/services/api_service.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';

class HistoryPage extends StatefulWidget {
  static const routeName = '/history_page';
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ChessBoardController controller = ChessBoardController();
  APIService apiservice = APIService();

  // initiate subscription
  @override
  void initState() {
    apiservice.subscribe(controller);
    userID_current();
    super.initState();
  }

  Future<String> _userID() async {
    Future<String> _sub = apiservice.fetchCurrentUserAttributes();
    return _sub;
  }

  userID_current() async {
    String user_id = await _userID();
    String user_id_cur = '$user_id';
    apiservice.createClioMoveList('initial', user_id_cur);
    print('user_id_cur: $user_id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        title: const Text('Chess Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.orange,
                boardOrientation: PlayerColor.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.makeMove(from: 'd2', to: 'd4');
            },
            child: Text('move'),
          ),
          ElevatedButton(
            onPressed: () async {
              Future<String> future_sub =
                  apiservice.fetchCurrentUserAttributes();

              String sub = await apiservice.fetchCurrentUserAttributes();

              apiservice.createClioMoveList('d2d4', sub);
            },
            child: Text('To create ML'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.loadFen('8/8/8/4p1K1/2k1P3/8/8/8 b - - 0 1');
            },
            child: Text('To load fen'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('get users attribute'),
          ),
        ],
      ),
    );
  }
}
