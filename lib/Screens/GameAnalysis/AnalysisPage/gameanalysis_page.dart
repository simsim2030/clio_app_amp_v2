import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class GameAnalysisPage extends StatefulWidget {
  static const routeName = '/gameanalysis_page';
  const GameAnalysisPage({Key? key}) : super(key: key);

  @override
  State<GameAnalysisPage> createState() => _GameAnalysisPageState();
}

class _GameAnalysisPageState extends State<GameAnalysisPage> {
  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Demo'),
      ),
      body: Column(
        children: [
          Center(
            child: ChessBoard(
              controller: controller,
              boardColor: BoardColor.orange,
              // arrows: [
              //   BoardArrow(
              //     from: 'd2',
              //     to: 'd4',
              //     //color: Colors.red.withOpacity(0.5),
              //   ),
              //   BoardArrow(
              //     from: 'e7',
              //     to: 'e5',
              //     color: Colors.red.withOpacity(0.7),
              //   ),
              // ],
              boardOrientation: PlayerColor.white,
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Chess>(
              valueListenable: controller,
              builder: (context, game, _) {
                return Text(
                  controller.getSan().fold(
                        '',
                        (previousValue, element) =>
                            previousValue + '\n' + (element ?? ''),
                      ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.loadPGN('1. e4 c5 2. Nf3 Nc6 3. Bb5 e5 4. O-O Bd6');
            },
            child: Text('Load PGN'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.undoMove();
            },
            child: Text('Back'),
          )
        ],
      ),
    );
  }
}
