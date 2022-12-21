import 'package:clio_chess_amp_v2/Screens/ChessClock/chessclock.dart';
import 'package:clio_chess_amp_v2/Screens/GameAnalysis/gameanalysisselection_page.dart';
import 'package:clio_chess_amp_v2/Screens/OfflineChess/offline_chess_page.dart';
import 'package:clio_chess_amp_v2/Screens/OfflineMode/components/offlinemode_background.dart';
import 'package:clio_chess_amp_v2/components/buttons/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class OfflineModeBody extends StatelessWidget {
  const OfflineModeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.005),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RounderOutlinedButton(
              text: "Chessboard",
              onPressed: () {
                Navigator.of(context).pushNamed(OfflineChessPage.routeName);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RounderOutlinedButton(
              text: "Chess Clock",
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed(GameAnalysisSelection.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
