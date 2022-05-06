import 'package:clio_chess_amp_v2/pages/tab_menu.dart';
import 'package:flutter/material.dart';
import '../Screens/OfflineChess/offline_chess_page.dart';
import '../pages/setting_page.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
    String title,
    IconData icon,
    VoidCallback tapHandler,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Clio Chess',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Chessboard', Icons.apps_rounded, () {
            Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
          }),
          // buildListTile('Live Chess', Icons.alarm_rounded, () {
          //   Navigator.of(context).pushNamed(FindDevicesScreen.routeName);
          // }),
          buildListTile('Settings', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(SettingPage.routeName);
          }),
        ],
      ),
    );
  }
}
