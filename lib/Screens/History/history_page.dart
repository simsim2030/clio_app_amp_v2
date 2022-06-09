import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:flutter/material.dart';
import 'package:clio_chess_amp_v2/services/api_service.dart';

class HistoryPage extends StatefulWidget {
  static const routeName = '/history_page';
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ChessBoardController controller = ChessBoardController();
  APIService apiservice = APIService();

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
          // ElevatedButton(
          //   onPressed: () {
          //     apiservice.getTODO('todoname');
          //   },
          //   child: Text('To get'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     apiservice.createTODO('d2d4');
          //   },
          //   child: Text('To create todo'),
          // ),
          ElevatedButton(
            onPressed: () {
              apiservice.createClioMoveList('d2d4');
            },
            child: Text('To create ML'),
          ),
          ElevatedButton(
            onPressed: () {
              apiservice.subscribe(controller);
            },
            child: Text('subscribe'),
          ),
        ],
      ),
    );
  }
}
