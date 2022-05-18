import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:clio_chess_amp_v2/components/Drawer/BuildBottomListTile.dart';
import 'package:clio_chess_amp_v2/components/Drawer/BuildMainListTile.dart';
import 'package:clio_chess_amp_v2/pages/tab_menu.dart';
import 'package:flutter/material.dart';
import '../Screens/OfflineChess/offline_chess_page.dart';
import '../pages/setting_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.18,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Clio Chess',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildMainListTile(
                  'Chessboard',
                  Icons.apps_rounded,
                  () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabScreen.routeName);
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
          Container(
            // This align moves the children to the bottom
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              // This container holds all the children that will be aligned
              // on the bottom and should not scroll with the above ListView
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    buildBottomListTile('Help and Feedback', Icons.help, () {}),
                    buildBottomListTile('Settings', Icons.settings, () {}),
                    buildBottomListTile('Sign out', Icons.logout, () {
                      Amplify.Auth.signOut(
                          options: SignOutOptions(globalSignOut: true));
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
