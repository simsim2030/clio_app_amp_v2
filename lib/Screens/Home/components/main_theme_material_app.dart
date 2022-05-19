import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:clio_chess_amp_v2/Screens/Home/home_page.dart';
import 'package:clio_chess_amp_v2/components/Theme/main_theme.dart';
import 'package:flutter/material.dart';

class MainThemeMaterialApp extends StatelessWidget {
  const MainThemeMaterialApp({
    Key? key,
    required this.theme,
    required this.home,
  }) : super(key: key);

  final MainTheme theme;
  final HomePage home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.mainLightTheme,
      darkTheme: theme.mainDarkTheme,
      themeMode: ThemeMode.system,
      builder: Authenticator.builder(),
      home: home,
    );
  }
}
