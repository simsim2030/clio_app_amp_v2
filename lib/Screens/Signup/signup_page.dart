import 'package:flutter/material.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import '../../pages/home_page.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup_page';
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      initialStep: AuthenticatorStep.signUp,
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: HomePage(),
      ),
    );
  }
}
