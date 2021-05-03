import 'package:flutter/material.dart';
import 'package:project_lyca/ui/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(SettingsScreen.route());
            },
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Text('Home'),
      ),
    );
  }
}
