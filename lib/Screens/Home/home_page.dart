import 'package:clio_chess_amp_v2/Screens/Blog/blog_page.dart';
import 'package:clio_chess_amp_v2/Screens/ChessClock/chessclock.dart';
import 'package:clio_chess_amp_v2/Screens/History/history_page.dart';
import 'package:clio_chess_amp_v2/Screens/Home/components/home_flat_button.dart';
import 'package:clio_chess_amp_v2/Screens/LiveChess/livechess_page.dart';
import 'package:clio_chess_amp_v2/Screens/OfflineChess/offline_chess_page.dart';
import 'package:clio_chess_amp_v2/Screens/Settings/setting_page.dart';
import 'package:clio_chess_amp_v2/components/Drawer/main_drawer.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        title: Text('CLio Chess'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomePageFlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LiveChess.routeName);
              },
              image: 'assets/images/2DChess.png',
              icon: Icons.apps_rounded,
              title: 'Live Chess',
            ),
            HomePageFlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HistoryPage.routeName);
              },
              image: 'assets/images/2DChess.png',
              icon: Icons.history,
              title: 'History',
            ),
            HomePageFlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ChessClockPage.routeName);
              },
              image: 'assets/images/chessclock2D.png',
              icon: Icons.punch_clock,
              title: 'Chess Clock',
            ),
            HomePageFlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(OfflineChessPage.routeName);
              },
              image: 'assets/images/2DChess.png',
              icon: Icons.apps_rounded,
              title: 'Chessboard',
            ),
            HomePageFlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BlogPage.routename);
              },
              image: 'assets/images/new_example.png',
              icon: Icons.newspaper,
              title: 'Blog',
            ),
          ],
        ),
      ),
    );
  }
}
