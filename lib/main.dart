import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

import 'package:clio_chess_amp_v2/Screens/auth/components/auth.dart';
import 'package:clio_chess_amp_v2/components/Theme/main_theme.dart';
import 'package:clio_chess_amp_v2/models/ModelProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Screens/Home/home_page.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
// import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.removeAfter(initialization);

  runApp(ProviderScope(child: MyApp()));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    // AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    Amplify.addPlugin(AmplifyAPI(modelProvider: ModelProvider.instance));

    // await Amplify.addPlugins([authPlugin, analyticsPlugin]);
    await Amplify.addPlugins([storage, authPlugin]);
    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final MainTheme theme = MainTheme();
    final AuthenticatorStep initialStep = AuthenticatorStep.signIn;
    final HomePage home = HomePage();
    return Auth(
      theme: theme,
      initialStep: initialStep,
      home: home,
    );
  }
}
