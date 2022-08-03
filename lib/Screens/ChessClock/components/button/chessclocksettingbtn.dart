import 'package:clio_chess_amp_v2/Screens/ChessClock/chessclock.dart';
import 'package:flutter/material.dart';

import '../chessclockfunction.dart';
import '../customTimeControl/timecontrol_setting_dialog.dart';

class chessClockSettingBtn extends StatelessWidget {
  const chessClockSettingBtn({
    Key? key,
    required ChessClock topClock,
    required ChessClock bottomClock,
  })  : _topClock = topClock,
        _bottomClock = bottomClock,
        super(key: key);

  final ChessClock _topClock;
  final ChessClock _bottomClock;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              _topClock.pause();
              _bottomClock.pause();
              await createAlertDialog(context).then((value) {
                // SnackBar mySnackbar =
                //     SnackBar(content: Text("Hello $value"));
                // Scaffold.of(context).showSnackBar(mySnackbar);
                _topClock.timeControlMillis = value!;
                _topClock.millisElapsed = 0;
                _bottomClock.timeControlMillis = value;
                _bottomClock.millisElapsed = 0;
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
              _bottomClock.pause();
              _topClock.pause();
            },
            icon: Icon(
              Icons.pause,
              color: Color.fromARGB(220, 255, 255, 255),
              size: 42,
            ),
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
