import 'package:clio_chess_amp_v2/Screens/Home/home_page.dart';
import 'package:clio_chess_amp_v2/Screens/auth/components/auth.dart';
import 'package:clio_chess_amp_v2/components/Theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

class SignupPage extends StatelessWidget {
  static const routeName = '/signup_page';
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainTheme theme = MainTheme();
    final AuthenticatorStep initialStep = AuthenticatorStep.signUp;
    final HomePage home = HomePage();
    return Auth(
      theme: theme,
      initialStep: initialStep,
      home: home,
    );
  }
}
