import 'package:clio_chess_amp_v2/Screens/ChessClock/chessclock.dart';

import 'package:flutter/material.dart';
import 'chessclocktimer.dart';
import 'chessclockfunction.dart';
import 'dart:async';

class ChessClockBody extends StatefulWidget {
  @override
  State<ChessClockBody> createState() => _ChessClockBodyState();
}

class _ChessClockBodyState extends State<ChessClockBody> {
  ChessClock _topClock = ChessClock(
    getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
    timeControlMillis: 5 * 60 * 1000,
    incrementsMillis: 0,
  );

  ChessClock _bottomClock = ChessClock(
    getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
    timeControlMillis: 5 * 60 * 1000,
    incrementsMillis: 0,
  );

  String timecontrol = '';

  late Timer _timer;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _timer = Timer.periodic(
      Duration(milliseconds: 200),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    _timer.cancel();
  }

  void _onTopPressed() {
    _topClock.pause();
    _bottomClock.start();
  }

  void _onBottomPressed() {
    _topClock.start();
    _bottomClock.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChessClockTimer(
                onPressed: _onTopPressed,
                isReversed: true,
                isTicking: _topClock.isTicking(),
                isTimeup: _topClock.isTimeUp(),
                availableTime:
                    Duration(milliseconds: _topClock.getAvailableMillis()),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    createAlertDialog(context).then((value) {
                      SnackBar mySnackbar =
                          SnackBar(content: Text("Hello $value"));
                      Scaffold.of(context).showSnackBar(mySnackbar);
                    });
                  },
                  icon: Icon(Icons.settings),
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Navigator.pushReplacementNamed(context, '/chessclock_page');
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            ChessClockPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.restart_alt,
                    size: 45,
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _bottomClock.pause();
                    _topClock.pause();
                  },
                  icon: Icon(
                    Icons.pause,
                    size: 45,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChessClockTimer(
                onPressed: _onBottomPressed,
                isTicking: _bottomClock.isTicking(),
                isTimeup: _bottomClock.isTimeUp(),
                availableTime:
                    Duration(milliseconds: _bottomClock.getAvailableMillis()),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String?> createAlertDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Time Control"),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  // TextField(
                  //   controller: controller,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('5|5'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('10|10'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('15|15'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
              )
            ],
          );
        });
  }
}
