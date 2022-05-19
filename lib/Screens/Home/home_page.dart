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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.0),
            Image.asset(
              'images/chess_squares.jpg',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 60.0),
            Container(
              width: size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Live Chess',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HistoryPage.routeName);
              },
              child: Text(
                'History',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(OfflineChessPage.routeName);
              },
              child: Text(
                'Chessboard',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SettingPage.routeName);
              },
              child: Text('Setting'),
            ),
          ],
        ),
      ),
    );
  }
}
