import 'package:clio_chess_amp_v2/Screens/Blog/blog_page.dart';
import 'package:clio_chess_amp_v2/Screens/ChessClock/chessclock.dart';
import 'package:clio_chess_amp_v2/Screens/LiveChessAnalysis/livechessanalysis_page.dart';
import 'package:clio_chess_amp_v2/Screens/Home/components/home_flat_button.dart';
import 'package:clio_chess_amp_v2/Screens/GameAnalysis/gameanalysis_page.dart';
import 'package:clio_chess_amp_v2/Screens/OfflineChess/offline_chess_page.dart';
import 'package:clio_chess_amp_v2/Screens/Settings/setting_page.dart';
import 'package:clio_chess_amp_v2/components/Drawer/main_drawer.dart';
import 'package:clio_chess_amp_v2/services/api_service.dart';
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
                Navigator.of(context)
                    .pushNamed(LiveChessAnalysisPage.routeName);
              },
              image: 'assets/images/2DChess.png',
              icon: Icons.apps_rounded,
              title: 'Live Chess Analysis',
            ),
            HomePageFlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(GameAnalysis.routeName);
              },
              image: 'assets/images/2DChess.png',
              icon: Icons.history,
              title: 'Post Game Analysis',
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
