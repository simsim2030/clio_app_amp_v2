import 'package:clio_chess_amp_v2/Screens/ChessClock/chessclock.dart';
import 'package:flutter/material.dart';

import '../chessclockfunction.dart';
import '../customTimeControl/timecontrol_setting_dialog.dart';

class chessClockSettingBtn extends StatefulWidget {
  chessClockSettingBtn({
    Key? key,
    required ChessClock topClock,
    required ChessClock bottomClock,
    required bool gameStart,
    required int B_W,
  })  : _topClock = topClock,
        _bottomClock = bottomClock,
        _gameStart = gameStart,
        _B_W = B_W,
        super(key: key);

  final int _B_W;
  bool _gameStart;
  final ChessClock _topClock;
  final ChessClock _bottomClock;

  @override
  State<chessClockSettingBtn> createState() => _chessClockSettingBtnState();
}

class _chessClockSettingBtnState extends State<chessClockSettingBtn> {
  bool gameStart = false;
  bool init = true;
  int clockState = 0;
  bool playBtnState = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              widget._topClock.pause();
              widget._bottomClock.pause();
              await createAlertDialog(context).then((value) {
                // SnackBar mySnackbar =
                //     SnackBar(content: Text("Hello $value"));
                // Scaffold.of(context).showSnackBar(mySnackbar);
                widget._topClock.timeControlMillis = value!;
                widget._topClock.millisElapsed = 0;
                widget._bottomClock.timeControlMillis = value;
                widget._bottomClock.millisElapsed = 0;
              });
            },
            icon: Icon(
              Icons.settings,
              color: Color.fromARGB(220, 255, 255, 255),
              size: 42,
            ),
          ),
        ),
        Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // When Pad is pressed and pausing the game
              print('widget._gameStart: ' + widget._gameStart.toString());
              print('gameStart: ' + gameStart.toString());
              print('widget._B_W: ' + widget._B_W.toString());
              print('---------------');
              if (widget._gameStart == true && gameStart == true) {
                widget._bottomClock.pause();
                widget._topClock.pause();

                gameStart = false;
                print('0');
              } else if (widget._gameStart == false && gameStart == false) {
                // When game is intiating
                if (widget._B_W == 0) {
                  widget._bottomClock.pause();
                  widget._topClock.start();
                  gameStart = true;
                  playBtnState = true;
                } else if (widget._B_W == 1) {
                  widget._topClock.start();
                  widget._bottomClock.pause();
                  gameStart = true;
                  playBtnState = true;
                } else if (widget._B_W == -1) {
                  widget._bottomClock.start();
                  widget._topClock.pause();
                  gameStart = true;
                  playBtnState = true;
                }
              } else if (widget._gameStart == false && gameStart == true) {
                widget._topClock.pause();
                widget._bottomClock.pause();
                gameStart = false;
                print("2");
              } else if (widget._gameStart == true && gameStart == false) {
                // When pause and starting in the middle (black moves)
                if (playBtnState == true) {
                  widget._topClock.pause();
                  widget._bottomClock.pause();
                  widget._gameStart = false;

                  playBtnState = !playBtnState;
                  print("5-1");
                } else {
                  if (widget._B_W == -1) {
                    widget._topClock.start();
                    widget._bottomClock.pause();
                    gameStart = false;
                    playBtnState = !playBtnState;
                  } else if (widget._B_W == 1) {
                    widget._bottomClock.start();
                    widget._topClock.pause();
                    gameStart = false;
                    playBtnState = !playBtnState;
                  }
                  print('5-2');
                }
              }
            },
            icon: Image.asset('assets/icons/pause.png'),
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
              color: Color.fromARGB(220, 255, 255, 255),
              size: 42,
            ),
          ),
        ),
      ],
    );
  }
}
