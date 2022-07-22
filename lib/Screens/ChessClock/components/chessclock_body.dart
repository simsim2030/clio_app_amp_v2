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
    incrementsMillis: 1000,
  );

  ChessClock _bottomClock = ChessClock(
    getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
    timeControlMillis: 5 * 60 * 1000,
    incrementsMillis: 1000,
  );

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
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
            child: ChessClockTimer(
              onPressed: _onTopPressed,
              isReversed: true,
              isTicking: _topClock.isTicking(),
              isTimeup: _topClock.isTimeUp(),
              availableTime:
                  Duration(milliseconds: _topClock.getAvailableMillis()),
            ),
          ),
          Expanded(
            child: ChessClockTimer(
              onPressed: _onBottomPressed,
              isTicking: _bottomClock.isTicking(),
              isTimeup: _bottomClock.isTimeUp(),
              availableTime:
                  Duration(milliseconds: _bottomClock.getAvailableMillis()),
            ),
          )
        ],
      ),
    );
  }
}
