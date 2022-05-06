import 'package:clio_chess_app/pages/history_page.dart';
import 'package:clio_chess_app/Screens/OfflineChess/offline_chess_page.dart';
import 'package:clio_chess_app/pages/setting_page.dart';
import 'package:clio_chess_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 40.0),
              Image.asset(
                'images/chess_squares.jpg',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
              Container(height: 60.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Live Chess'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(HistoryPage.routeName);
                },
                child: Text('History'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(OfflineChessPage.routeName);
                  },
                  child: Text('Chessboard')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SettingPage.routeName);
                  },
                  child: Text('Setting')),
            ],
          ),
        ),
      ),
    );
  }
}
