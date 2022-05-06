import 'package:clio_chess_amp_v2/Screens/Login/login_page.dart';
import 'package:clio_chess_amp_v2/Screens/OfflineMode/offlinemode_screen.dart';
import 'package:clio_chess_amp_v2/Screens/Signup/signup_page.dart';
import 'package:clio_chess_amp_v2/Screens/Welcome/components/wlecome_background.dart';
import 'package:clio_chess_amp_v2/components/buttons/rounded_button.dart';
import 'package:clio_chess_amp_v2/components/buttons/tap_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //this size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "CLio",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 45,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: size.height * 0.4),
            // SvgPicture.asset(
            //   "assets/icons/chat.svg",
            //   height: size.height * 0.45,
            // ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Log In",
              onPressed: () {
                Navigator.of(context).pushNamed(LoginPage.routeName);
              },
            ),
            RoundedButton(
              text: "Sign Up",
              color: Colors.lightBlue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed(SignupPage.routeName);
              },
            ),
            SizedBox(height: size.height * 0.05),
            TapButton(
              text: "Offline Mode",
              onTap: () {
                Navigator.of(context).pushNamed(OfflineModePage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
