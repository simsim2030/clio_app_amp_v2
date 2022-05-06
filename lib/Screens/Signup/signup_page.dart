import 'package:clio_chess_app/Screens/Signup/components/signup_body.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup_page';
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade900,
      body: SignupBody(),
    );
  }
}
