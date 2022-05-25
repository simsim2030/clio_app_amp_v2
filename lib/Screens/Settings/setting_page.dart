import 'package:flutter/material.dart';
import '../../components/Drawer/main_drawer.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Setting'),
      ),
    );
  }
}
