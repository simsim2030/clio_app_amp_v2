import 'package:clio_chess_amp_v2/Screens/Login/components/already_have_an_account_check.dart';
import 'package:clio_chess_amp_v2/Screens/Login/login_page.dart';
import 'package:clio_chess_amp_v2/Screens/Signup/components/or_divier.dart';
import 'package:clio_chess_amp_v2/Screens/Signup/components/signup_background.dart';
import 'package:clio_chess_amp_v2/components/buttons/rounded_button.dart';
import 'package:clio_chess_amp_v2/components/fields/rounded_input_field.dart';
import 'package:clio_chess_amp_v2/components/fields/rounded_password_field.dart';
import 'package:clio_chess_amp_v2/components/social_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: size.height * 0.025,
          ),
          Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          // SvgPicture.asset(
          //   "assets/icons/signup.svg",
          //   height: size.height * 0.35,
          // ),
          RoundedInputField(
            hintText: "User Name",
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: "Your Email",
            icon: Icons.email,
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hintText: "Password",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hintText: "Password Confirmation",
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "Sign Up",
            onPressed: () {},
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.of(context).pushNamed(LoginPage.routeName);
            },
          ),
          OrDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SocialIcon(
                iconSrc: "assets/icons/facebook.svg",
                onTap: () {},
              ),
              SocialIcon(
                iconSrc: "assets/icons/twitter.svg",
                onTap: () {},
              ),
              SocialIcon(
                iconSrc: "assets/icons/google-plus.svg",
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
