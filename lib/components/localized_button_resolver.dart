import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedButtonResolver extends ButtonResolver {
  const LocalizedButtonResolver();

  /// Override the signin function with a localized value
  @override
  String signin(BuildContext context) {
    return AppLocalizations.of(context)!.signin;
  }
}

const stringResolver = AuthStringResolver(
  buttons: LocalizedButtonResolver(),
);
