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
  int _PGNIndex = -1;
  int selectedMove = -1;

  var currentCP = 0.0;
  ChessBoardController controller = ChessBoardController();
  AnalysisBoard analysisBoard = AnalysisBoard();
  double a = 0.0;
  int moveNumber = 0;
  int maxMoveNumber = 0;
  List PGNList = [];

  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() async {
    String test = await analysisBoard.loadCSV(gameKey);
    controller.loadFen(test);
    maxMoveNumber = await analysisBoard.getMoveNumber(gameKey);
    moveNumber = await analysisBoard.getMoveNumber(gameKey);

    currentCP = await analysisBoard.getCP(moveNumber, gameKey);
    analysisBoard.getCPValue();
    analysisBoard.getCPValuePercentage();
    analysisBoard.getPGNList(gameKey);
    int moveShown = moveNumber - 1;
    analysisBoard.getSelectedMove(moveShown);
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
      backgroundColor: Colors.grey[900],
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
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder<List>(
              valueListenable: AnalysisBoard.PGNList,
              builder: (context, subCount, child) {
                return GridView.builder(
                  key: const Key('PGNGridView'),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    childAspectRatio: 3,
                  ),
                  itemCount: moveNumber,
                  itemBuilder: (context, index) {
                    final item = AnalysisBoard.PGNList.value[index];
                    return ValueListenableBuilder<int>(
                        valueListenable: AnalysisBoard.isSelectedMove,
                        builder: (context, subCount, child) {
                          return GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(6),

                                border: Border.all(
                                    width: 0, style: BorderStyle.none),
                                color:
                                    AnalysisBoard.isSelectedMove.value == index
                                        ? Colors.grey[700]
                                        : Colors.grey[900],
                              ),
                              child: Text(
                                '${AnalysisBoard.PGNList.value[index]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onTap: () async {
                              String currentFen = await analysisBoard
                                  .switchPoistion(index + 1, gameKey);
                              controller.loadFen(currentFen);
                              currentCP =
                                  await analysisBoard.getCP(index + 1, gameKey);
                              analysisBoard.getCPValue();
                              analysisBoard.getCPValuePercentage();
                              selectedMove = index;
                              analysisBoard.getSelectedMove(selectedMove);
                              moveNumber = selectedMove + 1;
                              print(selectedMove);
                            },
                          );
                        });
                  },
                );
              },
            ),
          ),

          // Expanded(
          //   child: ValueListenableBuilder<Chess>(
          //     valueListenable: controller,
          //     builder: (context, game, _) {
          //       return Text(
          //         controller.getSan().fold(
          //               '',
          //               (previousValue, element) =>
          //                   previousValue + '\n' + (element ?? ''),
          //             ),
          //       );
          //     },
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     // PGNList = await analysisBoard.getPGNList(gameKey);
          //     print(PGNList);
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
                  if (moveNumber <= 0) {
                    return;
                  } else {
                    moveNumber = moveNumber - 1;
                    String currentFen =
                        await analysisBoard.switchPoistion(moveNumber, gameKey);
                    controller.loadFen(currentFen);
                    currentCP = await analysisBoard.getCP(moveNumber, gameKey);
                    analysisBoard.getCPValue();
                    analysisBoard.getCPValuePercentage();
                    int moveShown = moveNumber - 1;
                    analysisBoard.getSelectedMove(moveShown);
                    print('moveShown: $moveShown');
                    print('moveNumber: $moveNumber');
                  }
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    if (moveNumber == maxMoveNumber) {
                      return;
                    } else {
                      moveNumber = moveNumber + 1;
                      String currentFen = await analysisBoard.switchPoistion(
                          moveNumber, gameKey);
                      controller.loadFen(currentFen);
                      currentCP =
                          await analysisBoard.getCP(moveNumber, gameKey);
                      analysisBoard.getCPValue();
                      analysisBoard.getCPValuePercentage();
                      int moveShown = moveNumber - 1;
                      analysisBoard.getSelectedMove(moveShown);
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWidget(String language, int index) {
    bool isSelected = _PGNIndex == index;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1),
        color: Colors.grey[900],
      ),
      child: Text(
        language,
        style: TextStyle(
            fontSize: 16, color: isSelected ? Colors.blue[400] : null),
      ),
    );
  }
}
