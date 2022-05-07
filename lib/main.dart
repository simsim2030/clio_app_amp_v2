import 'package:clio_chess_amp_v2/pages/tab_menu.dart';
import 'package:flutter/material.dart';

import 'Screens/ChessClock/chessclock.dart';
import 'Screens/Login/login_page.dart';
import 'Screens/OfflineChess/offline_chess_page.dart';
import 'Screens/OfflineMode/offlinemode_screen.dart';
import 'Screens/Signup/signup_page.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'pages/history_page.dart';
import 'pages/setting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clio Chess Auth',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.white,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway-Bold',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      home: WelcomeScreen(),

      // home: MainScreen(),
      // initialRoute: '/',
      routes: {
        TabScreen.routeName: (ctx) => TabScreen(),
        SettingPage.routeName: (ctx) => SettingPage(),
        HistoryPage.routeName: (ctx) => HistoryPage(),
        OfflineChessPage.routeName: (ctx) => OfflineChessPage(),
        LoginPage.routeName: (ctx) => LoginPage(),
        SignupPage.routeName: (ctx) => SignupPage(),
        OfflineModePage.routeName: (ctx) => OfflineModePage(),
        ChessClockPage.routeName: (ctx) => ChessClockPage(),
        // '/': (ctx) => MainScreen(),
      },
    );
  }
}
