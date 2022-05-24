import 'package:clio_chess_amp_v2/Screens/ChessClock/chessclock.dart';
import 'package:clio_chess_amp_v2/Screens/Home/components/home_flat_button.dart';
import 'package:clio_chess_amp_v2/Screens/LiveChess/livechess_page.dart';
import 'package:clio_chess_amp_v2/Screens/OfflineChess/offline_chess_page.dart';
import 'package:clio_chess_amp_v2/pages/history_page.dart';
import 'package:clio_chess_amp_v2/pages/setting_page.dart';
import 'package:clio_chess_amp_v2/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomePageFlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LiveChess.routeName);
                },
                image: 'assets/images/login_bottom.png',
                icon: 'assets/images/main_top.png',
                title: 'Live Chess',
              ),
              HomePageFlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(HistoryPage.routeName);
                },
                image: 'assets/images/login_bottom.png',
                icon: 'assets/images/main_top.png',
                title: 'History',
              ),
              HomePageFlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ChessClockPage.routeName);
                },
                image: 'assets/images/login_bottom.png',
                icon: 'assets/images/main_top.png',
                title: 'Chess Clock',
              ),
              HomePageFlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(OfflineChessPage.routeName);
                },
                image: 'assets/images/login_bottom.png',
                icon: 'assets/images/main_top.png',
                title: 'Chessboard',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
