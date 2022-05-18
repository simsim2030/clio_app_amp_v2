import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:clio_chess_amp_v2/Screens/auth/components/auth.dart';
import 'package:clio_chess_amp_v2/components/Theme/login_signup_theme.dart';
import 'package:clio_chess_amp_v2/Screens/Home/home_page.dart';
import 'package:flutter/material.dart';

// import '../../components/localized_button_resolver.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login_page';

  @override
  Widget build(BuildContext context) {
    final LoginSignupTheme theme = LoginSignupTheme();
    final AuthenticatorStep initialStep = AuthenticatorStep.signIn;
    final HomePage home = HomePage();
    return Auth(
      theme: theme,
      initialStep: initialStep,
      home: home,
    );
  }
}
