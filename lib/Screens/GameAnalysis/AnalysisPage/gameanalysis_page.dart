import 'package:clio_chess_amp_v2/Screens/GameAnalysis/AnalysisPage/AnalysisBoard.dart';
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
  AnalysisBoard analysisBoard = AnalysisBoard();

  @override
  Widget build(BuildContext context) {
    int moveNumber = 0;
    int maxMoveNumber = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Board Demo'),
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
          // ElevatedButton(
          //   onPressed: () {
          //     // controller.loadPGN('1. e4 c5 2. Nf3 Nc6 3. Bb5 e5 4. O-O Bd6');
          //     controller.loadFen(
          //         'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq - 0 1');
          //   },
          //   child: Text('Load PGN'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     controller.undoMove();
          //   },
          //   child: Text('Back'),
          // ),
          ElevatedButton(
            onPressed: () async {
              String test = await analysisBoard.loadCSV();
              controller.loadFen(test);
              maxMoveNumber = await analysisBoard.getMoveNumber();
              moveNumber = await analysisBoard.getMoveNumber();
              print(maxMoveNumber);
            },
            child: Text('Read PGN'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    if (moveNumber == 0) {
                      return;
                    } else {
                      moveNumber = moveNumber - 1;
                      String test =
                          await analysisBoard.switchPoistion(moveNumber);
                      controller.loadFen(test);
                    }
                    // controller.loadFen(test);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              IconButton(
                  onPressed: () async {
                    if (moveNumber == maxMoveNumber) {
                      return;
                    } else {
                      moveNumber = moveNumber + 1;
                      String test =
                          await analysisBoard.switchPoistion(moveNumber);
                      controller.loadFen(test);
                    }
                    // controller.loadFen(test);
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ],
          ),
        ],
      ),
    );
  }
}
