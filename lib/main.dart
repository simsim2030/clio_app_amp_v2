import 'package:clio_chess_amp_v2/Screens/LiveChess/livechess_page.dart';
import 'package:clio_chess_amp_v2/Screens/auth/Login/login_page.dart';
import 'package:clio_chess_amp_v2/Screens/auth/Signup/signup_page.dart';
import 'package:clio_chess_amp_v2/components/Theme/main_theme.dart';

import 'package:clio_chess_amp_v2/pages/tab_menu.dart';
import 'package:flutter/material.dart';

import 'Screens/ChessClock/chessclock.dart';
import 'Screens/Home/home_page.dart';
import 'Screens/OfflineChess/offline_chess_page.dart';
import 'Screens/OfflineMode/offlinemode_screen.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'pages/history_page.dart';
import 'pages/setting_page.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// Generated in previous step
import 'amplifyconfiguration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    // AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

    // await Amplify.addPlugins([authPlugin, analyticsPlugin]);
    await Amplify.addPlugins([authPlugin]);
    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final MainTheme theme = MainTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clio Chess Auth',
      // Internatize language pack
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      theme: theme.mainLightTheme,
      darkTheme: theme.mainDarkTheme,
      // home: Navigator(pages: [MaterialPage(child: HomePage()),],
      home: WelcomeScreen(),

      // home: MainScreen(),
      // initialRoute: '/',
      routes: {
        // TabScreen.routeName: (ctx) => TabScreen(),
        // SettingPage.routeName: (ctx) => SettingPage(),
        // HistoryPage.routeName: (ctx) => HistoryPage(),
        OfflineChessPage.routeName: (ctx) => OfflineChessPage(),
        LoginPage.routeName: (ctx) => LoginPage(),
        SignupPage.routeName: (ctx) => SignupPage(),
        OfflineModePage.routeName: (ctx) => OfflineModePage(),
        ChessClockPage.routeName: (ctx) => ChessClockPage(),
        // LiveChess.routeName: (ctx) => LiveChess(),
        HomePage.routeName: (ctx) => LiveChess(),
        // '/': (ctx) => MainScreen(),
      },
    );
  }
}
