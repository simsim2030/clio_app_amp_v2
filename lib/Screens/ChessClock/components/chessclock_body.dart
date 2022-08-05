import 'package:clio_chess_amp_v2/Screens/ChessClock/components/button/chessclocksettingbtn.dart';
import 'package:clio_chess_amp_v2/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'chessclocktimer.dart';
import 'chessclockfunction.dart';
import 'dart:async';

class ChessClockBody extends StatefulWidget {
  @override
  State<ChessClockBody> createState() => _ChessClockBodyState();
}

class _ChessClockBodyState extends State<ChessClockBody> {
  ChessBoardController controller = ChessBoardController();
  APIService apiservice = APIService();

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

  @override
  void initState() {
    super.initState();

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

  int movenumber = 0;
  int _firstpress = 0;
  int _presscount_top = 0;
  int _presscount_bot = 0;

  void _onTopPressed() {
    _topClock.pause();
    _bottomClock.start();

    if (_presscount_top <= 0) {
      apiservice.createChessMove(movenumber);
      movenumber++;
      if (_firstpress == 0) {
        _presscount_top++;
        _firstpress++;
      } else {
        _presscount_top++;
        _presscount_bot--;
      }
    }
  }

  void _onBottomPressed() {
    _topClock.start();
    _bottomClock.pause();

    if (_presscount_bot <= 0) {
      apiservice.createChessMove(movenumber);
      movenumber++;
      if (_firstpress == 0) {
        _presscount_bot++;
        _firstpress++;
      } else {
        _presscount_bot++;
        _presscount_top--;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
          chessClockSettingBtn(topClock: _topClock, bottomClock: _bottomClock),
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
}
