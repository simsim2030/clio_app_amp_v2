import 'package:clio_chess_amp_v2/Screens/LiveChess/livechess_page.dart';
import 'package:clio_chess_amp_v2/pages/history_page.dart';
import 'package:clio_chess_amp_v2/pages/setting_page.dart';
import 'package:clio_chess_amp_v2/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LiveChess.routeName);
              },
              child: Text('Settings'),
            ),
          ),
        ],
      ),
    );
  }
}
