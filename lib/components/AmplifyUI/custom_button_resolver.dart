import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';

/// Instantiate a ButtonResolver
class CustomButtonResolver extends ButtonResolver {
  const CustomButtonResolver();

  /// Override the signin function
  @override
  String signin(BuildContext context) {
    //the text of the signin button can be customized
    return 'Login to Amplify';
  }
}

/// Instantiate an InputResolver
class CustomInputResolver extends InputResolver {
  const CustomInputResolver();

  /// Override the title function
  /// Since this function handles the title for numerous fields,
  /// we recommend using a switch statement so that `super` can be called
  /// in the default case.
  @override
  String title(BuildContext context, InputField field) {
    switch (field) {
      case InputField.username:
        return 'Custom Username Titl';
      case InputField.email:
        return 'Custom Email Title';
      case InputField.password:
        return 'Custom Password Title';
      case InputField.passwordConfirmation:
        return 'Custom Password Confirmation Title';
      default:
        return super.title(context, field);
    }
  }
}

/// Instantiate an AuthStringResolver with your two custom resolvers
const stringResolver = AuthStringResolver(
  buttons: CustomButtonResolver(),
  inputs: CustomInputResolver(),
);
