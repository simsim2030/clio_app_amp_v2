import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:clio_chess_amp_v2/Screens/Home/components/main_theme_material_app.dart';
import 'package:clio_chess_amp_v2/components/Theme/main_theme.dart';
import 'package:clio_chess_amp_v2/Screens/Home/home_page.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({
    Key? key,
    required this.theme,
    required this.initialStep,
    required this.home,
  }) : super(key: key);

  final MainTheme theme;
  final AuthenticatorStep initialStep;
  final HomePage home;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Authenticator(
      initialStep: initialStep,
      // builder used to show a custom sign in and sign up experience
      authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
        const padding =
            EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
        switch (state.currentStep) {
          case AuthenticatorStep.signIn:
            return Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // app logo
                      Center(
                        child: Image.asset(
                          "assets/images/Knight_background.jpg",
                          height: size.height * 0.3,
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Sign in to continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () => state.changeStep(
                        AuthenticatorStep.signUp,
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            );
          case AuthenticatorStep.signUp:
            return Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // app logo
                      Center(
                        child: Image.asset(
                          "assets/images/Knight_background.jpg",
                          height: size.height * 0.2,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
          default:
            // returning null defaults to the prebuilt authenticator for all other steps
            return null;
        }
      },
      child: MainThemeMaterialApp(
        theme: theme,
        home: home,
      ),
    );
  }
}
