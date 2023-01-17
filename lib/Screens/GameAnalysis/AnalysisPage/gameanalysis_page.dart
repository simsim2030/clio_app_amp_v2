import 'package:clio_chess_amp_v2/Screens/GameAnalysis/AnalysisPage/AnalysisBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GameAnalysisPage extends StatefulWidget {
  static const routeName = '/gameanalysis_page';
  const GameAnalysisPage({Key? key}) : super(key: key);

  @override
  State<GameAnalysisPage> createState() => _GameAnalysisPageState();
}

class _GameAnalysisPageState extends State<GameAnalysisPage> {
  var currentCP = 0.0;
  TextEditingController _cpController = TextEditingController();
  ChessBoardController controller = ChessBoardController();
  AnalysisBoard analysisBoard = AnalysisBoard();

  @override
  Widget build(BuildContext context) {
    int moveNumber = 0;
    int maxMoveNumber = 0;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Board Demo'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                LinearPercentIndicator(
                  width: screenwidth,
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 20.0,
                  percent: 0.2,
                  center: Align(
                    alignment: Alignment.topRight,
                    child: ValueListenableBuilder<String>(
                      valueListenable: AnalysisBoard.cpValue,
                      builder: (ctx, subCount, child) {
                        return Text(
                          "${AnalysisBoard.cpValue.value}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        );
                      },
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  linearStrokeCap: LinearStrokeCap.butt,
                  backgroundColor: Colors.black,
                  progressColor: Colors.white,
                  alignment: MainAxisAlignment.start,
                ),
                ChessBoard(
                  controller: controller,
                  boardColor: BoardColor.orange,
                  boardOrientation: PlayerColor.white,
                ),
              ],
            ),
          ),
          ValueListenableBuilder<String>(
            valueListenable: AnalysisBoard.cpValue,
            builder: (ctx, subCount, child) {
              return Text(
                "${AnalysisBoard.cpValue.value}",
                style: TextStyle(
                  fontSize: 30,
                ),
              );
            },
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
              analysisBoard.getCPValue();
            },
            child: Text('test 222'),
          ),

          // Text('Number : $add'),
          ElevatedButton(
            onPressed: () async {
              String test = await analysisBoard.loadCSV();
              controller.loadFen(test);
              maxMoveNumber = await analysisBoard.getMoveNumber();
              moveNumber = await analysisBoard.getMoveNumber();

              currentCP = await analysisBoard.getCP(moveNumber);
              analysisBoard.getCPValue();
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
                      String currentFen =
                          await analysisBoard.switchPoistion(moveNumber);
                      controller.loadFen(currentFen);
                      currentCP = await analysisBoard.getCP(moveNumber);
                      analysisBoard.getCPValue();
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              IconButton(
                  onPressed: () async {
                    if (moveNumber == maxMoveNumber) {
                      return;
                    } else {
                      moveNumber = moveNumber + 1;
                      String currentFen =
                          await analysisBoard.switchPoistion(moveNumber);
                      controller.loadFen(currentFen);
                      currentCP = await analysisBoard.getCP(moveNumber);
                      analysisBoard.getCPValue();
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ],
          ),
        ],
      ),
    );
  }
}
