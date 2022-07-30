import 'package:flutter/material.dart';

class ChessClockTimer extends StatelessWidget {
  final bool isReversed;
  final bool isTicking;
  final bool isTimeup;
  final VoidCallback onPressed;

  final Duration availableTime;

  const ChessClockTimer({
    Key? key,
    this.isReversed = false,
    this.isTicking = false,
    this.isTimeup = false,
    required this.onPressed,
    required this.availableTime,
  }) : super(key: key);

  Color _getColor() {
    if (isTicking) {
      return Colors.orange;
    }

    if (isTimeup) {
      return Colors.red;
    }

    return Colors.white24;
  }

  String _getAvailableTimeText() {
    return availableTime.toString().substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: _getColor(),
        child: Center(
          child: RotatedBox(
            quarterTurns: isReversed ? 2 : 0,
            child: Text(
              _getAvailableTimeText(),
              style: TextStyle(
                fontSize: 70,
                color: Color.fromARGB(220, 255, 255, 255),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
