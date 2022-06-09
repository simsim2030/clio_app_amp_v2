import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:clio_chess_amp_v2/Screens/ChessClock/chessclock.dart';
import 'package:clio_chess_amp_v2/Screens/LiveChess/livechess_page.dart';
import 'package:clio_chess_amp_v2/Screens/OfflineChess/offline_chess_page.dart';
import 'package:clio_chess_amp_v2/components/Drawer/Components/BuildBottomListTile.dart';
import 'package:clio_chess_amp_v2/components/Drawer/Components/BuildMainListTile.dart';
import 'package:clio_chess_amp_v2/Screens/History/history_page.dart';
import 'package:clio_chess_amp_v2/Screens/Settings/setting_page.dart';
import 'package:clio_chess_amp_v2/pages/tab_menu.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.18,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Text(
                'CLio Chess',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade600,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    buildMainListTile(
                      'Live Chess',
                      Icons.apps_rounded,
                      () {
                        Navigator.of(context).pushNamed(LiveChess.routeName);
                      },
                    ),
                    buildMainListTile(
                      'History',
                      Icons.history,
                      () {
                        Navigator.of(context).pushNamed(HistoryPage.routeName);
                      },
                    ),
                    buildMainListTile(
                      'Chess Clock',
                      Icons.punch_clock,
                      () {
                        Navigator.of(context)
                            .pushNamed(ChessClockPage.routeName);
                      },
                    ),
                    buildMainListTile(
                      'Chessboard',
                      Icons.apps_rounded,
                      () {
                        Navigator.of(context)
                            .pushNamed(OfflineChessPage.routeName);
                      },
                    ),
                    buildMainListTile(
                      'Blog',
                      Icons.newspaper,
                      () {
                        Navigator.of(context).pushNamed(TabScreen.routeName);
                      },
                    ),
                    buildMainListTile(
                      'Settings',
                      Icons.settings,
                      () {
                        Navigator.of(context)
                            .pushReplacementNamed(SettingPage.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[600],
              // This align moves the children to the bottom
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                // This container holds all the children that will be aligned
                // on the bottom and should not scroll with the above ListView
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      buildBottomListTile(
                          'Help and Feedback', Icons.help, () {}),
                      buildBottomListTile(
                        'Sign out',
                        Icons.logout,
                        () {
                          Amplify.Auth.signOut(
                            options: SignOutOptions(globalSignOut: true),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
