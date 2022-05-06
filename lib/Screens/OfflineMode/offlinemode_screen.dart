import 'package:clio_chess_amp_v2/Screens/OfflineMode/components/offlinemode_body.dart';
import 'package:flutter/material.dart';

class OfflineModePage extends StatelessWidget {
  static const routeName = '/offlinemode_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: OfflineModeBody(),
    );
  }
}
