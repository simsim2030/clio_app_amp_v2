import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import '../../components/custom_button_resolver.dart';

// import '../../components/localized_button_resolver.dart';
import '../../pages/home_page.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login_page';

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      // stringResolver: stringResolver,
      signUpForm: SignUpForm.custom(fields: [
        SignUpFormField.username(),
        SignUpFormField.email(required: true),
        SignUpFormField.password(),
        SignUpFormField.passwordConfirmation(),
      ]),
      confirmSignInNewPasswordForm: ConfirmSignInNewPasswordForm.custom(
        fields: [
          ConfirmSignInFormField.newPassword(),
          ConfirmSignInFormField.confirmNewPassword(),
          ConfirmSignInFormField.custom(
            title: 'Zone Info',
            attributeKey: CognitoUserAttributeKey.zoneinfo,
          ),
        ],
      ),
      child: MaterialApp(
        title: 'Clio App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        builder: Authenticator.builder(),
        home: const Scaffold(
          body: Center(
            child: Text('You are logged in!'),
          ),
        ),
      ),
      // initialStep: AuthenticatorStep.signIn,
      // child: MaterialApp(
      //   builder: Authenticator.builder(),
      //   home: HomePage(),
      // ),
    );
  }
}
