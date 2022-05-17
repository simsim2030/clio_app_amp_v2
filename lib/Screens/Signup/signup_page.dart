import 'package:clio_chess_amp_v2/components/Theme/login_signup_theme.dart';
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
    final LoginSignupTheme theme = LoginSignupTheme();
    return Authenticator(
      initialStep: AuthenticatorStep.signUp,
      // builder used to show a custom sign in and sign up experience
      authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
        const padding =
            EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
        switch (state.currentStep) {
          case AuthenticatorStep.signUp:
            return Scaffold(
              body: Padding(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // app logo
                      const Center(child: FlutterLogo(size: 100)),
                      // prebuilt sign up form from amplify_authenticator package
                      SignUpForm(),
                    ],
                  ),
                ),
              ),
              // custom button to take the user to sign in
              persistentFooterButtons: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => state.changeStep(
                        AuthenticatorStep.signIn,
                      ),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            );
          case AuthenticatorStep.signIn:
            return Scaffold(
              body: Padding(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // app logo
                      const Center(child: FlutterLogo(size: 100)),
                      // prebuilt sign in form from amplify_authenticator package
                      SignInForm(),
                    ],
                  ),
                ),
              ),
              // custom button to take the user to sign up
              persistentFooterButtons: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () => state.changeStep(
                        AuthenticatorStep.signUp,
                      ),
                      child: const Text('Sign'),
                    ),
                  ],
                ),
              ],
            );

          default:
            // returning null defaults to the prebuilt authenticator for all other steps
            return null;
        }
      },
      child: MaterialApp(
        theme: theme.customLightTheme,
        darkTheme: theme.customDarkTheme,
        themeMode: ThemeMode.system,
        builder: Authenticator.builder(),
        home: const Scaffold(
          body: Center(
            child: Text('You are logged in!'),
          ),
        ),
      ),
    );
  }
}
