import 'package:clio_chess_amp_v2/Screens/GameAnalysis/AnalysisPage/AnalysisBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GameAnalysisPage extends StatefulWidget {
  static const routeName = '/gameanalysis_page';
  String gameKey;

  GameAnalysisPage({Key? key, required this.gameKey}) : super(key: key);

  @override
  State<GameAnalysisPage> createState() => _GameAnalysisPageState(gameKey);
}

class _GameAnalysisPageState extends State<GameAnalysisPage> {
  String gameKey;
  _GameAnalysisPageState(this.gameKey);

  var currentCP = 0.0;
  ChessBoardController controller = ChessBoardController();
  AnalysisBoard analysisBoard = AnalysisBoard();
  double a = 0.0;
  int moveNumber = 0;
  int maxMoveNumber = 0;

  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() async {
    String test = await analysisBoard.loadCSV(gameKey);
    controller.loadFen(test);
    maxMoveNumber = await analysisBoard.getMoveNumber();
    moveNumber = await analysisBoard.getMoveNumber();

    currentCP = await analysisBoard.getCP(moveNumber);
    analysisBoard.getCPValue();
    analysisBoard.getCPValuePercentage();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                ValueListenableBuilder<double>(
                    valueListenable: AnalysisBoard.cpValuePercentage,
                    builder: (context, subCount2, child2) {
                      return LinearPercentIndicator(
                        width: screenwidth,
                        lineHeight: 20.0,
                        percent: AnalysisBoard.cpValuePercentage.value,
                        center: Align(
                          alignment: AnalysisBoard.cpValuePercentage.value < 0.5
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: ValueListenableBuilder<String>(
                            valueListenable: AnalysisBoard.cpValue,
                            builder: (context, subCount, child) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  AnalysisBoard.cpValuePercentage.value == 0.5
                                      ? ""
                                      : "${AnalysisBoard.cpValue.value}",
                                  style: TextStyle(
                                    color:
                                        AnalysisBoard.cpValuePercentage.value <
                                                0.5
                                            ? Colors.white
                                            : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        linearStrokeCap: LinearStrokeCap.butt,
                        backgroundColor: Colors.black87,
                        progressColor: Colors.white,
                        alignment: MainAxisAlignment.start,
                      );
                    }),
                ChessBoard(
                  controller: controller,
                  boardColor: BoardColor.orange,
                  boardOrientation: PlayerColor.white,
                ),
              ],
            ),
          ),
          // ValueListenableBuilder<String>(
          //   valueListenable: AnalysisBoard.cpValue,
          //   builder: (ctx, subCount, child) {
          //     return Text(
          //       "${AnalysisBoard.cpValue.value}",
          //       style: TextStyle(
          //         fontSize: 30,
          //       ),
          //     );
          //   },
          // ),
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
          //     updateCP();
          //   },
          //   child: Text('test 222'),
          // ),
          // ElevatedButton(
          //   onPressed: () async {
          //     print(gameKey);
          //     String test = await analysisBoard.loadCSV(gameKey);
          //     controller.loadFen(test);
          //     maxMoveNumber = await analysisBoard.getMoveNumber();
          //     moveNumber = await analysisBoard.getMoveNumber();

          //     currentCP = await analysisBoard.getCP(moveNumber);
          //     analysisBoard.getCPValue();
          //     analysisBoard.getCPValuePercentage();
          //   },
          //   child: Text('Read PGN'),
          // ),
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
                      analysisBoard.getCPValuePercentage();
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
                      analysisBoard.getCPValuePercentage();
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
