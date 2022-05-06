import 'package:flutter/material.dart';
import '../Screens/OfflineChess/offline_chess_page.dart';


class TabScreen extends StatefulWidget {
  static const routeName = '/tab_screen_page';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _pages = [
    OfflineChessPage(),
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pages[_selectedPageIndex]['title']),
      // ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.blueGrey[900],
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_rounded),
            label: 'CB',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_rounded),
            label: 'Live',
          ),
        ],
      ),
    );
  }
}
